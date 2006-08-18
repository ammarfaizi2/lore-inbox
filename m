Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWHRQo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWHRQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHRQo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:44:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:4444 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751414AbWHRQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:44:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=B3ZFBUIdci7eWvavkq3ca/HqLx4wDjMQ0svZlqDv/gDwPmwrqaq1koQBThisdvvCPb6gc3Lgkeni4+rYVQ8gOnMUGZqqehnZhsSa4yvjjR37BWlgjaagjhrgO9uoggVOFq4YkGlUh0QmaWhsPJS/9kfbNBpVQNkF/0pqdQyUzYU=
Date: Fri, 18 Aug 2006 18:44:11 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       airlied@linux.ie, Jaroslav Kysela <perex@suse.cz>
Subject: Re: oops while loading snd-seq-oss (was: Re: 2.6.18-rc4-mm1 BUG, drm related)
Message-ID: <20060818184411.GA720@slug>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060815130345.GA3817@slug> <20060815071632.b10d3a03.akpm@osdl.org> <20060815173726.GA2533@slug> <20060815092146.f8a6942a.akpm@osdl.org> <20060818111118.GB1586@slug> <20060818085220.2f679f9c.akpm@osdl.org> <s5hsljuyr1h.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsljuyr1h.wl%tiwai@suse.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 05:58:18PM +0200, Takashi Iwai wrote:
> At Fri, 18 Aug 2006 08:52:20 -0700,
> Andrew Morton wrote:
> > 
> > On Fri, 18 Aug 2006 11:11:18 +0000
> > Frederik Deweerdt <deweerdt@free.fr> wrote:
> > 
> > > > CONFIG_DEBUG_PAGEALLOC might tell us more.
> > > I've tried enabling it, at it appears that we catch an earlier error:
> > > [   34.988000] [drm:drm_unlock] *ERROR* Process 8826 using kernel context 0
> > > [   35.644000] BUG: unable to handle kernel paging request at virtual address 00716573
> > > [   35.644000]  printing eip:
> > > [   35.644000] c01aeacb
> > > [   35.644000] *pde = 00000000
> > > [   35.644000] Oops: 0000 [#1]
> > > [   35.644000] PREEMPT DEBUG_PAGEALLOC
> > > [   35.644000] last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb5/5-0:1.0/bInterfaceProtocol
> > > [   35.644000] Modules linked in: snd_seq snd_seq_device ohci_hcd parport_pc parport pcspkr ipw2200 yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_conservative speedstep_centrino freq_table processor ac battery i915 drm tg3 joydev tsdev
> > > [   35.644000] CPU:    0
> > > [   35.644000] EIP:    0060:[<c01aeacb>]    Not tainted VLI
> > > [   35.644000] EFLAGS: 00210246   (2.6.18-rc4-def01 #18) 
> > > [   35.644000] EIP is at sysfs_dirent_exist+0x4b/0x70
> > > [   35.644000] eax: 00716573   ebx: f36f263c   ecx: f71962a0   edx: f36f263c
> > > [   35.644000] esi: 00716573   edi: c03b4177   ebp: f711fe90   esp: f711fe7c
> > > [   35.644000] ds: 007b   es: 007b   ss: 0068
> > > [   35.644000] Process modprobe (pid: 8864, ti=f711e000 task=c193b540 task.ti=f711e000)
> > > [   35.644000] Stack: f36f263c f36f26a0 f36bf120 c03b4177 ffffffef f711feb0 c01afb95 f36f2694 
> > > [   35.644000]        c03b4177 f7ba4108 00000000 f7ba4000 f7ba4108 f711fed8 c027ece1 f7ba4108 
> > > [   35.644000]        f74b5d08 c03b4177 f7ba416c f7ba4000 f71962a0 f7ba4000 f7ba4108 f711ff08 
> > > [   35.644000] Call Trace:
> > > [   35.644000]  [<c01afb95>] sysfs_create_link+0x4d/0xa2
> > > [   35.644000]  [<c027ece1>] device_add_class_symlinks+0xb0/0x14d
> > > [   35.644000]  [<c027eff1>] device_add+0x1a0/0x37e
> > > [   35.644000]  [<c027f1e9>] device_register+0x1a/0x20
> > > [   35.644000]  [<c027f52f>] device_create+0xaa/0xc4
> > > [   35.644000]  [<f8a0e472>] snd_register_device+0xcf/0x104 [snd]
> > > [   35.644000]  [<f8abd0c2>] snd_sequencer_device_init+0x4e/0x7c [snd_seq]
> > > [   35.644000]  [<f8abd02f>] alsa_seq_init+0x2f/0x51 [snd_seq]
> > > [   35.644000]  [<c0141ab9>] sys_init_module+0x163/0x221
> > > [   35.644000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
> > > [   35.644000]  [<b7fcd410>] 0xb7fcd410
> > > [   35.644000]  [<c0104205>] show_stack_log_lvl+0x98/0xb2
> > > [   35.644000]  [<c0104434>] show_registers+0x1b7/0x22f
> > > [   35.644000]  [<c0104616>] die+0x12a/0x232
> > > [   35.644000]  [<c0377042>] do_page_fault+0x38c/0x616
> > > [   35.644000]  [<c0103cad>] error_code+0x39/0x40
> > > [   35.644000]  [<c01afb95>] sysfs_create_link+0x4d/0xa2
> > > [   35.644000]  [<c027ece1>] device_add_class_symlinks+0xb0/0x14d
> > > [   35.644000]  [<c027eff1>] device_add+0x1a0/0x37e
> > > [   35.644000]  [<c027f1e9>] device_register+0x1a/0x20
> > > [   35.644000]  [<c027f52f>] device_create+0xaa/0xc4
> > > [   35.644000]  [<f8a0e472>] snd_register_device+0xcf/0x104 [snd]
> > > [   35.644000]  [<f8abd0c2>] snd_sequencer_device_init+0x4e/0x7c [snd_seq]
> > > [   35.644000]  [<f8abd02f>] alsa_seq_init+0x2f/0x51 [snd_seq]
> > > [   35.644000]  [<c0141ab9>] sys_init_module+0x163/0x221
> > > [   35.644000]  [<c0103139>] sysenter_past_esp+0x56/0x8d
> > > [   35.644000] Code: f0 eb 12 8b 53 04 8d 42 fc 89 c3 8b 40 04 0f 18 00 90 3b 55 f0 74 2f 8b 43 14 85 c0 74 e5 89 1c 24 e8 39 f0 ff ff 8b 7d 0c 89 c6 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 c4 b8 
> > > [   35.644000] EIP: [<c01aeacb>] sysfs_dirent_exist+0x4b/0x70 SS:ESP 0068:f711fe7c
> > > [   35.644000]  
> > > It looks like %eax is in fact a sort of "seq" string, but I couldn't
> > > figure out why we ended with this pointer :(
> > 
> > If you had CONFIG_PCI_MULTITHREAD_PROBE enabled, please try disabling it.
It's not set
> 
> If the oops occurs at the manual loading of snd-seq-oss module, this
> options would be hardly related.  But, it's worth to try.
> 
> Frederik, what hardware are you using?  Is it emu10k1?
You'll find the lspci output, dmesg, .config at
http://fdeweerdt.free.fr/drm_bug/, I mentioned it previously on the
thread, but at that time I thought it was related with drm (I must have
messed up with my bisection) so you weren't CC'd, sorry.

Anyway, the relevant line in the lspci is:
00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
Which uses the snd_intel8x0 module.

> I'm wondering how is the order of module/driver initialization.
> Does this bug happens if you load snd-seq manually before snd-seq-oss?
I'll try and send you the results asap.
> 
> Last but not least, is the oops avoided when you disable alsa-git
> patch?
Ditto.

Thanks,
Frederik
