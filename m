Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWHFBXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWHFBXX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 21:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWHFBXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 21:23:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56753 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932679AbWHFBXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 21:23:22 -0400
Date: Sat, 5 Aug 2006 21:23:20 -0400
From: Dave Jones <davej@redhat.com>
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060806012320.GI13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, art <art@usfltd.com>,
	linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com
References: <20060805221410.22397.qmail@mail.webhostingstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805221410.22397.qmail@mail.webhostingstar.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 05:14:10PM -0500, art wrote:
 > same for 2.6.18.rc3-git7 on smp amd64 x2 (dualcore)
 > after
 > # echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
 > 
 > dmesg 
 > 
 > ....
 > SELinux: initialized (dev sdb1, type vfat), uses genfs_contexts
 > Lukewarm IQ detected in hotplug locking
 > BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug() 
 > 
 > Call Trace:
 >  [<ffffffff802a0e72>] lock_cpu_hotplug+0x50/0x73
 >  [<ffffffff80299a36>] __create_workqueue+0x5d/0x146
 >  [<ffffffff803f437d>] cpufreq_governor_dbs+0xa8/0x2f4
 >  [<ffffffff803f22ac>] __cpufreq_governor+0xa4/0x194
 >  [<ffffffff803f2516>] __cpufreq_set_policy+0x17a/0x1f4
 >  [<ffffffff803f2792>] store_scaling_governor+0x17c/0x1d8
 >  [<ffffffff803f35f8>] handle_update+0x0/0x28
 >  [<ffffffff8026650b>] _spin_unlock_irqrestore+0x15/0x30
 >  [<ffffffff803f1a00>] cpufreq_cpu_get+0xb5/0x143
 >  [<ffffffff80272dbf>] store+0x44/0x5b
 >  [<ffffffff802f1ddc>] sysfs_write_file+0xc5/0xf4
 >  [<ffffffff80215e1b>] vfs_write+0xce/0x174
 >  [<ffffffff802166a9>] sys_write+0x45/0x6e
 >  [<ffffffff8025fa8e>] system_call+0x7e/0x83 

Ok, these should be fixed with Andrews voodoo patches to the workqueue code.

		Dave

-- 
http://www.codemonkey.org.uk
