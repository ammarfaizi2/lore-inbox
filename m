Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVISH1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVISH1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVISH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:27:09 -0400
Received: from [210.76.114.20] ([210.76.114.20]:29360 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932355AbVISH1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:27:07 -0400
Message-ID: <432E683E.7090002@ccoss.com.cn>
Date: Mon, 19 Sep 2005 15:26:54 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: [Question] Clock-pro patches questions
Content-Type: multipart/mixed;
 boundary="------------070905000101010400090401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905000101010400090401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All:

    I am interested in CLOCK-Pro in linux.

    I use Riel's patch in linux-2.6.12 and linux-2.6.12.6, but both can 
not apply. (it will
generate some *.rej files). So, I adjust a bit offset of some lines. It 
do not report any
reject result, and compile sucessfully (2.6.12.6).
   
    When boot with this new kernel, kernel often pop oops message. the 
Oops like this:   
 
    BUG: using smp_processor_id() in preemptible [00000001] code: ifup/1983
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01970f7>] ext3_getblk+0xa2/0x287
 [<c019730d>] ext3_bread+0x31/0xb0
 [<c019ba94>] ext3_dx_find_entry+0xb3/0x240
 [<c019b8c3>] ext3_find_entry+0x2f7/0x415
 [<c0143849>] poison_obj+0x22/0x41
 [<c0287d92>] _spin_lock+0xe/0x73
 [<c02880ec>] _spin_unlock+0x1f/0x47
 [<c0172ce3>] d_alloc+0x16c/0x1c4
 [<c019bc50>] ext3_lookup+0x2f/0xb7
 [<c0168907>] real_lookup+0xbe/0xdc
 [<c0168bd9>] do_lookup+0x85/0x90
 [<c0169411>] __link_path_walk+0x82d/0xf61
 [<c011573c>] __change_page_attr+0x2f/0x15f
 [<c01158bb>] change_page_attr+0x4f/0x59
 [<c0169b8e>] link_path_walk+0x49/0xe2
 [<c0169ebf>] path_lookup+0x9a/0x15e
 [<c016a10f>] __user_walk+0x27/0x44
 [<c01644ec>] vfs_stat+0x19/0x55
 [<c0164b4a>] sys_stat64+0x18/0x36
 [<c0114b3b>] do_page_fault+0x0/0x5fe
 [<c0103187>] sysenter_past_esp+0x54/0x75

or:

BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0121be2>] irq_exit+0x2b/0x44
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb

I think , I perhaps lost something in patch. but I can not find it.

These attachmentes are the patch that I changed and two dmesg files.

Any idea on it? or which version kernel can apply original CLOCK-Pro patch?

Thank in advanced.

liyu



--------------070905000101010400090401
Content-Type: text/plain;
 name="dmesg.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.1"

: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs1'
kobject_hotplug: /sbin/hotplug vc seq=335 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs1 SUBSYSTEM=vc
kobject vcsa1: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa1'
kobject_hotplug: /sbin/hotplug vc seq=336 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa1 SUBSYSTEM=vc
printk: 140 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: ifup/1983
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01970f7>] ext3_getblk+0xa2/0x287
 [<c019730d>] ext3_bread+0x31/0xb0
 [<c019ba94>] ext3_dx_find_entry+0xb3/0x240
 [<c019b8c3>] ext3_find_entry+0x2f7/0x415
 [<c0143849>] poison_obj+0x22/0x41
 [<c0287d92>] _spin_lock+0xe/0x73
 [<c02880ec>] _spin_unlock+0x1f/0x47
 [<c0172ce3>] d_alloc+0x16c/0x1c4
 [<c019bc50>] ext3_lookup+0x2f/0xb7
 [<c0168907>] real_lookup+0xbe/0xdc
 [<c0168bd9>] do_lookup+0x85/0x90
 [<c0169411>] __link_path_walk+0x82d/0xf61
 [<c011573c>] __change_page_attr+0x2f/0x15f
 [<c01158bb>] change_page_attr+0x4f/0x59
 [<c0169b8e>] link_path_walk+0x49/0xe2
 [<c0169ebf>] path_lookup+0x9a/0x15e
 [<c016a10f>] __user_walk+0x27/0x44
 [<c01644ec>] vfs_stat+0x19/0x55
 [<c0164b4a>] sys_stat64+0x18/0x36
 [<c0114b3b>] do_page_fault+0x0/0x5fe
 [<c0103187>] sysenter_past_esp+0x54/0x75
