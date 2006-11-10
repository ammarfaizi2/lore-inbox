Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424309AbWKJFPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424309AbWKJFPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWKJFPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:15:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945976AbWKJFPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:15:50 -0500
Date: Thu, 9 Nov 2006 21:15:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       fbuihuu@gmail.com, adaplas@pol.net, NeilBrown <neilb@suse.de>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid
 problem
Message-Id: <20061109211523.7abfd4ec.akpm@osdl.org>
In-Reply-To: <200611100549.08239.ak@suse.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611091642.01453.rjw@sisk.pl>
	<20061109095811.ac654e13.akpm@osdl.org>
	<200611100549.08239.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 05:49:08 +0100
Andi Kleen <ak@suse.de> wrote:

> 
> > > > 
> > > > Well, I've got some data from earlyprintk (forgot I needed to boot with
> > > > vga=normal).
> > > > 
> > > > Unfortunately, I had to rewrite the trace manually:
> > > > 
> > > > clear_IO_APIC_pin+0x15/0x6a
> > > > try_apic_pin+0x7a/0x98
> > > > setup_IO_APIC+0x600/0xb7a
> > > > smp_prepare_cpus+0x33a/0x371
> > > > init+0x60/0x32d
> > > > child_rip+0xa/0x12
> > > > 
> > > > [And then the unwinder said it got stuck.]
> > > > 
> > > > RIP is reported to be at ioapic_read_entry+0x33/0x61,
> > > 
> > > This is 100% reproducible on the nx6325 (but not on the other boxes) and
> > > apparently caused by x86_64-mm-try-multiple-timer-pins.patch (doesn't
> > > happen with this patch reverted).
> > 
> > Thanks, dropped.
> 
> can I have details please? 

I think what's in this thread is all you'll get.

It would be nice to see the access address.  I'd be guessing that it's
trying to read the io-apic before we're ready to read it and io_apic_base()
is returning gunk and boom.

> On what system (CPU, motherboard, BIOS version) does the noidlehz stuff break?

nx6325

It's x86_64: no noidlehz.

> And what did you drop exactly?

x86_64-mm-try-multiple-timer-pins.patch
