Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWHRJLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWHRJLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHRJLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:11:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:11913 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751306AbWHRJLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:11:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=fipE/gpZovidFpK/2GGnl2Yng7Lmj7Vt3cO7azkQ0IwdgvTHFGpnxus4nSLkNHWSjEiqCytWG7yTg7mkyZuncB78yiWRg1501Z14FXudS76oZ2d3Tzyk5oeursEYB59DZOP/90IZ8kIpIYLxmOZfuw9Ts2qSZRK947mY4MpWP3k=
Date: Fri, 18 Aug 2006 11:11:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, airlied@linux.ie,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Subject: oops while loading snd-seq-oss (was: Re: 2.6.18-rc4-mm1 BUG, drm related)
Message-ID: <20060818111118.GB1586@slug>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060815130345.GA3817@slug> <20060815071632.b10d3a03.akpm@osdl.org> <20060815173726.GA2533@slug> <20060815092146.f8a6942a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815092146.f8a6942a.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:21:46AM -0700, Andrew Morton wrote:
> On Tue, 15 Aug 2006 17:37:26 +0000
> Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > On Tue, Aug 15, 2006 at 07:16:32AM -0700, Andrew Morton wrote:
> > > On Tue, 15 Aug 2006 13:25:56 +0000
> > > Frederik Deweerdt <deweerdt@free.fr> wrote:
> > > 
> > > > On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > > > > 
> > > > Hi,
> > > > 
> > > > There are two BUGs with 2.6.18-rc4-mm1 that seem related to (I did the
> > > > bisection[1]):
> > > > git-drm.patch
> > > > drm-build-fix.patch
> > > > drm-build-fixes-2.patch
> > > > allow-drm-detection-of-new-via-chipsets.patch
> > > > git-drm-build-fix.patch
> > > > 
> > > > Here's one of the BUGs (the second one is on the web site below).
> > > > [   40.276000] [drm:drm_unlock] *ERROR* Process 8914 using kernel context 0
> > > 
> > > I guess the above is a non-fatal DRM warning.
> > > 
> > > The below is an ALSA oops.
> > Hmm, that's what I thought at first, but consider the second BUG (as I
> > said, both BUGs, the ALSA one and that one appear alternatively):
> > [   35.600000] [drm:drm_unlock] *ERROR* Process 8835 using kernel context 0
> > [   36.328000] BUG: unable to handle kernel paging request at virtual address 746c6139
> 
> 0.7 seconds is a loooong time.
Ok, I think I've been blinded by the coincidence :) This may be a
combination of driver changes and a ALSA bug.
> 
> > [   36.328000]  printing eip:
> > [   36.328000] c01fcf39
> > [   36.328000] *pde = 00000000
> > [   36.328000] Oops: 0000 [#1]
> > [   36.328000] PREEMPT 
> > [   36.328000] last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-0:1.0/bInterfaceProtocol
> > [   36.328000] Modules linked in: snd_seq snd_seq_device ohci_hcd parport_pc parport pcspkr ipw2200 yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_conservative speedstep_centrino freq_table processor ac battery i915 drm tg3 tsdev joydev
> > [   36.328000] CPU:    0
> > [   36.328000] EIP:    0060:[<c01fcf39>]    Not tainted VLI
> > [   36.328000] EFLAGS: 00010297   (2.6.18-rc4-def01 #12) 
> > [   36.328000] EIP is at vsnprintf+0x2da/0x4f9
> > [   36.328000] eax: 746c6139   ebx: 0000000a   ecx: 746c6139   edx: fffffffe
> > [   36.328000] esi: f75fa28c   edi: 00000000   ebp: f3701ebc   esp: f3701e80
> > [   36.328000] ds: 007b   es: 007b   ss: 0068
> > [   36.328000] Process modprobe (pid: 8872, ti=f3700000 task=f7189540 task.ti=f3700000)
> > [   36.328000] Stack: f75fa283 f75fb000 00000002 00000000 0000000a fffffffb 00000000 00000000 
> > [   36.328000]        ffffffff ffffffff ffffffff f75fb000 f7129240 f8a1f980 f7129240 f3701ed8 
> > [   36.328000]        c01948a4 f75fa28c 00000d74 c039b84c f3701eec c039ad97 f3701efc c013fd08 
> > [   36.328000] Call Trace:
> > [   36.328000]  [<c01948a4>] seq_printf+0x32/0x55
> > [   36.328000]  [<c013fd08>] print_unload_info+0x6f/0xe9
> > [   36.328000]  [<c0142073>] m_show+0x4b/0xb5
> > [   36.328000]  [<c019440f>] seq_read+0x248/0x2ee
> > [   36.328000]  [<c0171bef>] vfs_read+0x1c1/0x1c6
> > [   36.328000]  [<c0171f0a>] sys_read+0x4b/0x75
> > [   36.328000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
> > [   36.328000]  [<b7fb7410>] 0xb7fb7410
> > [   36.328000]  [<c0104205>] show_stack_log_lvl+0x98/0xb2
> > [   36.328000]  [<c0104434>] show_registers+0x1b7/0x22f
> > [   36.328000]  [<c010460a>] die+0x11e/0x226
> > [   36.328000]  [<c0379dc2>] do_page_fault+0x38c/0x616
> > [   36.328000]  [<c0103cad>] error_code+0x39/0x40
> > [   36.328000]  [<c01948a4>] seq_printf+0x32/0x55
> > [   36.328000]  [<c013fd08>] print_unload_info+0x6f/0xe9
> > [   36.328000]  [<c0142073>] m_show+0x4b/0xb5
> > [   36.328000]  [<c019440f>] seq_read+0x248/0x2ee
> > [   36.328000]  [<c0171bef>] vfs_read+0x1c1/0x1c6
> > [   36.328000]  [<c0171f0a>] sys_read+0x4b/0x75
> > [   36.328000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
> > [   36.328000] Code: fd ff ff 83 cf 40 bb 10 00 00 00 eb 88 8b 45 14 83 45 14 04 8b 55 e8 8b 08 b8 e4 81 3a c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 0f 85 
> > [   36.328000] EIP: [<c01fcf39>] vsnprintf+0x2da/0x4f9 SS:ESP 0068:f3701e80
> > 
> > Please notice how the BUG comes right after the drm warning.
> 
> Coincidence, I'd say.
> 
> This one looks like something horrid happened in the module dependency
> chain.  Heaven knows.  Using ascii `tle9' as a pointer?
Maybe both BUGs have the same cause, but there must be some kind of race
that makes one appear before the other?
> 
> CONFIG_DEBUG_PAGEALLOC might tell us more.
I've tried enabling it, at it appears that we catch an earlier error:
[   34.988000] [drm:drm_unlock] *ERROR* Process 8826 using kernel context 0
[   35.644000] BUG: unable to handle kernel paging request at virtual address 00716573
[   35.644000]  printing eip:
[   35.644000] c01aeacb
[   35.644000] *pde = 00000000
[   35.644000] Oops: 0000 [#1]
[   35.644000] PREEMPT DEBUG_PAGEALLOC
[   35.644000] last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-0:1.0/bInterfaceProtocol
[   35.644000] Modules linked in: snd_seq snd_seq_device ohci_hcd parport_pc parport pcspkr ipw2200 yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_conservative speedstep_centrino freq_table processor ac battery i915 drm tg3 joydev tsdev
[   35.644000] CPU:    0
[   35.644000] EIP:    0060:[<c01aeacb>]    Not tainted VLI
[   35.644000] EFLAGS: 00210246   (2.6.18-rc4-def01 #18) 
[   35.644000] EIP is at sysfs_dirent_exist+0x4b/0x70
[   35.644000] eax: 00716573   ebx: f36f263c   ecx: f71962a0   edx: f36f263c
[   35.644000] esi: 00716573   edi: c03b4177   ebp: f711fe90   esp: f711fe7c
[   35.644000] ds: 007b   es: 007b   ss: 0068
[   35.644000] Process modprobe (pid: 8864, ti=f711e000 task=c193b540 task.ti=f711e000)
[   35.644000] Stack: f36f263c f36f26a0 f36bf120 c03b4177 ffffffef f711feb0 c01afb95 f36f2694 
[   35.644000]        c03b4177 f7ba4108 00000000 f7ba4000 f7ba4108 f711fed8 c027ece1 f7ba4108 
[   35.644000]        f74b5d08 c03b4177 f7ba416c f7ba4000 f71962a0 f7ba4000 f7ba4108 f711ff08 
[   35.644000] Call Trace:
[   35.644000]  [<c01afb95>] sysfs_create_link+0x4d/0xa2
[   35.644000]  [<c027ece1>] device_add_class_symlinks+0xb0/0x14d
[   35.644000]  [<c027eff1>] device_add+0x1a0/0x37e
[   35.644000]  [<c027f1e9>] device_register+0x1a/0x20
[   35.644000]  [<c027f52f>] device_create+0xaa/0xc4
[   35.644000]  [<f8a0e472>] snd_register_device+0xcf/0x104 [snd]
[   35.644000]  [<f8abd0c2>] snd_sequencer_device_init+0x4e/0x7c [snd_seq]
[   35.644000]  [<f8abd02f>] alsa_seq_init+0x2f/0x51 [snd_seq]
[   35.644000]  [<c0141ab9>] sys_init_module+0x163/0x221
[   35.644000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
[   35.644000]  [<b7fcd410>] 0xb7fcd410
[   35.644000]  [<c0104205>] show_stack_log_lvl+0x98/0xb2
[   35.644000]  [<c0104434>] show_registers+0x1b7/0x22f
[   35.644000]  [<c0104616>] die+0x12a/0x232
[   35.644000]  [<c0377042>] do_page_fault+0x38c/0x616
[   35.644000]  [<c0103cad>] error_code+0x39/0x40
[   35.644000]  [<c01afb95>] sysfs_create_link+0x4d/0xa2
[   35.644000]  [<c027ece1>] device_add_class_symlinks+0xb0/0x14d
[   35.644000]  [<c027eff1>] device_add+0x1a0/0x37e
[   35.644000]  [<c027f1e9>] device_register+0x1a/0x20
[   35.644000]  [<c027f52f>] device_create+0xaa/0xc4
[   35.644000]  [<f8a0e472>] snd_register_device+0xcf/0x104 [snd]
[   35.644000]  [<f8abd0c2>] snd_sequencer_device_init+0x4e/0x7c [snd_seq]
[   35.644000]  [<f8abd02f>] alsa_seq_init+0x2f/0x51 [snd_seq]
[   35.644000]  [<c0141ab9>] sys_init_module+0x163/0x221
[   35.644000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
[   35.644000] Code: f0 eb 12 8b 53 04 8d 42 fc 89 c3 8b 40 04 0f 18 00 90 3b 55 f0 74 2f 8b 43 14 85 c0 74 e5 89 1c 24 e8 39 f0 ff ff 8b 7d 0c 89 c6 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 c4 b8 
[   35.644000] EIP: [<c01aeacb>] sysfs_dirent_exist+0x4b/0x70 SS:ESP 0068:f711fe7c
[   35.644000]  
It looks like %eax is in fact a sort of "seq" string, but I couldn't
figure out why we ended with this pointer :(

There are two facts that might be of interest and that I didn't notice at first:
- modprobe segfaults while loading snd-seq-oss
- if, after getting the oops, I issue a 'find /sys', the process gets
stuck at /sys/class/sound. SysRq+t shows the following stack trace:
[  132.428000] find          D C0372E43  6800  8934   8930                     (NOTLB)
[  132.428000]        f3105e34 c053271c 00000001 c0372e43 00000000 f3105f14 00000000 00000000
[  132.428000]        00000000 dce2a7ac 00000014 00121eac 00000000 f7562000 c19fd664 00000000
[  132.428000]        dd0d9200 00000014 c19fd540 00000000 00000000 00000002 f7788898 00200246
[  132.428000] Call Trace:
[  132.428000]  [<c0373e12>] __mutex_lock_slowpath+0xcc/0x29b
[  132.428000]  [<c0373d36>] mutex_lock+0x24/0x2a
[  132.428000]  [<c01af57a>] sysfs_dir_open+0x25/0x63
[  132.428000]  [<c016df8a>] __dentry_open+0x19d/0x290
[  132.428000]  [<c016e1a8>] nameidata_to_filp+0x38/0x52
[  132.428000]  [<c016e0cc>] do_filp_open+0x4f/0x56
[  132.428000]  [<c016e432>] do_sys_open+0x60/0x10a
[  132.428000]  [<c016e503>] sys_open+0x27/0x29
[  132.428000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
[  132.428000]  [<b7f3b410>] 0xb7f3b410
[  132.428000]  [<c0373e12>] __mutex_lock_slowpath+0xcc/0x29b
[  132.428000]  [<c0373d36>] mutex_lock+0x24/0x2a
[  132.428000]  [<c01af57a>] sysfs_dir_open+0x25/0x63
[  132.428000]  [<c016df8a>] __dentry_open+0x19d/0x290
[  132.428000]  [<c016e1a8>] nameidata_to_filp+0x38/0x52
[  132.428000]  [<c016e0cc>] do_filp_open+0x4f/0x56
[  132.428000]  [<c016e432>] do_sys_open+0x60/0x10a
[  132.428000]  [<c016e503>] sys_open+0x27/0x29
[  132.428000]  [<c0103139>] sysenter_past_esp+0x56/0x8d

Thanks,
Frederik