kobject af_packet: registering. parent: <NULL>, set: module
kobject_hotplug
fill_kobj_path: path = '/module/af_packet'
kobject_hotplug: /sbin/hotplug module seq=337 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/af_packet SUBSYSTEM=module
NET: Registered protocol family 17
eth0: link down
printk: 88 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0121be2>] irq_exit+0x2b/0x44
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 333 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0121be2>] irq_exit+0x2b/0x44
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 231 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0121bf9>] irq_exit+0x42/0x44
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
kobject vcs2: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs2'
kobject_hotplug: /sbin/hotplug vc seq=338 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
kobject vcsa2: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa2'
kobject_hotplug: /sbin/hotplug vc seq=339 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs2'
kobject_hotplug: /sbin/hotplug vc seq=340 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
kobject vcs2: cleaning up
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa2'
kobject_hotplug: /sbin/hotplug vc seq=341 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
kobject vcsa2: cleaning up
kobject vcs2: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs2'
kobject_hotplug: /sbin/hotplug vc seq=342 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
kobject vcsa2: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa2'
kobject_hotplug: /sbin/hotplug vc seq=343 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
kobject vcs3: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs3'
kobject_hotplug: /sbin/hotplug vc seq=344 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
kobject vcsa3: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa3'
kobject_hotplug: /sbin/hotplug vc seq=345 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs3'
kobject_hotplug: /sbin/hotplug vc seq=346 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
kobject vcs3: cleaning up
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa3'
kobject_hotplug: /sbin/hotplug vc seq=347 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
kobject vcsa3: cleaning up
kobject vcs3: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs3'
kobject_hotplug: /sbin/hotplug vc seq=348 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
kobject vcsa3: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa3'
kobject_hotplug: /sbin/hotplug vc seq=349 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
kobject vcs4: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs4'
kobject_hotplug: /sbin/hotplug vc seq=350 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
kobject vcsa4: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa4'
kobject_hotplug: /sbin/hotplug vc seq=351 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs4'
kobject_hotplug: /sbin/hotplug vc seq=352 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
kobject vcs4: cleaning up
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa4'
kobject_hotplug: /sbin/hotplug vc seq=353 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
kobject vcsa4: cleaning up
kobject vcs4: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs4'
kobject_hotplug: /sbin/hotplug vc seq=354 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
kobject vcsa4: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa4'
kobject_hotplug: /sbin/hotplug vc seq=355 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
kobject vcs5: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs5'
kobject_hotplug: /sbin/hotplug vc seq=356 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
kobject vcsa5: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa5'
kobject_hotplug: /sbin/hotplug vc seq=357 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs5'
kobject_hotplug: /sbin/hotplug vc seq=358 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
kobject vcs5: cleaning up
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa5'
kobject_hotplug: /sbin/hotplug vc seq=359 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
kobject vcsa5: cleaning up
kobject vcs5: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs5'
kobject_hotplug: /sbin/hotplug vc seq=360 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
kobject vcsa5: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa5'
kobject_hotplug: /sbin/hotplug vc seq=361 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
kobject vcs6: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs6'
kobject_hotplug: /sbin/hotplug vc seq=362 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
kobject vcsa6: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa6'
kobject_hotplug: /sbin/hotplug vc seq=363 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs6'
kobject_hotplug: /sbin/hotplug vc seq=364 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
kobject vcs6: cleaning up
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa6'
kobject_hotplug: /sbin/hotplug vc seq=365 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
kobject vcsa6: cleaning up
kobject vcs6: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs6'
kobject_hotplug: /sbin/hotplug vc seq=366 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
kobject vcsa6: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa6'
kobject_hotplug: /sbin/hotplug vc seq=367 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
printk: 181 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 257 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0121be2>] irq_exit+0x2b/0x44
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 49 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: bash/2767
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c015d765>] __bread+0x1f/0x3d
 [<c0194f47>] read_inode_bitmap+0x47/0x7c
 [<c01957f3>] ext3_new_inode+0x11c/0x68a
 [<c01a7448>] new_handle+0x19/0x3f
 [<c019d088>] ext3_create+0x0/0xe8
 [<c019d0ef>] ext3_create+0x67/0xe8
 [<c019d088>] ext3_create+0x0/0xe8
 [<c016a31a>] vfs_create+0x86/0xb3
 [<c016a60c>] open_namei+0xe7/0x6e3
 [<c015a123>] filp_open+0x3b/0x61
 [<c02880ec>] _spin_unlock+0x1f/0x47
 [<c015a462>] get_unused_fd+0xa8/0xd0
 [<c015a543>] sys_open+0x40/0x77
 [<c0103187>] sysenter_past_esp+0x54/0x75

--------------070905000101010400090401
Content-Type: text/plain;
 name="dmesg.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.2"

