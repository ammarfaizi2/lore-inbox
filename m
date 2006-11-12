Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932894AbWKLNh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbWKLNh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbWKLNh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:37:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41479 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932894AbWKLNh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:37:56 -0500
Date: Sun, 12 Nov 2006 14:37:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-ID: <20061112133759.GK25057@stusta.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org> <20061111100038.6277efd4.akpm@osdl.org> <1163268603.3293.45.camel@laptopd505.fenrus.org> <20061111101942.5f3f2537.akpm@osdl.org> <1163332237.3293.100.camel@laptopd505.fenrus.org> <20061112125357.GH25057@stusta.de> <1163337376.3293.120.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163337376.3293.120.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 02:16:16PM +0100, Arjan van de Ven wrote:
> 
> > Some APIC-related bugs in the kernel Bugzilla that have been reported or 
> > confirmed during the last 12 months (I only looked at "apic" in the 
> > subject, there might be more related bugs in the Bugzilla):
> > 
> > #5038 Fast running system clock with IO-APIC enabled
> 
> This is a UP machine. NotInteresting(tm) wrt APIC.
>... 

Currently it's a supported configuration.

We must either handle such cases or explicitely disable the APIC on all 
UP machines (BTW: Is there any way to handle this when installing a 
distribution kernel with CONFIG_HOTPLUG_CPU=y on an UP machine?).

> > > 1) Only care about SMP machines. APIC on true UP (no
> > > Hyperthreading/Dualcore) is a thing no hardware vendor tests (Microsoft
> > > doesn't use it) and is just too likely to trip up SMM and other bad BIOS
> > > stuff. 
> > >  * exception is probably people who don't WANT to use apic but where it
> > > somehow gets used anyway; if that happens we probably have the magic
> > > bullet that causes the regression :)
> > 
> > On i386, it's a kernel configuration option.
> 
> yes but it's generally a bad idea to set it; it only works on some
> machines. (and it can't be fixed)
> > 
> > On x86_64, the APIC is currently always enabled even when configuring a 
> > UP kernel.
> 
> I think that's a mistake. But oh well, I suspect in practice ACPI/BIOS
> cause it to be turned off automatic most of the time.

I'd doubt the latter. Even on my cheap Asus board running an i386
AMD Athlon XP with 1.8 GHz the APIC is both used and working without any
problems.

> > > 2) Only care about ACPI using kernels. Non-ACPI uses MPS tables for
> > > this, but most vendors hardly maintain those anymore at all and they are
> > > generally just /dev/random nowadays
> > 
> > What about non-ACPI SMP?
> 
> if the machine is new enough to run ACPI I don't care about the non-ACPI
> case; just enable it. Really. On newish machines (and that is 7 years
> old or newer) MPS tables are NOT getting much if any attention by the
> bios guys. So Linux should use ACPI, and if you deliberately disable
> ACPI and THEN hit a problem to a large degree you asked for the problem
> in the first place.
> 
> Older machines, different story.

My point was regarding the latter ones...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

