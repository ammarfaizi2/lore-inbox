Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWDZTiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWDZTiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWDZTiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:38:03 -0400
Received: from mga05.intel.com ([192.55.52.89]:33045 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964850AbWDZTiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:38:00 -0400
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28971570:sNHT53707598"
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28971558:sNHT46473049"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28151630:sNHT27540751"
Date: Wed, 26 Apr 2006 12:29:26 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, stern@rowland.harvard.edu, herbert@13thfloor.at,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, ashok.raj@intel.com
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
Message-ID: <20060426122926.A31482@unix-os.sc.intel.com>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org> <1146075534.24650.11.camel@linuxchandra> <20060426114348.51e8e978.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060426114348.51e8e978.akpm@osdl.org>; from akpm@osdl.org on Wed, Apr 26, 2006 at 11:43:48AM -0700
X-OriginalArrivalTime: 26 Apr 2006 19:32:37.0573 (UTC) FILETIME=[2CCC2750:01C66968]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:43:48AM -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> Ashok's the one who has spent most time with this.  Basically _everything_
> to do with register_cpu_notifier() and all the things which call it should
> be __cpuinit and should be tossed away during boot on non-cpu-hotplug
> kernels.
> 
> But there are a few nasty problems with that which made us give up.

I think we got to a reasonable start, until i got busy with other things
and didnt complete it all the way to be ready to submit. There were many files
that got affected, so we thought may be could take smaller steps.

for the above xfs, if you want to avoid the ifdef CONFIG_HOTPLUG_CPU
you could choose to use the hotcpu_notifier() which is null macro when 
CONFIG_HOTPLUG_CPU=n


The problem we ran into was some of the startup code depends on the notifier
call chain for smp bringup, hence we couldn't nuke it similar to 
hotcpu_notifier().

so we ended up calling that function for early risers as 
early_register_cpu_notifier(), and all functions/data with __cpuinit etc to
overcome that issue.

I will try to pursue to again when i get a chance.
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