[<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 257 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0121be2>] irq_exit+0x2b/0x44
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 49 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: bash/2767
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c015d765>] __bread+0x1f/0x3d
 [<c0194f47>] read_inode_bitmap+0x47/0x7c
 [<c01957f3>] ext3_new_inode+0x11c/0x68a
 [<c01a7448>] new_handle+0x19/0x3f
 [<c019d088>] ext3_create+0x0/0xe8
 [<c019d0ef>] ext3_create+0x67/0xe8
 [<c019d088>] ext3_create+0x0/0xe8
 [<c016a31a>] vfs_create+0x86/0xb3
 [<c016a60c>] open_namei+0xe7/0x6e3
 [<c015a123>] filp_open+0x3b/0x61
 [<c02880ec>] _spin_unlock+0x1f/0x47
 [<c015a462>] get_unused_fd+0xa8/0xd0
 [<c015a543>] sys_open+0x40/0x77
 [<c0103187>] sysenter_past_esp+0x54/0x75
printk: 84 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: vim/2768
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c015d765>] __bread+0x1f/0x3d
 [<c0196510>] ext3_get_branch+0x60/0xd8
 [<c0196be7>] ext3_get_block_handle+0x99/0x391
 [<c0215eee>] submit_bio+0x4d/0xdc
 [<c015feda>] bio_alloc_bioset+0x10f/0x1bf
 [<c0196f2d>] ext3_get_block+0x4e/0x8a
 [<c017df46>] do_mpage_readpage+0x155/0x3de
 [<c01c4cb9>] radix_tree_preload+0x1e/0xc8
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c017e2e1>] mpage_readpages+0x112/0x174
 [<c0196edf>] ext3_get_block+0x0/0x8a
 [<c01159ea>] kernel_map_pages+0x2a/0x58
 [<c01401e6>] prep_new_page+0x65/0x76
 [<c0142cfa>] read_pages+0x140/0x150
 [<c0196edf>] ext3_get_block+0x0/0x8a
 [<c0140a93>] __alloc_pages+0x17f/0x40c
 [<c0142e64>] __do_page_cache_readahead+0x15a/0x15f
 [<c013d137>] filemap_nopage+0x2c8/0x403
 [<c014c54c>] do_no_page+0xa9/0x327
 [<c01c47ad>] prio_tree_insert+0x130/0x18d
 [<c014c9f8>] handle_mm_fault+0x14b/0x17b
 [<c0114d2f>] do_page_fault+0x1f4/0x5fe
 [<c01091fc>] old_mmap+0x124/0x12e
 [<c0114b3b>] do_page_fault+0x0/0x5fe
 [<c0103cd3>] error_code+0x4f/0x54
printk: 90 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aa332>] journal_write_commit_record+0x28/0x113
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01b12b8>] journal_put_journal_head+0x70/0x11f
 [<c01a94f7>] journal_unfile_buffer+0x77/0xc9
 [<c01ab310>] journal_commit_transaction+0xef3/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 102 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aa332>] journal_write_commit_record+0x28/0x113
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01ab310>] journal_commit_transaction+0xef3/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 102 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aa332>] journal_write_commit_record+0x28/0x113
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01ab310>] journal_commit_transaction+0xef3/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aa332>] journal_write_commit_record+0x28/0x113
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01b12b8>] journal_put_journal_head+0x70/0x11f
 [<c01a94f7>] journal_unfile_buffer+0x77/0xc9
 [<c01ab310>] journal_commit_transaction+0xef3/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
