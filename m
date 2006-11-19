Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933234AbWKSUcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234AbWKSUcw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933213AbWKSUcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:32:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:64165 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933234AbWKSUcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:32:50 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <4560BDF5.400@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <4560BDF5.400@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:32:56 +1100
Message-Id: <1163968376.5826.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 23:26 +0300, Sergei Shtylyov wrote:

>     I must not that this whole ack() vs eoi() stuff is misleading. For example,
> in 8259 driver, mask_ack() method actually sends EOI to PIC, not ACK's an IRQ 
> -- the actual ACK is implicit on x86 and is used to read the interrupt vector 
> form 8259 on PPC. So, IMO, there probably should only have been either ack() 
> or eoi() method in the first place. Though I'm not familiar with ARM from 
> which genirq stuff originated...

They are different concepts. Ack clears the event on the PIC, it's
tyically necessary for resetting the edge detection logic for edge
interrupts and has to happen before the handler is called.

On MPIC or XICS, this is implicit by reading the vector. On some more
dumb controllers, this has to be done explicitely.

EOI is a more "high level" thing that some "intelligent" PICs that
automatically raise the priority do to restore the priority to what it
was before the interrupt occured.

Ben.



