Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424366AbWKJGTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424366AbWKJGTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966097AbWKJGTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:19:16 -0500
Received: from mail.suse.de ([195.135.220.2]:49094 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966046AbWKJGTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:19:15 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid problem
Date: Fri, 10 Nov 2006 07:19:07 +0100
User-Agent: KMail/1.9.5
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       fbuihuu@gmail.com, adaplas@pol.net, NeilBrown <neilb@suse.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611100549.08239.ak@suse.de> <20061109211523.7abfd4ec.akpm@osdl.org>
In-Reply-To: <20061109211523.7abfd4ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100719.07969.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 06:15, Andrew Morton wrote:
> On Fri, 10 Nov 2006 05:49:08 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > 
> > > > > 
> > > > > Well, I've got some data from earlyprintk (forgot I needed to boot with
> > > > > vga=normal).
> > > > > 
> > > > > Unfortunately, I had to rewrite the trace manually:
> > > > > 
> > > > > clear_IO_APIC_pin+0x15/0x6a
> > > > > try_apic_pin+0x7a/0x98
> > > > > setup_IO_APIC+0x600/0xb7a
> > > > > smp_prepare_cpus+0x33a/0x371
> > > > > init+0x60/0x32d
> > > > > child_rip+0xa/0x12
> > > > > 
> > > > > [And then the unwinder said it got stuck.]
> > > > > 
> > > > > RIP is reported to be at ioapic_read_entry+0x33/0x61,
> > > > 
> > > > This is 100% reproducible on the nx6325 (but not on the other boxes) and
> > > > apparently caused by x86_64-mm-try-multiple-timer-pins.patch (doesn't
> > > > happen with this patch reverted).
> > > 
> > > Thanks, dropped.
> > 
> > can I have details please? 
> 
> I think what's in this thread is all you'll get.

That's probably not enough then.


> 
> It would be nice to see the access address.  I'd be guessing that it's
> trying to read the io-apic before we're ready to read it and io_apic_base()
> is returning gunk and boom.

I would like to see the full output from the earlyprintk crash please.
.jpg would be ok.

> 
> > On what system (CPU, motherboard, BIOS version) does the noidlehz stuff break?
> 
> nx6325

Ah -- it seems to be an ATI chipset. I tested it on a ATI chipset machine
here so it must be doing something strange.

Anyways, you most likely broke a wide range of other motherboards again
by dropping it.

> 
> It's x86_64: no noidlehz.
> 
> > And what did you drop exactly?
> 
> x86_64-mm-try-multiple-timer-pins.patch

Ah that was the information I was missing. 

-Andi

