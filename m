Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWDZUaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWDZUaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWDZUaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:30:00 -0400
Received: from mga06.intel.com ([134.134.136.21]:21127 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964871AbWDZU37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:29:59 -0400
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28175236:sNHT48081082"
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28996935:sNHT3316920649"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28175220:sNHT49095172"
Date: Wed, 26 Apr 2006 13:26:45 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, herbert@13thfloor.at,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
Message-ID: <20060426132644.A31761@unix-os.sc.intel.com>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org> <1146075534.24650.11.camel@linuxchandra> <20060426114348.51e8e978.akpm@osdl.org> <20060426122926.A31482@unix-os.sc.intel.com> <1146082893.24650.27.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1146082893.24650.27.camel@linuxchandra>; from sekharan@us.ibm.com on Wed, Apr 26, 2006 at 01:21:33PM -0700
X-OriginalArrivalTime: 26 Apr 2006 20:29:56.0207 (UTC) FILETIME=[2E620FF0:01C66970]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:21:33PM -0700, Chandra Seetharaman wrote:
> > 
> > The problem we ran into was some of the startup code depends on the notifier
> > call chain for smp bringup, hence we couldn't nuke it similar to 
> > hotcpu_notifier().
> 
> I do not understand the problem. If everybody that uses
> register_cpu_notifier() starts using __cpuinit and __cpuinitdata (or the
> devinit siblings), then the notifier mechanism will not be any different
> than what they are now, right ? (both in hotplug cpu and non-hotplug cpu
> case) Or am i missing something ?

Well, register_cpu_notifier() is an exported function. There are several 
modules that use this today like cpufreq etc which disqualifies it to be
a init style function.

either that function should be devinit and be present premanently, or
should be mapped to null macro for correctness.

Otherwise module loaders will start to oops when they call into 
register.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