printk: 150 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: vim/2768
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c0199404>] __ext3_get_inode_loc+0x56/0x27e
 [<c0173d2b>] alloc_inode+0x1b/0x147
 [<c01996f5>] ext3_read_inode+0x42/0x425
 [<c0174ed3>] iget_locked+0xc8/0xea
 [<c019bcaf>] ext3_lookup+0x8e/0xb7
 [<c0168907>] real_lookup+0xbe/0xdc
 [<c0168bd9>] do_lookup+0x85/0x90
 [<c0169411>] __link_path_walk+0x82d/0xf61
 [<c011573c>] __change_page_attr+0x2f/0x15f
 [<c01158bb>] change_page_attr+0x4f/0x59
 [<c0169b8e>] link_path_walk+0x49/0xe2
 [<c0169ebf>] path_lookup+0x9a/0x15e
 [<c016a10f>] __user_walk+0x27/0x44
 [<c01644ec>] vfs_stat+0x19/0x55
 [<c0164b4a>] sys_stat64+0x18/0x36
 [<c0103187>] sysenter_past_esp+0x54/0x75
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aaef5>] journal_commit_transaction+0xad8/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb
BUG: using smp_processor_id() in preemptible [00000001] code: kjournald/242
caller is recently_evicted+0x9c/0xb8
 [<c01c8103>] smp_processor_id+0x97/0xa8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c01554a8>] recently_evicted+0x9c/0xb8
 [<c0155807>] page_is_hot+0x1b/0x142
 [<c013ba73>] add_to_page_cache+0x6a/0xc9
 [<c013bb1d>] add_to_page_cache_lru+0x4b/0x71
 [<c013bec5>] find_or_create_page+0x2b/0xb2
 [<c015d125>] grow_dev_page+0x30/0x16d
 [<c015d2f3>] __getblk_slow+0x91/0x13e
 [<c015d6ef>] __getblk+0x57/0x5b
 [<c01af632>] journal_get_descriptor_buffer+0x43/0xa8
 [<c01aa332>] journal_write_commit_record+0x28/0x113
 [<c01b0d40>] journal_free_journal_head+0x2e/0x33
 [<c01b12b8>] journal_put_journal_head+0x70/0x11f
 [<c01a94f7>] journal_unfile_buffer+0x77/0xc9
 [<c01ab310>] journal_commit_transaction+0xef3/0x1883
 [<c0101ac9>] __switch_to+0x23/0x1cb
 [<c028817b>] _spin_unlock_irqrestore+0x21/0x49
 [<c0125553>] del_timer_sync+0x96/0xe5
 [<c01ae80d>] kjournald+0x133/0x3fb
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c0130d7f>] autoremove_wake_function+0x0/0x4b
 [<c01ae6d0>] commit_timeout+0x0/0x9
 [<c01ae6da>] kjournald+0x0/0x3fb
 [<c0101441>] kernel_thread_helper+0x5/0xb

--------------070905000101010400090401
Content-Type: text/x-patch;
 name="linux-2.6.12.6.with.clock-pro.riel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12.6.with.clock-pro.riel.patch"

diff -Naur linux-2.6.12.6/fs/proc/proc_misc.c linux-2.6.12.6.with.clock.pro2/fs/proc/proc_misc.c
--- linux-2.6.12.6/fs/proc/proc_misc.c	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/fs/proc/proc_misc.c	2005-09-12 16:44:01.000000000 +0800
@@ -125,11 +125,13 @@
 	unsigned long free;
 	unsigned long committed;
 	unsigned long allowed;
+	unsigned long active_limit;
 	struct vmalloc_info vmi;
 	long cached;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
+	allowed = get_active_limit();
 
 /*
  * display in kilobytes.
@@ -158,6 +160,7 @@
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8lu kB\n"
 		"Inactive:     %8lu kB\n"
+		"ActiveLimit: %8lu kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -181,6 +184,7 @@
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
+		K(active_limit),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
@@ -219,6 +223,20 @@
 	.release	= seq_release,
 };
 
+extern struct seq_operations refaults_op;
+static int refaults_open(struct inode *inode, struct file *file)
+{
+ (void)inode;
+ return seq_open(file, &refaults_op);
+}
+
+static struct file_operations refaults_file_operations = {
+ .open = refaults_open,
+ .read = seq_read,
+ .llseek = seq_lseek,
+ .release = seq_release,
+};
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -588,6 +606,7 @@
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
+	create_seq_entry("refaults",S_IRUGO, &refaults_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
 #ifdef CONFIG_MODULES
diff -Naur linux-2.6.12.6/include/linux/mmzone.h linux-2.6.12.6.with.clock.pro2/include/linux/mmzone.h
--- linux-2.6.12.6/include/linux/mmzone.h	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/include/linux/mmzone.h	2005-09-12 16:11:21.000000000 +0800
@@ -143,7 +143,9 @@
 	unsigned long		nr_inactive;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
-
+	unsigned long active_limit;
+	unsigned long active_scanned;
+     
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
 	 * defined as the scanning priority at which we achieved our reclaim
diff -Naur linux-2.6.12.6/include/linux/page-flags.h linux-2.6.12.6.with.clock.pro2/include/linux/page-flags.h
--- linux-2.6.12.6/include/linux/page-flags.h	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/include/linux/page-flags.h	2005-09-12 16:06:53.000000000 +0800
@@ -77,6 +77,8 @@
 #define PG_nosave_free		19	/* Free, should not be written */
 #define PG_uncached		20	/* Page has been mapped as uncached */
 
