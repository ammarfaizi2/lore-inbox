Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTBKMEc>; Tue, 11 Feb 2003 07:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTBKMEc>; Tue, 11 Feb 2003 07:04:32 -0500
Received: from [195.39.17.254] ([195.39.17.254]:20484 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267659AbTBKMEa>;
	Tue, 11 Feb 2003 07:04:30 -0500
Date: Tue, 11 Feb 2003 12:39:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030211113902.GA313@elf.ucw.cz>
References: <200302101905.UAA14874@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302101905.UAA14874@kim.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Also, apic_phys is (or should be) APIC_DEFAULT_PHYS_BASE, so
> >> you shouldn't need to make apic_phys global.
> >
> >Really?
> >
> >        /*
> >         * If no local APIC can be found then set up a fake all
> >         * zeroes page to simulate the local APIC and another
> >         * one for the IO-APIC.
> >         */
> >        if (!smp_found_config && detect_init_APIC()) {
> >                apic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
> >                apic_phys = __pa(apic_phys);
> >        } else
> >                apic_phys = mp_lapic_addr;
> >
> >        set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
> >
> >So it seems to me it really is variable.
> 
> The original code has the property that apic_pm_state.active is
> true if and only if detect_init_APIC() was called and succeeded,
> which implies that apic_phys == mp_lapic_addr == APIC_DEFAULT_PHYS_BASE.
> You can also see that apic_pm_resume() writes APIC_DEFAULT_PHYS_BASE
> to MSR_IA32_APICBASE, which only makes sense in this situation.

Okay, I guess I do not rely on so complicated invariants...

> You moved the apic_pm_state.active = 1 assignment from detect_init_APIC(),
> which is specific to UP_APIC, to setup_local_APIC(), which is called
> also in the SMP case. Do you intend to do suspend and resume on SMP boxes
> as well? If this is intensional, shouldn't device_apic be per-cpu?

Eventually, I do want suspend working on SMP machines, but that's
still quite a long way to go: plan is to hot-unplug all but boot CPUs,
then do suspend, then hot-plug them back.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
