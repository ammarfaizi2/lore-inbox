Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932893AbWKLMxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbWKLMxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWKLMxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:53:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2311 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932893AbWKLMxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:53:54 -0500
Date: Sun, 12 Nov 2006 13:53:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-ID: <20061112125357.GH25057@stusta.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org> <20061111100038.6277efd4.akpm@osdl.org> <1163268603.3293.45.camel@laptopd505.fenrus.org> <20061111101942.5f3f2537.akpm@osdl.org> <1163332237.3293.100.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163332237.3293.100.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 12:50:37PM +0100, Arjan van de Ven wrote:
> 
> > I don't know.  In fact I forget how I worked out that it worsened in
> > 2.6.early.
> > 
> > google(noapic) gets 232,000 hits.
> 
> is there a way to ask google "only stuff in the last year"?
> Asking because "noapic" in 2.4 was the standard "try this" answer when
> people had a bios that had busted MPS (but good ACPI)...

Some APIC-related bugs in the kernel Bugzilla that have been reported or 
confirmed during the last 12 months (I only looked at "apic" in the 
subject, there might be more related bugs in the Bugzilla):

#5038 Fast running system clock with IO-APIC enabled
#5303 AMD64 Erratum: Should not enable C2 when using APIC
#5565 Guess of i386 APIC PTE area scribble
#6404 APIC error on CPU0: 40(40)
#6748 Clock drifts by 30% for SMP kernel w/APIC
#6859 Linux kernel won't work without "nolapic" passed
#6890 Kernel boot freezes when APIC is enabled & SATA is used

> > I don't think it really matters when or why it happened. 
> 
> well to some degree it does; if it's one patch causing it narrowing it
> down at least somewhat in time would help ;)
> 
> >  If we take the
> > approach of fixing one machine at a time, we'll only need to fix a few
> > individual machines to improve the situation for a lot of people.
> 
> alternative is that more new machines showed up that need it somehow, eg
> not really a regression just something else. Different approach is
> needed for hunting that down. But to be realistic we need to narrow
> things down a bit, which means
> 
> 1) Only care about SMP machines. APIC on true UP (no
> Hyperthreading/Dualcore) is a thing no hardware vendor tests (Microsoft
> doesn't use it) and is just too likely to trip up SMM and other bad BIOS
> stuff. 
>  * exception is probably people who don't WANT to use apic but where it
> somehow gets used anyway; if that happens we probably have the magic
> bullet that causes the regression :)

On i386, it's a kernel configuration option.

On x86_64, the APIC is currently always enabled even when configuring a 
UP kernel.

> 2) Only care about ACPI using kernels. Non-ACPI uses MPS tables for
> this, but most vendors hardly maintain those anymore at all and they are
> generally just /dev/random nowadays

What about non-ACPI SMP?

> 3) Ignore overclocking; if you overclock using the FSB the apic busses
> run out of spec as well; can be a huge timewaster in debug time.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

