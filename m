Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933245AbWKSUid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbWKSUid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWKSUid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:38:33 -0500
Received: from h155.mvista.com ([63.81.120.155]:1198 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933245AbWKSUic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:38:32 -0500
Message-ID: <4560C121.30403@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:40:01 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	 <1163966437.5826.99.camel@localhost.localdomain>	 <20061119200650.GA22949@elte.hu>	 <1163967590.5826.104.camel@localhost.localdomain>	 <4560BDF5.400@ru.mvista.com> <1163968376.5826.110.camel@localhost.localdomain>
In-Reply-To: <1163968376.5826.110.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>    I must not that this whole ack() vs eoi() stuff is misleading. For example,
>>in 8259 driver, mask_ack() method actually sends EOI to PIC, not ACK's an IRQ 
>>-- the actual ACK is implicit on x86 and is used to read the interrupt vector 
>>form 8259 on PPC. So, IMO, there probably should only have been either ack() 
>>or eoi() method in the first place. Though I'm not familiar with ARM from 
>>which genirq stuff originated...

> They are different concepts. Ack clears the event on the PIC, it's
> tyically necessary for resetting the edge detection logic for edge
> interrupts and has to happen before the handler is called.

    I know 8259. :-)
    It also resets the corresponding IRQ bit in IRR, and sets it in ISR where 
it's then cleared on EOI command.

> On MPIC or XICS, this is implicit by reading the vector. On some more
> dumb controllers, this has to be done explicitely.

    This is not implicit -- CPU has to read INTACK reg. on OpenPIC. Really 
implicit method is in action on x86 where CPU issues dual ACK bus cycle to get 
the vector form 8259...

> EOI is a more "high level" thing that some "intelligent" PICs that
> automatically raise the priority do to restore the priority to what it
> was before the interrupt occured.

    Thank you, I know. Even 8259 has the notion of priority and EOI works the 
same way here.

> Ben.

WBR, Sergei
