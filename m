Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWILId2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWILId2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWILId2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:33:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31906 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965066AbWILId1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:33:27 -0400
Date: Tue, 12 Sep 2006 10:33:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Gross <mgross@linux.intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <eugeny.mints@gmail.com>,
       Matthew Locke <matt@nomadgs.com>, Greg KH <greg@kroah.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       pm list <linux-pm@lists.osdl.org>,
       Preece Scott-PREECE <scott.preece@motorola.com>,
       Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Message-ID: <20060912083328.GA19197@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz> <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com> <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912001701.GC14234@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >No, there is reason to keep that in kernel -- so that cpufreq
> > > >userspace interface can be kept, and so that resulting kernel<->user
> > > >interface is not ugly.
> > > Cpuferq defines cpufreq_frequency_table structure in arch independent 
> > > header while it's arch dependent data structure. A lot of code is built 
> > > around this invalid basic brick and therefore is invalid: cpufreq tables, 
> > > interface with cpu freq drivers, etc. Notion of transition latency as it 
> > > defined by cpufreq is wrong because it's not a function of cpu type but 
> > > function of current and next operating point. no runtime control on 
> > > operating points set. it's always the same set of operating points for all 
> > > system cpus in smp case and no way to define different sets or track any 
> > > dependencies in case say multi core cpus. insufficient kernel<->user space 
> > > interface to handle embedded requirements and no way to extend it within 
> > > current design. Shall I continue?  Why should then anyone want to keep 
> > > cpufreq userspace interface just due to keep it?
> > 
> > Yes, please continue. I do not think we can just rip cpufreq interface
> > out of kernel, and I do not think it is as broken as you claim it
> > is. Ripping interface out of kernel takes years.
> > 
> > I'm sure cpufreq_frequency_table could be moved to asm/ header if you
> > felt strongly about that.
> > 
> > I believe we need to fix cpufreq if it is broken for embedded
> > cases.
> 
> cpufreq is broken at the cpufreq_driver interface for embedded
> applications needing control over more than one control variable at a
> time.
> 
> That interface only supports setting target frequencies, and expanding it
> to set target frequencies and voltages is not possible without something
> like PowerOP.  Adding the types of parameters to cpufreq would likely
> make cpufreq a mess.

Can we at least try adding that, before deciding cpufreq is unsuitable
and starting new interface? I do not think issues are nearly as big as
you think.. (at user<->kernel interface level, anyway; you'll need big
changes under the hood).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
