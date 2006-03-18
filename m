Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWCRUZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWCRUZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWCRUZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:25:17 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:33920 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750934AbWCRUZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:25:16 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, Linus Torvalds <torvalds@osdl.org>
Subject: OOPS: 2.6.16-rc6 cpufreq_conservative
Date: Sat, 18 Mar 2006 15:25:14 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200603181525.14127.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can reproduce the below OOPS by doing 
$ modprobe cpufreq_conservative
$ echo conservative > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
$ echo conservative > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

Which brings up a question - Do we really support difference scaling governors 
for different cpu cores?

This is  a Centrino Duo Laptop.

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
 printing eip:
f834e6d0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: cpufreq_conservative oprofile ntfs snd_pcm_oss 
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device eth1394 
ohci1394 i2c_i801 i2c_core hw_random ipw3945 ieee80211 ieee80211_crypt 
firmware_class snd_hda_intel snd_hda_codec snd_pcm snd_timer snd 
snd_page_alloc i915 drm cpufreq_ondemand speedstep_centrino b44
CPU:    1
EIP:    0060:[<f834e6d0>]    Not tainted VLI
EFLAGS: 00010206   (2.6.16-rc6 #3)
EIP is at dbs_check_cpu+0x220/0x400 [cpufreq_conservative]
eax: 00000000   ebx: 00000001   ecx: 00000001   edx: 7840d1bc
esi: 78445730   edi: 00000002   ebp: 78445730   esp: 7a1c1ef0
ds: 007b   es: 007b   ss: 0068
Process events/1 (pid: 9, threadinfo=7a1c0000 task=7a33fa90)
Stack: <0>7840d1bc 00000002 00000001 7a2d3a80 00000000 f834f704 7a1aa1c0 
00000000
       f834e938 00000000 00000202 7a1c0000 f834f700 78132869 00000000 00000000
       18a60e00 7a1aa1d0 7a1aa1e8 f834e8b0 00000202 7a1c0000 7a1aa1d8 7a1aa1d0
Call Trace:
 [<f834e938>] do_dbs_timer+0x88/0xc0 [cpufreq_conservative]
 [<78132869>] run_workqueue+0x79/0xf0
 [<f834e8b0>] do_dbs_timer+0x0/0xc0 [cpufreq_conservative]
 [<78132a38>] worker_thread+0x158/0x180
 [<7811b0d0>] default_wake_function+0x0/0x20
 [<7811b0d0>] default_wake_function+0x0/0x20
 [<781328e0>] worker_thread+0x0/0x180
 [<7813664c>] kthread+0xbc/0x100
 [<78136590>] kthread+0x0/0x100
 [<78101285>] kernel_thread_helper+0x5/0x10
Code: 0f bc c0 83 f8 03 bb 02 00 00 00 0f 4c d8 83 fb 01 77 49 89 ee 8d b6 00 
00 00 00 8b 04 9d 04 80 44 78 bf 02 00 00 00 01 f0 8b 00 <8b> 40 1c 89 7c 24 
04 c7 04 24 bc d1 40 78 89 04 9d 48 fa 34 f8