+#define PG_new 			21 /* Newly allocated page */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -306,6 +308,11 @@
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageNew(page) test_bit(PG_new, &(page)->flags)
+#define SetPageNew(page) set_bit(PG_new, &(page)->flags)
+#define ClearPageNew(page) clear_bit(PG_new, &(page)->flags)
+#define TestClearPageNew(page) test_and_clear_bit(PG_new, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -Naur linux-2.6.12.6/include/linux/swap.h linux-2.6.12.6.with.clock.pro2/include/linux/swap.h
--- linux-2.6.12.6/include/linux/swap.h	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/include/linux/swap.h	2005-09-12 16:23:00.000000000 +0800
@@ -153,6 +153,17 @@
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
 
+/* linux/mm/nonresident.c */
+extern int do_remember_page(struct address_space *, unsigned long);
+extern int recently_evicted(struct address_space *, unsigned long);
+extern void init_nonresident(void);
+
+/* linux/mm/clockpro.c */
+extern void remember_page(struct page *, struct address_space *, unsigned long);
+extern int page_is_hot(struct page *, struct address_space *, unsigned long);
+extern unsigned long get_active_limit(void);
+DECLARE_PER_CPU(unsigned long, evicted_pages);
+
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
@@ -288,6 +299,14 @@
 #define grab_swap_token()  do { } while(0)
 #define has_swap_token(x) 0
 
+/* linux/mm/nonresident.c */
+#define init_nonresident() do { } while (0)
+#define remember_page(x,y) 0
+#define recently_evicted(x,y) 0
+
+/* linux/mm/clockpro.c */
+#define page_is_hot(x,y,z) 0
+
 #endif /* CONFIG_SWAP */
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff -Naur linux-2.6.12.6/init/main.c linux-2.6.12.6.with.clock.pro2/init/main.c
--- linux-2.6.12.6/init/main.c	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/init/main.c	2005-09-12 15:53:24.000000000 +0800
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/swap.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -488,6 +489,7 @@
 	}
 #endif
 	vfs_caches_init_early();
+	init_nonresident();
 	mem_init();
 	kmem_cache_init();
 	numa_policy_init();
diff -Naur linux-2.6.12.6/mm/clockpro.c linux-2.6.12.6.with.clock.pro2/mm/clockpro.c
--- linux-2.6.12.6/mm/clockpro.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/clockpro.c	2005-09-12 16:23:00.000000000 +0800
@@ -0,0 +1,113 @@
+/*
+ * mm/clockpro.c
+ * (C) 2005 Red Hat, Inc
+ * Written by Rik van Riel <riel_at_redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Helper functions to implement CLOCK-Pro page replacement policy.
+ * For details see: http://linux-mm.org/wiki/AdvancedPageReplacement
+ */
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/swap.h>
+
+DEFINE_PER_CPU(unsigned long, evicted_pages);
+static unsigned long get_evicted(void)
+{
+ unsigned long total = 0;
+ int cpu;
+
+ for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; cpu++)
+ total += per_cpu(evicted_pages, cpu);
+
+ return total;
+}
+
+static unsigned long estimate_pageable_memory(void)
+{
+ static unsigned long next_check;
+ static unsigned long total;
+ unsigned long active, inactive, free;
+
+ if (time_after(jiffies, next_check)) {
+ get_zone_counts(&active, &inactive, &free);
+ total = active + inactive + free;
+ next_check = jiffies + HZ/10;
+ }
+
+ return total;
+}
+
+static void decay_clockpro_variables(void)
+{
+ struct zone * zone;
+ int cpu;
+
+ for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; cpu++)
+ per_cpu(evicted_pages, cpu) /= 2;
+
+ for_each_zone(zone)
+ zone->active_scanned /= 2;
+}
+
+int page_is_hot(struct page * page, struct address_space * mapping,
+ unsigned long index)
+{
+ unsigned long long distance;
+ unsigned long long evicted;
+ int refault_distance;
+ struct zone *zone;
+
+ /* Was the page recently evicted ? */
+ refault_distance = recently_evicted(mapping, index);
+ if (refault_distance < 0)
+ return 0;
+
+ distance = estimate_pageable_memory() + refault_distance;
+ evicted = get_evicted();
+ zone = page_zone(page);
+
+ /* Only consider recent history for the calculation below. */
+ if (unlikely(evicted > distance))
+ decay_clockpro_variables();
+
+ /*
+ * Estimate whether the inter-reference distance of the tested
+ * page is smaller than the inter-reference distance of the
+ * oldest page on the active list.
+ *
+ * distance zone->nr_active
+ * ---------- < ----------------------
+ * evicted zone->active_scanned
+ */
+ if (distance * zone->active_scanned < evicted * zone->nr_active) {
+ if (zone->active_limit > zone->present_pages / 8)
+ zone->active_limit--;
+ return 1;
+ }
+
+ /* Increase the active limit more slowly. */
+ if ((evicted & 1) && zone->active_limit < zone->present_pages * 7 / 8)
+ zone->active_limit++;
+ return 0;
+}
+
+void remember_page(struct page * page, struct address_space * mapping,
+ unsigned long index)
+{
+ struct zone * zone = page_zone(page);
+ if (do_remember_page(mapping, index) && (index & 1) &&
+ zone->active_limit < zone->present_pages * 7 / 8)
+ zone->active_limit++;
+}
+
+unsigned long get_active_limit(void)
+{
+ unsigned long total = 0;
+ struct zone * zone;
+
+ for_each_zone(zone)
+ total += zone->active_limit;
+
+ return total;
+}
diff -Naur linux-2.6.12.6/mm/filemap.c linux-2.6.12.6.with.clock.pro2/mm/filemap.c
--- linux-2.6.12.6/mm/filemap.c	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/filemap.c	2005-09-12 16:13:34.000000000 +0800
@@ -383,6 +383,7 @@
 		if (!error) {
 			page_cache_get(page);
 			SetPageLocked(page);
+			SetPageNew(page);
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
@@ -400,8 +401,13 @@
 				pgoff_t offset, int gfp_mask)
 {
 	int ret = add_to_page_cache(page, mapping, offset, gfp_mask);
-	if (ret == 0)
-		lru_cache_add(page);
+
+	if (ret == 0) {
+		if (page_is_hot(page, mapping, offset))
+			lru_cache_add_active(page);
+		else
+			lru_cache_add(page);
+	}			      
 	return ret;
 }
 
