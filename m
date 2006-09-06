Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWIFAKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWIFAKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWIFAKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:10:13 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:36107 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965248AbWIFAKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:10:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGcPUyxCHZtG4GHU4TLeaFGYoM7IjMgo/Q1rltBgoI5LsM3s5tIyQWY9N01OTMpNwE4b1F1JLEC5Hk0Hfn6RP+YOOp0/VxHQjOK7jMad/yCFHVLfIyoeuGkDLtq/nHT38K04HUC9crtfG1QDy3TZiRkvp8jbOb3DMK7is0uKoWg=
Message-ID: <9151ac2a0609051710m7f5d30e3gdcfced3676d43869@mail.gmail.com>
Date: Wed, 6 Sep 2006 02:10:10 +0200
From: "Filip Sneppe" <filip.sneppe@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6 (audio-related ?) oops during boot
In-Reply-To: <s5hwt8iijt0.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9151ac2a0609050313h22d3c34fy2fc46124ba6876cc@mail.gmail.com>
	 <s5hwt8iijt0.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/5/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 5 Sep 2006 12:13:24 +0200,
> Filip Sneppe wrote:
> >
> > Hi,
> >
> > I tried out 2.6.18-rc6 today and got this during the boot on my
> > Debian testing machine:
> >
> > pnp: Device 00:04 disabled.
> > cs: IO port probe 0x100-0x4ff: clean.
> > cs: IO port probe 0x800-0x8ff: clean.
> > cs: IO port probe 0xc00-0xcff: clean.
> > cs: IO port probe 0xa00-0xaff: clean.
> > Adding 730948k swap on /dev/hda2.  Priority:-1 extents:1 across:730948k
> > EXT3 FS on hda5, internal journal
> > kobject_add failed for audio with -EEXIST, don't try to register
> > things with the same name in the same directory.
> >  [<b01aa41c>] kobject_add+0x13c/0x163
> >  [<b0205b01>] class_device_add+0x9f/0x3c1
> >  [<b01aa19c>] kobject_get+0x12/0x17
> >  [<b01aa49d>] kobject_init+0x32/0x43
> >  [<b0205eaf>] class_device_create+0x76/0x98
> >  [<f091c195>] sound_insert_unit+0xea/0x113 [soundcore]
> >  [<f091c387>] register_sound_special_device+0x125/0x12d [soundcore]
> >  [<b01ace3c>] vsnprintf+0x413/0x452
> >  [<f0944d65>] snd_register_oss_device+0x111/0x16c [snd]
> >  [<f0ae74e4>] register_oss_dsp+0x31/0x53 [snd_pcm_oss]
> >  [<b0112318>] __activate_task+0x1c/0x28
> >  [<b01a9fa6>] idr_get_new+0xf/0x30
> >  [<b0177791>] proc_register+0x31/0xd6
> >  [<b0177b93>] create_proc_entry+0x86/0x98
> >  [<f094278e>] snd_create_proc_entry+0xb/0x1a [snd]
> >  [<f094281e>] snd_info_register+0x81/0x86 [snd]
> >  [<f0ae912c>] snd_pcm_oss_register_minor+0x31/0x122 [snd_pcm_oss]
> >  [<b0161667>] alloc_inode+0xf5/0x182
> >  [<b0161e21>] new_inode+0x16/0x6f
> >  [<b0160440>] d_instantiate+0x3a/0x70
> >  [<b017fb6e>] sysfs_new_dirent+0x1a/0x62
> >  [<b017fc64>] sysfs_make_dirent+0x19/0x6e
> >  [<b017f610>] sysfs_add_file+0x48/0x63
> >  [<b0139e0b>] free_hot_cold_page+0x8d/0xd8
> >  [<f0963fa8>] snd_pcm_notify+0x7a/0x9a [snd_pcm]
> >  [<f0889061>] alsa_pcm_oss_init+0x61/0x6e [snd_pcm_oss]
> >  [<b012b225>] sys_init_module+0x13aa/0x1506
> >  [<b0102a09>] sysenter_past_esp+0x56/0x79
> > device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hda1, internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hda8, internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hda6, internal journal
>
> Did you load any other OSS modules in prior?
>
>

This happened during the boot, so I don't know exactly what was already loaded.
The only modules that I know for sure are loaded at boot, are:

ide-cd
ide-disk
ide-generic
psmouse
sound
snd-mixer-oss
snd-pcm-oss

Regards,
Filip
