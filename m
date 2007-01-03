Return-Path: <linux-kernel-owner+w=401wt.eu-S932131AbXACXHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbXACXHH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXACXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:07:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4996 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932131AbXACXHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:07:05 -0500
Date: Thu, 4 Jan 2007 00:07:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20070103230708.GM20714@stusta.de>
References: <20061220140500.GB30752@frankl.hpl.hp.com> <20061220210514.42ed08cc.akpm@osdl.org> <20061221091242.GA32601@frankl.hpl.hp.com> <20061222010641.GK6993@stusta.de> <20061222100700.GB1895@frankl.hpl.hp.com> <20061223114015.GQ6993@stusta.de> <20070103132015.GE7238@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103132015.GE7238@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 05:20:15AM -0800, Stephane Eranian wrote:
> Adrian,
> 
> On Sat, Dec 23, 2006 at 12:40:15PM +0100, Adrian Bunk wrote:
> > > 
> > > If you look at the perfmon-new-base patch, you'll see a base.diff patch which
> > > includes this one. I am slowly getting rid of this requirement by pushing
> > > those "infrastructure patches" to mainline so that the perfmon patch gets
> > > smaller over time. Submitting smaller patches makes it easier for maintainers
> > > to integrate.
> > 
> > No, the preferred way is to start with getting both the infrastructure 
> > and the users into -mm.
> > 
> > Adding infrastructure without users doesn't fit into the kernel 
> > development model.
> 
> I am hearing conflicting opinions on this one.
> 
> Perfmon is a fairly big patch. It is hard to take it as one. I have tried to
> split it up in smaller, more manageable pieces as requested by top-level
> maintainers. This process implies that I supply small patches which may not
> necessarily have users just yet.

There should be a big patchset consisting of manageable pieces, if 
possible all of it in -mm.

> > The unused x86-64 idle notifiers are now bloating the kernel since 
> > nearly one year.
> > 
> > > > And why does it bloat the kernel with EXPORT_SYMBOL's although even your 
> > > > perfmon-new-base-061204 doesn't seem to add any modular user?
> > > 
> > Where does the perfmon code use the EXPORT_SYMBOL's?
> 
> The perfmon patch includes several kernel modules which make use of
> the exported entry points. The following symbols are exported:
> 
> pfm_pmu_register/pfm_pmu_unregister:
> 	* PMU description module registration.
> 	* Used to describe PMU model.
> 	* Used by perfmon_p4.c, perfmon_core.c, perfmon_mckinley.c, and others
> 
> pfm_fmt_register/pfm_fmt_unregister:
> 	* Sampling format module registration
> 	* Used by perfmon_dfl_smpl.c, perfmon_pebs_smpl.c
> 
> pfm_interrupt_handler:
> 	* PMU interrupt handler
> 	* Used by MIPS-specific perfmon code
> 
> pfm_pmu_conf/pfm_controls:
> 	* global state/control variable
> 
> All exported symbols are currently used. Why are you saying this adds bloat?

Which module uses idle_notifier_register/idle_notifier_unregister?

> -Stephane

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

