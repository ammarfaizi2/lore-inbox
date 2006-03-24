Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWCXTPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWCXTPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWCXTPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:15:09 -0500
Received: from node-4024215a.mdw.onnet.us.uu.net ([64.36.33.90]:41971 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S964790AbWCXTPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:15:07 -0500
Date: Fri, 24 Mar 2006 13:15:06 -0600
From: Brandon Low <lostlogic@lostlogicx.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060324191506.GC3381@lostlogicx.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060324021729.GL27559@lostlogicx.com> <20060323182411.7f80b4a6.akpm@osdl.org> <20060324024540.GM27559@lostlogicx.com> <20060323185810.3bf2a4ce.akpm@osdl.org> <20060324032126.GN27559@lostlogicx.com> <20060324033934.161302c1.akpm@osdl.org> <20060324125817.GB3381@lostlogicx.com> <20060324103301.4e6c5a4b.akpm@osdl.org> <20060324183734.GC4173@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324183734.GC4173@suse.de>
X-Operating-System: Linux found 2.6.16-rc5-mm3
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recreated the oops with an untainted kernel, but didn't manage to copy that one down.

Brandon

usb 1-8: USB disconnect, address 6
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000102
 printing eip:
c023e447
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /block/sda/sda2/size
Modules linked in: nls_cp437 deadline_iosched sd_mod vfat fat wlan_tkip wlan_scan_sta ath_pci ath_rate_sample wlan ath_hal w83627hf
hwmon_vid eeprom i2c_isa i2c_ali1563 i2c_core snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_ali5451 snd_ac97_codec
+snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc rtc pcspkr
CPU:    1
EIP:    0060:[<c023e447>]    Tainted: PF     VLI
EFLAGS: 00010046   (2.6.16-mm1 #1)
EIP is at cfq_exit_single_io_context+0x27/0x110
eax: 00000086   ebx: f7dcc124   ecx: f7dcc124   edx: f7dcc124
esi: f645b200   edi: 00000006   ebp: 0000000f   esp: f6a99e44
ds: 007b   es: 007b   ss: 0068
Process hald-addon-stor (pid: 11786, threadinfo=f6a99000 task=f6546030)
Stack: <0>f65460e8 00000001 f6c1c070 f6546030 f7dcc124 00000282 c1b4d384 c023e55a
       f7dcc124 f6a99000 00000286 c02398c7 c1b4d384 c18de960 f6546030 c1b4d384
       c01213f6 f6546030 c0452b40 f654649c f6a99f24 00000001 f7e66500 f6a99000
Call Trace:
 <c023e55a> cfq_exit_io_context+0x2a/0x50   <c02398c7> exit_io_context+0x87/0xb0
 <c01213f6> do_exit+0x2a6/0x460   <c012161c> do_group_exit+0x3c/0x90
 <c012c6c9> get_signal_to_deliver+0x229/0x300   <c0102da9> do_signal+0x69/0x160
 <c013781e> ktime_get_ts+0x5e/0x70   <c0246ca2> copy_to_user+0x42/0x60
 <c013807e> hrtimer_nanosleep+0xce/0x150   <c0137f90> nanosleep_wakeup+0x0/0x20
 <c0138167> sys_nanosleep+0x67/0x70   <c0102ed8> do_notify_resume+0x38/0x3c
 <c0103076> work_notifysig+0x13/0x19
Code: 00 00 00 00 83 ec 1c 89 5c 24 10 8b 5c 24 20 89 74 24 14 89 7c 24 18 8b 73 10 85 f6 74 65 8b 3e 9c 58 f6 c4 02 0f 85 82 00 00
00 <8b> 87 fc 00 00 00 e8 0e 3b 15 00 8b 43 14 85 c0 75 57 8b 43 18
 <1>Fixing recursive fault but reboot is needed!

On Fri, 03/24/06 at 19:37:34 +0100, Jens Axboe wrote:
> On Fri, Mar 24 2006, Andrew Morton wrote:
> > Brandon Low <lostlogic@lostlogicx.com> wrote:
> > >
> > > On Fri, 03/24/06 at 03:39:34 -0800, Andrew Morton wrote:
> > > > Brandon Low <lostlogic@lostlogicx.com> wrote:
> > > > >
> > > > >  I hadn't noticed immediately in the ooops, but it is something to do
> > > > >  with the Hardware Abstraction Layer Daemon from http://freedesktop.org/Software/hal
> > > > >  I can't reproduce it without that daemon loaded either.  I wonder if the
> > > > >  last accessed sysfs file mentioned in the oops (sda/size) is relevent
> > > > >  also.
> > > > > 
> > > > >  My exact steps (with hald loaded) are:
> > > > >  plug in ipod
> > > > >  mount /mnt/ipod
> > > > >  unzip -d /mnt/ipod rockbox.zip
> > > > >  eject /dev/sda
> > > > >  unplug ipod
> > > > >  immediately here, the oops prints.
> > > > 
> > > > Still no joy, alas.
> > > > 
> > > > git-cfq.patch plays with the elevator exit code for all IO schedulers. 
> > > > Would you be able to do
> > > > 
> > > > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/git-cfq.patch
> > > > patch -p1 -R < git-cfq.patch
> > > > 
> > > > and retest?
> > > > 
> > > > Thanks.
> > > 
> > > It is definitely this patch.  Identical steps (also used an untainted
> > > kernel for both tests) on -mm1 with and without that patch, and when the
> > > patch is reversed, I cannot cause the oops.  I booted into single user
> > > mode (to dodge tainting and any other weirdness), started the dbus
> > > system message daemon and hald (which depends on dbus), then performed
> > > the steps mentioned above.
> > > 
> > 
> > Great.  Thanks for working that out.  It's time to add the dreaded Cc.
> 
> Can I see that oops?
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
