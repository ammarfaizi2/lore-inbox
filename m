Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965378AbWHOORB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbWHOORB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWHOORA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:17:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965379AbWHOOQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:16:59 -0400
Date: Tue, 15 Aug 2006 07:16:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel@vger.kernel.org, airlied@linux.ie,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.18-rc4-mm1 BUG, drm related
Message-Id: <20060815071632.b10d3a03.akpm@osdl.org>
In-Reply-To: <20060815130345.GA3817@slug>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<20060815130345.GA3817@slug>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 13:25:56 +0000
Frederik Deweerdt <deweerdt@free.fr> wrote:

> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > 
> Hi,
> 
> There are two BUGs with 2.6.18-rc4-mm1 that seem related to (I did the
> bisection[1]):
> git-drm.patch
> drm-build-fix.patch
> drm-build-fixes-2.patch
> allow-drm-detection-of-new-via-chipsets.patch
> git-drm-build-fix.patch
> 
> Here's one of the BUGs (the second one is on the web site below).
> [   40.276000] [drm:drm_unlock] *ERROR* Process 8914 using kernel context 0

I guess the above is a non-fatal DRM warning.

The below is an ALSA oops.

> [   41.024000] BUG: unable to handle kernel paging request at virtual address 6e756f73
> [   41.024000]  printing eip:
> [   41.024000] c01b5771
> [   41.024000] *pde = 00000000
> [   41.024000] Oops: 0000 [#1]
> [   41.024000] 8K_STACKS PREEMPT 
> [   41.024000] last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-0:1.0/bInterfaceProtocol
> [   41.024000] Modules linked in: snd_seq snd_seq_device ohci_hcd parport_pc parport pcspkr ipw2200 yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_conservative speedstep_centrino freq_table processor ac battery i915 drm tg3 joydev tsdev
> [   41.024000] CPU:    0
> [   41.024000] EIP:    0060:[<c01b5771>]    Not tainted VLI
> [   41.024000] EFLAGS: 00210246   (2.6.18-rc4-mm1-def01 #1) 
> [   41.024000] EIP is at sysfs_lookup+0x65/0xb0
> [   41.024000] eax: f3161e40   ebx: f316842c   ecx: f73f6280   edx: f316842c
> [   41.024000] esi: 6e756f73   edi: f3161ec4   ebp: f6c35dfc   esp: f6c35de0
> [   41.024000] ds: 007b   es: 007b   ss: 0068
> [   41.024000] Process modprobe (pid: 8952, ti=f6c34000 task=f7d17550 task.ti=f6c34000)
> [   41.024000] Stack: f316842c f3161e94 f31684bc 00000000 fffffff4 f73f72ec f3161e40 f6c35e1c 
> [   41.024000]        c0184d42 f73f72ec f3161e40 00000000 ffffffff c03a6656 12fd28db f6c35e4c 
> [   41.024000]        c0184e02 f6c35e30 f3161ee8 00000000 12fd28db 00000005 c03a6651 c038230e 
> [   41.024000] Call Trace:
> [   41.024000]  [<c0184d42>] __lookup_hash+0x9d/0xcc
> [   41.024000]  [<c0184e02>] lookup_one_len+0x71/0x86
> [   41.024000]  [<c01b51da>] create_dir+0x43/0x23f
> [   41.024000]  [<c01b53fc>] sysfs_create_subdir+0x26/0x28
> [   41.024000]  [<c01b6c56>] sysfs_create_group+0x77/0x97
> [   41.024000]  [<c02903af>] dpm_sysfs_add+0x1e/0x20
> [   41.024000]  [<c028f6b3>] device_pm_add+0x64/0x89
> [   41.024000]  [<c028930a>] device_add+0x1d9/0x380
> [   41.024000]  [<c02894cb>] device_register+0x1a/0x20
> [   41.024000]  [<c0289811>] device_create+0xaa/0xc4
> [   41.024000]  [<f8a0c472>] snd_register_device+0xcf/0x104 [snd]
> [   41.024000]  [<f8abd0c2>] snd_sequencer_device_init+0x4e/0x7c [snd_seq]
> [   41.024000]  [<f8abd02f>] alsa_seq_init+0x2f/0x51 [snd_seq]
> [   41.024000]  [<c014186c>] sys_init_module+0x163/0x221
> [   41.024000]  [<c0103135>] sysenter_past_esp+0x56/0x8d
> [   41.024000]  [<b7fb0410>] 0xb7fb0410
> [   41.024000]  [<c0104017>] show_trace_log_lvl+0x2f/0x45
> [   41.024000]  [<c01040ee>] show_stack_log_lvl+0x98/0xb2
> [   41.024000]  [<c0104351>] show_registers+0x1eb/0x289
> [   41.024000]  [<c0104587>] die+0x134/0x241
> [   41.024000]  [<c0385e80>] do_page_fault+0x395/0x620
> [   41.024000]  [<c0384401>] error_code+0x39/0x40
> [   41.024000]  [<c0184d42>] __lookup_hash+0x9d/0xcc
> [   41.024000]  [<c0184e02>] lookup_one_len+0x71/0x86
> [   41.024000]  [<c01b51da>] create_dir+0x43/0x23f
> [   41.024000]  [<c01b53fc>] sysfs_create_subdir+0x26/0x28
> [   41.024000]  [<c01b6c56>] sysfs_create_group+0x77/0x97
> [   41.024000]  [<c02903af>] dpm_sysfs_add+0x1e/0x20
> [   41.024000]  [<c028f6b3>] device_pm_add+0x64/0x89
> [   41.024000]  [<c028930a>] device_add+0x1d9/0x380
> [   41.024000]  [<c02894cb>] device_register+0x1a/0x20
> [   41.024000]  [<c0289811>] device_create+0xaa/0xc4
> [   41.024000]  [<f8a0c472>] snd_register_device+0xcf/0x104 [snd]
> [   41.024000]  [<f8abd0c2>] snd_sequencer_device_init+0x4e/0x7c [snd_seq]
> [   41.024000]  [<f8abd02f>] alsa_seq_init+0x2f/0x51 [snd_seq]
> [   41.024000]  [<c014186c>] sys_init_module+0x163/0x221
> [   41.024000]  [<c0103135>] sysenter_past_esp+0x56/0x8d
> [   41.024000]  =======================
> [   41.024000] Code: 42 fc 89 c3 8b 40 04 0f 18 00 90 3b 55 ec 75 e6 8b 45 f0 83 c4 10 5b 5e 5f 5d c3 89 1c 24 e8 27 e9 ff ff 89 c6 8b 45 0c 8b 78 48 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 bd f6 
> [   41.024000] EIP: [<c01b5771>] sysfs_lookup+0x65/0xb0 SS:ESP 0068:f6c35de0
> [   41.024000]  
> 
> 
> There's only one BUG at each boot, and both alternate for no particular
> reason.
> 
> The lspci, dmesg and .config  can be found at:
> http://fdeweerdt.free.fr/drm_bug/
> 
> Any ideas for further investigation?
> 
> Thanks,
> Frederik
> 
> [1] Andrew, could it be possible to put the 'mm.patch' at the very end
> or at the very beginning of the patches? It is misleading to have the
> kernel change it's name in the middle of a bisection :).