@@ -722,7 +728,7 @@
 	unsigned long offset;
 	unsigned long last_index;
 	unsigned long next_index;
-	unsigned long prev_index;
+//	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
@@ -731,7 +737,7 @@
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
-	prev_index = ra.prev_page;
+//	prev_index = ra.prev_page;
 	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
@@ -782,9 +788,9 @@
 		 * When (part of) the same page is read multiple times
 		 * in succession, only mark it as accessed the first time.
 		 */
-		if (prev_index != index)
-			mark_page_accessed(page);
-		prev_index = index;
+//		if (prev_index != index)
+		mark_page_accessed(page);
+//		prev_index = index;
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
diff -Naur linux-2.6.12.6/mm/Makefile linux-2.6.12.6.with.clock.pro2/mm/Makefile
--- linux-2.6.12.6/mm/Makefile	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/Makefile	2005-09-12 16:12:16.000000000 +0800
@@ -12,7 +12,8 @@
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   prio_tree.o $(mmu-y)
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o \
+				nonresident.o clockpro.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
diff -Naur linux-2.6.12.6/mm/nonresident.c linux-2.6.12.6.with.clock.pro2/mm/nonresident.c
--- linux-2.6.12.6/mm/nonresident.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/nonresident.c	2005-09-12 16:14:23.000000000 +0800
@@ -0,0 +1,236 @@
+/*
+ * mm/nonresident.c
+ * (C) 2004,2005 Red Hat, Inc
+ * Written by Rik van Riel <riel_at_redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Keeps track of whether a non-resident page was recently evicted
+ * and should be immediately promoted to the active list. This also
+ * helps automatically tune the inactive target.
+ *
+ * The pageout code stores a recently evicted page in this cache
+ * by calling remember_page(mapping/mm, index/vaddr, generation)
+ * and can look it up in the cache by calling recently_evicted()
+ * with the same arguments.
+ *
+ * Note that there is no way to invalidate pages after eg. truncate
+ * or exit, we let the pages fall out of the non-resident set through
+ * normal replacement.
+ */
+#include <linux/mm.h>
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/bootmem.h>
+#include <linux/hash.h>
+#include <linux/prefetch.h>
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/swap.h>
+
+/* Number of non-resident pages per hash bucket. Never smaller than 15. */
+#if (L1_CACHE_BYTES < 64)
+#define NR_BUCKET_BYTES 64
+#else
+#define NR_BUCKET_BYTES L1_CACHE_BYTES
+#endif
+#define NUM_NR ((NR_BUCKET_BYTES - sizeof(atomic_t))/sizeof(u32))
+
+struct nr_bucket
+{
+ atomic_t hand;
+ u32 page[NUM_NR];
+} ____cacheline_aligned;
+
+/* Histogram for non-resident refault hits. [NUM_NR] means "not found". */
+DEFINE_PER_CPU(unsigned long[NUM_NR+1], refault_histogram);
+
+/* The non-resident page hash table. */
+static struct nr_bucket * nonres_table;
+static unsigned int nonres_shift;
+static unsigned int nonres_mask;
+
+struct nr_bucket * nr_hash(void * mapping, unsigned long index)
+{
+ unsigned long bucket;
+ unsigned long hash;
+
+ hash = hash_ptr(mapping, BITS_PER_LONG);
+ hash = 37 * hash + hash_long(index, BITS_PER_LONG);
+ bucket = hash & nonres_mask;
+
+ return nonres_table + bucket;
+}
+
+static u32 nr_cookie(struct address_space * mapping, unsigned long index)
+{
+ unsigned long cookie = hash_ptr(mapping, BITS_PER_LONG);
+ cookie = 37 * cookie + hash_long(index, BITS_PER_LONG);
+
+ if (mapping->host) {
+ cookie = 37 * cookie + hash_long(mapping->host->i_ino, BITS_PER_LONG);
+ }
+
+ return (u32)(cookie >> (BITS_PER_LONG - 32));
+}
+
+int recently_evicted(struct address_space * mapping, unsigned long index)
+{
+ struct nr_bucket * nr_bucket;
+ int distance;
+ u32 wanted;
+ int i;
+
+ prefetch(mapping->host);
+ nr_bucket = nr_hash(mapping, index);
+
+ prefetch(nr_bucket);
+ wanted = nr_cookie(mapping, index);
+
+ for (i = 0; i < NUM_NR; i++) {
+ if (nr_bucket->page[i] == wanted) {
+ nr_bucket->page[i] = 0;
+ /* Return the distance between entry and clock hand. */
+ distance = atomic_read(&nr_bucket->hand) + NUM_NR - i;
+ distance = (distance % NUM_NR);
+  __get_cpu_var(refault_histogram)[distance]++;
+ return (distance + 1) * (1 << nonres_shift);
+ }
+ }
+ /* If this page was evicted, it was longer ago than our history. */
+ __get_cpu_var(refault_histogram)[NUM_NR]++;     
+ return -1;
+}
+
+int do_remember_page(struct address_space * mapping, unsigned long index)
+{
+ struct nr_bucket * nr_bucket;
+ u32 nrpage;
+ int i;
+
+ prefetch(mapping->host);
+ nr_bucket = nr_hash(mapping, index);
+
+ prefetchw(nr_bucket);
+ nrpage = nr_cookie(mapping, index);
+
+ /* Atomically find the next array index. */
+ preempt_disable();
+ retry:
+ i = atomic_inc_return(&nr_bucket->hand);
+ if (unlikely(i >= NUM_NR)) {
+ if (i == NUM_NR)
+ atomic_set(&nr_bucket->hand, -1);
+ goto retry;
+ }
+ preempt_enable();
+ 
+ __get_cpu_var(evicted_pages)++;
+
+ /* Statistics may want to know whether the entry was in use. */
+ return xchg(&nr_bucket->page[i], nrpage);
+}
+
+/*
+ * For interactive workloads, we remember about as many non-resident pages
+ * as we have actual memory pages. For server workloads with large inter-
+ * reference distances we could benefit from remembering more.
+ */
+static __initdata unsigned long nonresident_factor = 1;
+void __init init_nonresident(void)
+{
+ int target;
+ int i;
+
+ /*
+ * Calculate the non-resident hash bucket target. Use a power of
+ * two for the division because alloc_large_system_hash rounds up.
+ */
+ target = nr_all_pages * nonresident_factor;
+ target /= (sizeof(struct nr_bucket) / sizeof(u32));
+
+ nonres_table = alloc_large_system_hash("Non-resident page tracking",
+ sizeof(struct nr_bucket),
+ target,
+ 0,
+ HASH_EARLY | HASH_HIGHMEM,
+ &nonres_shift,
+ &nonres_mask,
+ 0);
+
+ for (i = 0; i < (1 << nonres_shift); i++)
+ atomic_set(&nonres_table[i].hand, 0);
+}
+
+static int __init set_nonresident_factor(char * str)
+{
+ if (!str)
+ return 0;
+ nonresident_factor = simple_strtoul(str, &str, 0);
+ return 1;
+}
+__setup("nonresident_factor=", set_nonresident_factor);
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+ if (*pos < 0 || *pos > NUM_NR)
+ return NULL;
+
+ m->private = (unsigned long)*pos;
+
+ return pos;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+ if (*pos < NUM_NR) {
+ (*pos)++;
+ (unsigned long)m->private++;
+ return pos;
+ }
+ return NULL;
+}
+
+static void frag_stop(struct seq_file *m, void *arg)
+{
+}
+
+unsigned long get_refault_stat(unsigned long index)
+{
+ unsigned long total = 0;
+ int cpu;
+
+ for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; cpu++) {
+ total += per_cpu(refault_histogram, cpu)[index];
+ }
+ return total;
+}
+
+static int frag_show(struct seq_file *m, void *arg)
+{
+ unsigned long index = (unsigned long)m->private;
+ unsigned long upper = ((unsigned long)index + 1) << nonres_shift;
+ unsigned long lower = (unsigned long)index << nonres_shift;
+ unsigned long hits = get_refault_stat(index);
+
+ if (index == 0)
+ seq_printf(m, " Refault distance Hits\n");
+
+ if (index < NUM_NR)
+ seq_printf(m, "%9lu - %9lu %9lu\n", lower, upper, hits);
+ else
+ seq_printf(m, " New/Beyond %9lu %9lu\n", lower, hits);
+
+ return 0;
+}
+
+struct seq_operations refaults_op = {
+ .start = frag_start,
+ .next = frag_next,
+ .stop = frag_stop,
+ .show = frag_show,
+};
+#endif /* CONFIG_PROCFS */
diff -Naur linux-2.6.12.6/mm/page_alloc.c linux-2.6.12.6.with.clock.pro2/mm/page_alloc.c
--- linux-2.6.12.6/mm/page_alloc.c	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/page_alloc.c	2005-09-12 16:14:51.000000000 +0800
@@ -1713,6 +1713,8 @@
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->active_limit = zone->present_pages * 2 / 3;
+		
 		if (!size)
 			continue;
 
