Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277503AbRJERGo>; Fri, 5 Oct 2001 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277498AbRJERGe>; Fri, 5 Oct 2001 13:06:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10805 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277505AbRJERGY>; Fri, 5 Oct 2001 13:06:24 -0400
To: jdthood@home.dhs.org (Thomas Hood)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011003153550.0A0D85AC@thanatos.toad.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Oct 2001 10:57:12 -0600
In-Reply-To: <20011003153550.0A0D85AC@thanatos.toad.net>
Message-ID: <m1vghuxbx3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdthood@home.dhs.org (Thomas Hood) writes:

> Stelian Pop wrote:
> >> Well, the funny thing is, the same kernel doesn't boot on a Dell Inspiron 
> >> laptop either, if PNP is enabled -- and the oops is the same. So it's not 
> >> just Sony...
> >
> >Maybe we'll need to test against something like 'pnp_broken' 
> >variable instead of is_sony_vaio_laptop in PnP drivers, and
> >add the callbacks in dmi_scan to initialize pnp_broken...
> 
> Yes, the "pnp_bios_dont_use_current_config" flag in the driver
> can be set based on additional criteria.
> 
> I notice that both the Vaio and the Inspiron have Phoenix BIOSes.
> So perhaps there is a class of Phoenix BIOSes we should be testing
> for.  For the time being, we will need to add Ion Badulescu's Inspiron
> to the dmi_blacklist.  Ion, can you give us the exact product name,
> exact BIOS vendor name, exact BIOS version and exact BIOS date?
> Also, let us know all the results of your tests of various kernels.
> 
> It's interesting to note that my IBM ThinkPad BIOS has a bug that
> is similar to the bug in your BIOS.  After Linux is run, on the
> subsequent boot the "current" config is not initialized from the
> "boot" config; instead, all devices are left disabled.  This does
> not happen if Windows was the previous OS run, or if the BIOS
> is initialized before the boot.  My sneaking suspicion is that this
> behavior is a "feature" of the BIOS: when certain of its functions
> are accessed it deduces that it is being used by a Plug-n-Play
> operating system (tm) and so refrains from configuring devices other
> than the vital ones.  

Hmm. If you are using an AC kernel I seriously suspect the bootflag code,
because that is what the code is telling the BIOS to do explicitly.

> My workaround for now is to use "setpnp" to
> switch on all the configurable devices.  The "right" solution may
> be to use the ESCD functions of the BIOS.  Or it may be to stop
> doing whatever it is that suggests to the BIOS that Linux is a
> PnP OS.

Suggests.  With the bootflag stuff we are saying treat as a pnpos we
know what we are doing.

Eric



