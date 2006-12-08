Return-Path: <linux-kernel-owner+w=401wt.eu-S1425580AbWLHPuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425580AbWLHPuv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938067AbWLHPuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:50:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:62021 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936787AbWLHPut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:50:49 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: BUG: scheduling while atomic
Date: Fri, 8 Dec 2006 16:47:57 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081647.57379.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml,

while playing enemy-territory it sometimes hangs the X server and I need to 
hard-reset the machine. I managed to get a trace of the problem this time. 
The kernel is tainted with the binary NVIDIA driver. I hope someone from 
NVIDIA follows the list. I know that there will be no support for a tainted 
kernel on lkml. This mail is "for information" only!

uname -a
Linux ubuntu 2.6.19-rc6-mm1 #2 SMP PREEMPT Thu Nov 23 15:34:58 CET 2006 x86_64 
GNU/Linux

Driver name: NVIDIA-Linux-x86_64-1.0-9631-pkg2

GPU: 7600gt

[10807.947562] Call Trace:
[10807.947571]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10807.947581]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10807.947587]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10807.947594]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10807.947599]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10807.947611]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10807.947618]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10807.947629]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10807.947634]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10807.947643]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10807.947739]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10807.947843]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10807.947944]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10807.947960]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10807.948036]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10807.948051]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10807.948060]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10807.948072]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10807.948079]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10807.948086]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10807.948091]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10807.948099]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10807.948104]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10807.948114]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10807.948119]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10807.948129]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10807.948137]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10807.948142]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10807.948150]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10807.948163]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10807.948167]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10807.948172]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10807.948179]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10807.948186]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10807.948205]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10807.948220]
[10807.968891] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10807.968893]
[10807.968894] Call Trace:
[10807.968901]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10807.968912]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10807.968918]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10807.968925]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10807.968930]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10807.968943]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10807.968950]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10807.968961]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10807.968967]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10807.968975]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10807.969113]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10807.969220]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10807.969321]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10807.969337]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10807.969406]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10807.969421]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10807.969428]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10807.969440]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10807.969447]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10807.969453]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10807.969459]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10807.969467]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10807.969471]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10807.969480]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10807.969486]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10807.969491]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10807.969499]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10807.969505]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10807.969512]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10807.969524]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10807.969528]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10807.969534]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10807.969541]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10807.969547]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10807.969619]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10807.969635]
[10807.990207] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10807.990209]
[10807.990210] Call Trace:
[10807.990218]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10807.990228]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10807.990234]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10807.990241]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10807.990247]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10807.990259]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10807.990267]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10807.990278]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10807.990283]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10807.990292]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10807.990386]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10807.990492]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10807.990594]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10807.990610]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10807.990681]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10807.990697]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10807.990704]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10807.990715]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10807.990722]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10807.990728]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10807.990734]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10807.990742]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10807.990746]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10807.990755]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10807.990761]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10807.990766]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10807.990774]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10807.990779]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10807.990785]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10807.990797]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10807.990801]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10807.990807]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10807.990813]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10807.990820]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10807.990838]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10807.990853]
[10808.011521] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10808.011523]
[10808.011524] Call Trace:
[10808.011531]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10808.011541]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10808.011547]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10808.011554]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10808.011559]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10808.011571]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10808.011578]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10808.011589]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10808.011594]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10808.011602]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10808.011699]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10808.011804]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10808.011905]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10808.011921]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10808.011988]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10808.012004]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10808.012011]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10808.012022]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10808.012029]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10808.012035]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10808.012041]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10808.012058]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10808.012062]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10808.012071]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10808.012079]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10808.012084]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10808.012091]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10808.012097]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10808.012103]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10808.012115]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10808.012119]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10808.012124]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10808.012131]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10808.012138]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10808.012156]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10808.012171]
[10808.032843] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10808.032847]
[10808.032847] Call Trace:
[10808.032866]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10808.032876]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10808.032882]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10808.032889]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10808.032894]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10808.032909]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10808.032916]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10808.032927]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10808.032932]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10808.032941]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10808.033050]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10808.033157]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10808.033258]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10808.033274]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10808.033341]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10808.033357]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10808.033364]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10808.033375]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10808.033382]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10808.033388]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10808.033394]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10808.033402]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10808.033406]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10808.033415]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10808.033420]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10808.033425]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10808.033432]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10808.033437]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10808.033444]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10808.033456]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10808.033460]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10808.033465]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10808.033472]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10808.033479]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10808.033497]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10808.033512]
[10808.054164] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10808.054167]
[10808.054168] Call Trace:
[10808.054186]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10808.054196]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10808.054202]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10808.054209]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10808.054214]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10808.054229]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10808.054236]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10808.054247]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10808.054252]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10808.054260]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10808.054369]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10808.054473]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10808.054575]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10808.054592]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10808.054660]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10808.054675]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10808.054683]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10808.054694]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10808.054701]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10808.054707]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10808.054712]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10808.054720]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10808.054730]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10808.054739]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10808.054744]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10808.054749]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10808.054757]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10808.054762]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10808.054769]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10808.054780]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10808.054784]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10808.054790]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10808.054797]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10808.054803]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10808.054821]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10808.054836]
[10808.075479] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10808.075482]
[10808.075482] Call Trace:
[10808.075490]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10808.075500]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10808.075506]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10808.075513]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10808.075518]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10808.075531]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10808.075538]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10808.075549]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10808.075554]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10808.075562]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10808.075659]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10808.075764]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10808.075865]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10808.075881]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10808.075949]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10808.075964]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10808.075971]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10808.075982]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10808.075989]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10808.075995]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10808.076001]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10808.076009]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10808.076013]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10808.076025]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10808.076030]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10808.076035]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10808.076042]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10808.076047]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10808.076054]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10808.076066]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10808.076070]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10808.076075]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10808.076082]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10808.076089]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10808.076107]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10808.076122]
[10808.096839] BUG: scheduling while atomic: et.x86/0x00000001/12595
[10808.096842]
[10808.096843] Call Trace:
[10808.096862]  [<ffffffff8025e5ce>] __sched_text_start+0x5e/0x87d
[10808.096873]  [<ffffffff8023cc34>] lock_timer_base+0x1b/0x3c
[10808.096879]  [<ffffffff8021c126>] __mod_timer+0xa7/0xb6
[10808.096886]  [<ffffffff8025f88d>] schedule_timeout+0x8a/0xad
[10808.096891]  [<ffffffff8028cf35>] process_timeout+0x0/0x5
[10808.096906]  
[<ffffffff883690a1>] :snd_pcm:snd_pcm_common_ioctl1+0xb7d/0xd03
[10808.096913]  [<ffffffff80283183>] default_wake_function+0x0/0xe
[10808.096924]  [<ffffffff8025eded>] thread_return+0x0/0x100
[10808.096929]  [<ffffffff803a3ce8>] pci_mmcfg_read+0x54/0xc5
[10808.096937]  [<ffffffff803321ce>] pci_bus_read_config_word+0x71/0x83
[10808.097050]  [<ffffffff883a7cd3>] :nvidia:_nv002933rm+0x27/0x36
[10808.097157]  [<ffffffff88535aac>] :nvidia:_nv005905rm+0x26/0x2c
[10808.097259]  [<ffffffff88535a02>] :nvidia:_nv005907rm+0x30/0x54
[10808.097274]  
[<ffffffff8836963a>] :snd_pcm:snd_pcm_playback_ioctl1+0x1e0/0x1fd
[10808.097342]  [<ffffffff883c0ea5>] :nvidia:rm_set_interrupts+0x11f/0x136
[10808.097358]  [<ffffffff88369e23>] :snd_pcm:snd_pcm_kernel_ioctl+0x3d/0x61
[10808.097365]  [<ffffffff8837e115>] :snd_pcm_oss:snd_pcm_oss_sync+0x2a4/0x31d
[10808.097376]  
[<ffffffff8837e63f>] :snd_pcm_oss:snd_pcm_oss_release+0x39/0x9d
[10808.097383]  [<ffffffff80211ca0>] __fput+0x9e/0x16a
[10808.097389]  [<ffffffff802231d3>] filp_close+0x5c/0x64
[10808.097395]  [<ffffffff80237828>] put_files_struct+0x66/0xbf
[10808.097402]  [<ffffffff802149de>] do_exit+0x2b2/0x8a7
[10808.097406]  [<ffffffff8028de94>] __dequeue_signal+0x111/0x177
[10808.097415]  [<ffffffff80246767>] cpuset_exit+0x0/0x6c
[10808.097420]  [<ffffffff8022a4e3>] get_signal_to_deliver+0x645/0x67b
[10808.097425]  [<ffffffff8027fb67>] save_i387_ia32+0x1aa/0x1cd
[10808.097433]  [<ffffffff8020a7f3>] ia32_setup_sigcontext+0x127/0x1dd
[10808.097438]  [<ffffffff80281304>] task_rq_lock+0x3d/0x6f
[10808.097445]  [<ffffffff80244846>] try_to_wake_up+0x363/0x374
[10808.097457]  [<ffffffff80257e0e>] do_notify_resume+0x9c/0x71d
[10808.097461]  [<ffffffff8028ed19>] specific_send_sig_info+0x94/0x9f
[10808.097466]  [<ffffffff8028efa2>] force_sig_info+0xa9/0xb4
[10808.097473]  [<ffffffff80263418>] do_page_fault+0x7b8/0x7ca
[10808.097479]  [<ffffffff8020d848>] do_mmap_pgoff+0x646/0x7b2
[10808.097497]  [<ffffffff8025a6fc>] retint_signal+0x3d/0x81
[10808.097512]

-Christian
