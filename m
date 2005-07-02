Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVGBRoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVGBRoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGBRoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:44:16 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:54681 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261241AbVGBRnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:43:51 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Sean Bruno <sean.bruno@dsl-only.net>
Subject: Re: ASUS K8N-DL Beta BIOS
Date: Sat, 2 Jul 2005 18:43:45 +0100
User-Agent: KMail/1.8.1
Cc: "Hodle, Brian" <BHodle@harcroschem.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'ipsoa@posiden.hopto.org'" <ipsoa@posiden.hopto.org>,
       Andi Kleen <ak@muc.de>
References: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1> <1120246927.2764.26.camel@home-lap>
In-Reply-To: <1120246927.2764.26.camel@home-lap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507021843.45450.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 Jul 2005 20:42, Sean Bruno wrote:
> On Fri, 2005-07-01 at 14:19 -0500, Hodle, Brian wrote:
> > Sean,
> >    You might get a laugh out of this! It's a reply from ASUS about the
> > motherboard (this was 2 days b4 they released the 1004.7 BETA BIOS.
> >
> > Pretty sad when ASUS tells you to "Clear your CMOS". I thought I asked a
> > pretty straightforward tech question... Makes me wonder if they even read
> > it, or they had a PERL script do it!
> >
> > Ps. New BIOS didn't change a thing. The PCI Device names in the ACPI
> > table are not entered in a fashion that the kernel recognizes. Maybe ASUS
> > decided to 'optimize' routing by making a more efficient table?' nah..
> >
> > Cheers,
> >
> > -Brian
>
> This is pretty much the reaction that I am getting from calling ASUS
> tech support.  They have told me on several occasions that they will
> "call me back" and never do.  I am fairly certain that there is a
> problem with the BIOS, but the kernel could be modified to ignore the
> issue as a backup plan.
>
> I received some insight from an individual at Nvidia that looks
> something like this:
>
> There are several issues immediately apparent with the BIOS.
>
> It has an ACPI interrupt override for IRQ0 to Global System Interrupt 2
> (GSI 2) that is incorrect -
>
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>
> and is the root cause of the later warnings to do with the timer:
>
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> timer doesn't work through the IO-APIC - disabling NMI Watchdog!
> ...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for
> unknown reason 3d.
> Dazed and confused, but trying to continue
> Do you have a strange power saving mode enabled?
>  failed.
> ...trying to set up timer as ExtINT IRQ... works.
>
> The Linux kernel (2.6.9 onwards) contains code to specifically detect
> this interrupt redirect on NVIDIA hardware, and ignore it, but for some
> reason it isn't kicking in on your setup. Not sure why that is.

(Added Andi Kleen CC).

This is the exact problem I reported to Andi just after 2.6.12 was released. 
My MSI nForce3 board didn't work with the override either, and my buggy BIOS 
wasn't detected by the override (even though it should have been).

Fortunately MSI apparently fixed this before ASUS because the latest BIOS 
(1.17 or something) corrects the flaw.

I can't really remember whether the detection problem was resolved; my 
specific (APIC related) issue was.

Andi?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