diff -Naur linux-2.6.12.6/mm/swap_state.c linux-2.6.12.6.with.clock.pro2/mm/swap_state.c
--- linux-2.6.12.6/mm/swap_state.c	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/swap_state.c	2005-09-12 16:17:11.000000000 +0800
@@ -323,6 +323,7 @@
 			struct vm_area_struct *vma, unsigned long addr)
 {
 	struct page *found_page, *new_page = NULL;
+	int active;
 	int err;
 
 	do {
@@ -354,12 +355,16 @@
 		 * the just freed swap entry for an existing page.
 		 * May fail (-ENOMEM) if radix-tree node allocation failed.
 		 */
+		active = page_is_hot(new_page, &swapper_space, entry.val);
 		err = add_to_swap_cache(new_page, entry);
 		if (!err) {
 			/*
 			 * Initiate read into locked page and return.
 			 */
-			lru_cache_add_active(new_page);
+			if (active) {
+			  lru_cache_add_active(new_page);
+			} else
+			  lru_cache_add(new_page);				       
 			swap_readpage(NULL, new_page);
 			return new_page;
 		}
diff -Naur linux-2.6.12.6/mm/vmscan.c linux-2.6.12.6.with.clock.pro2/mm/vmscan.c
--- linux-2.6.12.6/mm/vmscan.c	2005-08-30 00:55:27.000000000 +0800
+++ linux-2.6.12.6.with.clock.pro2/mm/vmscan.c	2005-09-12 16:22:43.000000000 +0800
@@ -376,12 +376,14 @@
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
 		struct page *page;
+		struct zone *zone;
 		int may_enter_fs;
 		int referenced;
 
 		cond_resched();
 
 		page = lru_to_page(page_list);
+		zone = page_zone(page);
 		list_del(&page->lru);
 
 		if (TestSetPageLocked(page))
@@ -509,6 +511,7 @@
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
+			remember_page(page, &swapper_space, page->private);
 			__delete_from_swap_cache(page);
 			write_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
@@ -517,6 +520,7 @@
 		}
 #endif /* CONFIG_SWAP */
 
+		remember_page(page, page->mapping, page->index);
 		__remove_from_page_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		__put_page(page);
@@ -698,6 +702,7 @@
 	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
 				    &l_hold, &pgscanned);
 	zone->pages_scanned += pgscanned;
+	zone->active_scanned += pgscanned;
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
@@ -813,10 +818,14 @@
 	unsigned long nr_inactive;
 
 	/*
-	 * Add one to `nr_to_scan' just to make sure that the kernel will
-	 * slowly sift through the active list.
+	 * Scan the active list if we have too many active pages.
+         * The limit is automatically adjusted through refaults
+	 * measuring how well the VM did in the past.	       
 	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
+	if (zone->nr_active > zone->active_limit)
+        	zone->nr_scan_active += zone->nr_active - zone->active_limit;
+	else if (sc->priority < DEF_PRIORITY - 2)	  
+		zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
 	nr_active = zone->nr_scan_active;
 	if (nr_active >= sc->swap_cluster_max)
 		zone->nr_scan_active = 0;

--------------070905000101010400090401--
