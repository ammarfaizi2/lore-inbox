Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVGLByJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVGLByJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGLByJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 21:54:09 -0400
Received: from mx1.rowland.org ([192.131.102.7]:8198 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S261392AbVGLByI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 21:54:08 -0400
Date: Mon, 11 Jul 2005 21:54:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507112334.30680@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507112142420.7520-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Michel Bouissou wrote:

> Le Lundi 11 Juillet 2005 23:21, Alan Stern a écrit :
> > Don't jump to hasty conclusions.  Problems like this are often caused by
> > unrelated things that you wouldn't suspect at first.
> 
> I know... Been working with computers for... Uh... 25 years ?

35 years for me...  My, how the time flies!

> I don't believe the hardware is broken, as it's been running for more than 2 
> years 100% stable with a 24/7/365 uptime. And with me plugging and unplugging 
> USB devices...
> 
> Never had a single problem of the kind with any 2.4.x kernel. Get those 
> problems only with 2.6.x kernels, and, in 2.6.12, only when UP IO-APIC is 
> enabled (which ran perfectly good in 2.4).
> 
> So the problem is circled to 2.6 kernel, uhci_hcd and UP IO-APIC.

Don't rule out the hardware too quickly.  2.4 and 2.6 manage the UHCI
controllers in different ways.  In particular, the usb-uhci driver in 2.4
does not suspend the controller when no devices are attached, whereas
uhci-hcd in 2.6 does.  (So does the "alternate" uhci driver in 2.4.)  I
recently handled a bug report -- from another Frenchman -- where it turned
out that his UHCI hardware instantly crashed the entire system whenever
it resumed from the suspended state!

To try and help pin things down, tomorrow (i.e., Tuesday) I'll send you a
test patch to completely disable the UHCI controllers, leaving them awake
and idle, not generating interrupts.  If you still get those spurious
IRQs, they will have to come from somewhere else.  (Assuming you can
devote server time to this sort of testing...)

And of course, if the spurious IRQs stop then we'll know where to probe 
further.

Alan Stern

