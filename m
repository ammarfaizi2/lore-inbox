Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267203AbUFZRjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267203AbUFZRjC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbUFZRjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:39:02 -0400
Received: from smtp807.mail.ukl.yahoo.com ([217.12.12.197]:2464 "HELO
	smtp807.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267203AbUFZRi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:38:58 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Assuming someone else called the IRQ
Date: Sat, 26 Jun 2004 18:39:39 +0100
User-Agent: KMail/1.6.52
References: <200406261808.31860.s0348365@sms.ed.ac.uk> <20040626181552.C30532@flint.arm.linux.org.uk>
In-Reply-To: <20040626181552.C30532@flint.arm.linux.org.uk>
Cc: mcgrof@ruslug.rutgers.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406261839.39274.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 June 2004 18:15, Russell King wrote:
> On Sat, Jun 26, 2004 at 06:08:31PM +0100, Alistair John Strachan wrote:
> > Every kernel in the 2.6 serious so far has exhibited the same problem;
> > after some time of running my desktop system, I get:
> >
> > Assuming someone else called the IRQ
> >...
> >  19:    8748235   IO-APIC-level  ohci1394, yenta, eth0
>
> You don't say what eth0 is.  At a guess, it's a prism54 card, because the
> only place I find that message in the kernel is in the prism54 driver:
>
> drivers/net/wireless/prism54/islpci_dev.c:
> 	printk(KERN_DEBUG "Assuming someone else called the IRQ\n");
>

Yes.

> I'd imagine that the OHCI1394 generates a fair number of interrupts,
> so... this highlights the problem of leaving debugging printk's,
> even at KERN_DEBUG level in a driver interrupt path.

I would agree.

>
> At a guess, Luis R. Rodriguez may be the maintainer for prism54,
> so...

Luis, could you please look into removing this message from the sources. It 
causes my kernel ring buffer to be wiped fairly quickly, which is annoying 
for debugging development kernels.

[OT] Thanks for the reply Russell. Any chance you could look over the BIOS 
workaround on bugzilla while we're discussing PCMCIA? I put a patch on there 
that's probably a load of nonsense, and we still haven't got your opinion on 
the matter..

http://bugzilla.kernel.org/show_bug.cgi?id=1840

It affects very few people, but it's a safe enough workaround as I'm using it 
successfully as I write this.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
