Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWD1XME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWD1XME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWD1XME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:12:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60873 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932486AbWD1XMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:12:03 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: Ashok Raj <ashok.raj@intel.com>, Alan Stern <stern@rowland.harvard.edu>,
       herbert@13thfloor.at, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com
In-Reply-To: <20060426132644.A31761@unix-os.sc.intel.com>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
	 <1146075534.24650.11.camel@linuxchandra>
	 <20060426114348.51e8e978.akpm@osdl.org>
	 <20060426122926.A31482@unix-os.sc.intel.com>
	 <1146082893.24650.27.camel@linuxchandra>
	 <20060426132644.A31761@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 28 Apr 2006 16:12:00 -0700
Message-Id: <1146265920.7063.133.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 13:26 -0700, Ashok Raj wrote:

Hi All,

Looks like the patches I provided is a step backward from where Ashok &
Andrew were taking the register_cpu_notifier stuff to.

After some discussions with Ashok we both think the following would be
the right direction:
	1 revert the changes i pushed recently
	2 make all usages of register_cpu_notifier to be _init and 
          __initdata (if hotplug cpu is defined these are removed)
	3 export the symbols register_cpu_notifier and
          unregister_cpu_notifier only in CONFIG_HOTPLUG_CPU is defined
	4 move the hot plug cpu based usages of register_cpu_notifier
	  inside #ifdef CONFIG_HOTPLUF_CPU(like xfs's usage).

I have few questions:
 - any problems with the above direction (mainly 3) ?
 - Should we proceed in this direction ?
 - is it too late for 2.6.17 ? if not late how much time do we have ?
 
Many thanks to Alan for bringing up the issue.

regards,

chandra

> On Wed, Apr 26, 2006 at 01:21:33PM -0700, Chandra Seetharaman wrote:
> > > 
> > > The problem we ran into was some of the startup code depends on the notifier
> > > call chain for smp bringup, hence we couldn't nuke it similar to 
> > > hotcpu_notifier().
> > 
> > I do not understand the problem. If everybody that uses
> > register_cpu_notifier() starts using __cpuinit and __cpuinitdata (or the
> > devinit siblings), then the notifier mechanism will not be any different
> > than what they are now, right ? (both in hotplug cpu and non-hotplug cpu
> > case) Or am i missing something ?
> 
> Well, register_cpu_notifier() is an exported function. There are several 
> modules that use this today like cpufreq etc which disqualifies it to be
> a init style function.
> 
> either that function should be devinit and be present premanently, or
> should be mapped to null macro for correctness.
> 
> Otherwise module loaders will start to oops when they call into 
> register.
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


