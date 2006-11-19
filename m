Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933157AbWKSUY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157AbWKSUY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933160AbWKSUYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:24:55 -0500
Received: from h155.mvista.com ([63.81.120.155]:55725 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933157AbWKSUYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:24:55 -0500
Message-ID: <4560BDF5.400@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:26:29 +0300
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
References: <200611192243.34850.sshtylyov@ru.mvista.com>	 <1163966437.5826.99.camel@localhost.localdomain>	 <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain>
In-Reply-To: <1163967590.5826.104.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>>>Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi 
>>>handler is being changed and what is the rationale for adding an ack 
>>>that was not necessary before ?

>>dont worry, it's -rt only stuff.

> Still, I'm curious :-) Besides, there have been people talking about
> having -rt work on ppc64 so ...

> What do you need an ack() for on fasteoi ? On all fasteoi controllers I
> have, ack is implicit by obtaining the vector number and all there is is
> an eoi...

    I must not that this whole ack() vs eoi() stuff is misleading. For example,
in 8259 driver, mask_ack() method actually sends EOI to PIC, not ACK's an IRQ 
-- the actual ACK is implicit on x86 and is used to read the interrupt vector 
form 8259 on PPC. So, IMO, there probably should only have been either ack() 
or eoi() method in the first place. Though I'm not familiar with ARM from 
which genirq stuff originated...

> Cheers,
> Ben.

WBR, Sergei
