Return-Path: <linux-kernel-owner+w=401wt.eu-S1161053AbXAEK5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbXAEK5A (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbXAEK5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:57:00 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:59319 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161053AbXAEK47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:56:59 -0500
Date: Fri, 5 Jan 2007 02:55:14 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20070105105514.GF10599@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061220140500.GB30752@frankl.hpl.hp.com> <20061220210514.42ed08cc.akpm@osdl.org> <20061221091242.GA32601@frankl.hpl.hp.com> <20061222010641.GK6993@stusta.de> <20061222100700.GB1895@frankl.hpl.hp.com> <20061223114015.GQ6993@stusta.de> <20070103132015.GE7238@frankl.hpl.hp.com> <20070103230708.GM20714@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103230708.GM20714@stusta.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On Thu, Jan 04, 2007 at 12:07:08AM +0100, Adrian Bunk wrote:
> > I am hearing conflicting opinions on this one.
> > 
> > Perfmon is a fairly big patch. It is hard to take it as one. I have tried to
> > split it up in smaller, more manageable pieces as requested by top-level
> > maintainers. This process implies that I supply small patches which may not
> > necessarily have users just yet.
> 
> There should be a big patchset consisting of manageable pieces, if 
> possible all of it in -mm.
> 

I have already split up the pieces: generic vs. per-arch. I have also
divided it between modified vs. new files. It becomes harder to go
much beyond that without creating also one patch per modified file.

> > > The unused x86-64 idle notifiers are now bloating the kernel since 
> > > nearly one year.
> > > 
> > > > > And why does it bloat the kernel with EXPORT_SYMBOL's although even your 
> > > > > perfmon-new-base-061204 doesn't seem to add any modular user?
> > > > 
> > > Where does the perfmon code use the EXPORT_SYMBOL's?
> > 
> > The perfmon patch includes several kernel modules which make use of
> > the exported entry points. The following symbols are exported:
> > 
> > pfm_pmu_register/pfm_pmu_unregister:
> > 	* PMU description module registration.
> > 	* Used to describe PMU model.
> > 	* Used by perfmon_p4.c, perfmon_core.c, perfmon_mckinley.c, and others
> > 
> > pfm_fmt_register/pfm_fmt_unregister:
> > 	* Sampling format module registration
> > 	* Used by perfmon_dfl_smpl.c, perfmon_pebs_smpl.c
> > 
> > pfm_interrupt_handler:
> > 	* PMU interrupt handler
> > 	* Used by MIPS-specific perfmon code
> > 
> > pfm_pmu_conf/pfm_controls:
> > 	* global state/control variable
> > 
> > All exported symbols are currently used. Why are you saying this adds bloat?
> 
> Which module uses idle_notifier_register/idle_notifier_unregister?
> 
None.

I have no issue with removing the EXPORT_SYMBOL on i386 and x86_64 if you
think that would help.

-- 
-Stephane
