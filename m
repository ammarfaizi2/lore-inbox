Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWINPAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWINPAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWINPAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:00:11 -0400
Received: from mga05.intel.com ([192.55.52.89]:52494 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750724AbWINPAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:00:09 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,165,1157353200"; 
   d="scan'208"; a="130406853:sNHT69490778"
Date: Thu, 14 Sep 2006 07:58:16 -0700
From: Mark Gross <mgross@linux.intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <eugeny.mints@gmail.com>,
       Matthew Locke <matt@nomadgs.com>, Greg KH <greg@kroah.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       pm list <linux-pm@lists.osdl.org>,
       Preece Scott-PREECE <scott.preece@motorola.com>,
       Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Message-ID: <20060914145816.GA6008@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz> <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com> <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912083328.GA19197@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912083328.GA19197@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 10:33:28AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > >No, there is reason to keep that in kernel -- so that cpufreq
> > > > >userspace interface can be kept, and so that resulting kernel<->user
> > > > >interface is not ugly.
> > > > Cpuferq defines cpufreq_frequency_table structure in arch independent 
> > > > header while it's arch dependent data structure. A lot of code is built 
> > > > around this invalid basic brick and therefore is invalid: cpufreq tables, 
> > > > interface with cpu freq drivers, etc. Notion of transition latency as it 
> > > > defined by cpufreq is wrong because it's not a function of cpu type but 
> > > > function of current and next operating point. no runtime control on 
> > > > operating points set. it's always the same set of operating points for all 
> > > > system cpus in smp case and no way to define different sets or track any 
> > > > dependencies in case say multi core cpus. insufficient kernel<->user space 
> > > > interface to handle embedded requirements and no way to extend it within 
> > > > current design. Shall I continue?  Why should then anyone want to keep 
> > > > cpufreq userspace interface just due to keep it?
> > > 
> > > Yes, please continue. I do not think we can just rip cpufreq interface
> > > out of kernel, and I do not think it is as broken as you claim it
> > > is. Ripping interface out of kernel takes years.
> > > 
> > > I'm sure cpufreq_frequency_table could be moved to asm/ header if you
> > > felt strongly about that.
> > > 
> > > I believe we need to fix cpufreq if it is broken for embedded
> > > cases.
> > 
> > cpufreq is broken at the cpufreq_driver interface for embedded
> > applications needing control over more than one control variable at a
> > time.
> > 
> > That interface only supports setting target frequencies, and expanding it
> > to set target frequencies and voltages is not possible without something
> > like PowerOP.  Adding the types of parameters to cpufreq would likely
> > make cpufreq a mess.
> 
> Can we at least try adding that, before deciding cpufreq is unsuitable
> and starting new interface? I do not think issues are nearly as big as
> you think.. (at user<->kernel interface level, anyway; you'll need big
> changes under the hood).

We are trying.  The PowerOP patches from Matt and Eugeny start to put
into place some of the kernel mode plumbing for this in a way that
avoids thrashing the existing models, and it addresses the needs of the
operating point PM community.  Which is large in the CE and Embedded
camps.

--mgross
