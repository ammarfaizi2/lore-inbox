Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWAAPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWAAPTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWAAPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:19:40 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:52344 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750706AbWAAPTj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:19:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bgY1jSWuKzataAJ9v1pU/rwRcI54eeZRCWJH3r5F3QpfpIWD1/ZEQLaQaP8MM2nxoNbAb+iJge3OZPuDNRfbr+EV1d4rMzH5FXN7ze5Q2Pa55BYPCnljTIjyu49qcHiNW8ur29FugHwTXXOLK30zg/WGRnn0NhVwMxcXpa6PXuw=
Message-ID: <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
Date: Sun, 1 Jan 2006 07:19:38 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rc7-rt1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1136054936.6039.125.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228172643.GA26741@elte.hu>
	 <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
	 <1136051113.6039.109.camel@localhost.localdomain>
	 <1136054936.6039.125.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sat, 2005-12-31 at 12:45 -0500, Steven Rostedt wrote:
>
> > [...]
> > >  [<df111b4f>] rtc_ioctl+0xf/0x20 [rtc] (8)
> >
> > Hmm, which rtc_ioctl?
>
> Never mind, I figured out that this is the generic rtc.  (late night
> last night -pre-New-Years-, so I'm not thinking all that well today).
>
> >
> > >  [<c0170e68>] do_ioctl+0x78/0x90 (28)
> > >  [<c0171017>] vfs_ioctl+0x57/0x1f0 (32)
> > >  [<c01711e9>] sys_ioctl+0x39/0x60 (28)
> > >  [<c01031b5>] syscall_call+0x7/0xb (-8116)
> > > Code: 00 e9 30 ff ff ff e8 fe d7 19 e1 eb 8c be 53 00 00 00 bb f4 25 11 df 89
> > > 74 24 08 89 5c 24 04 c7 04 24 0a 26 11 df e8 de 9c 00 e1 <0f> 0b 53 00 f4 25 11
> > > df e9 73 ff ff ff e8 cc d7 19 e1 e9 63 f9
> > >  Segmentation fault
> > >
> > > This looks like it's due to some timer - mplayer opens /dev/rtc if you want
> > > to know. A second invocation of mplayer went fine, I guess due to
> > > /dev/rtc still having a refcount of >0 and therefore not able to be opened
> > > again.
> > >
> > > AFA-IIRC this did not happen with (my own portage of) 2.6.15-rc5-rt4 into
> > > 2.6.15-rc7 (on the very day that rc7 was released).
> > > If you need config.gz/.config or other info, please let me know.
> >
> > Yeah, could you send it. If anything, just so I know which rtc_ioctl is
> > used.
>
> Don't bother.
>
> >
> > >
> > >
> > > I also notice that mplayer uses approximately a lot more CPU, as shown in
> > > top when CONFIG_HIGH_RES_TIMERS=y. That is, without highres timers, mplayer
> > > uses less than 1%, with hrt it's somewhere between 10% and 18%.
> > > I practically just ran the decoding routine:
> > >   `mplayer -ao null sometrack.ogg`.
>
> I haven't gotten around to the CPU usage part (maybe Thomas has time for
> that).
>
<SNIP>
>
>
> You can very well have a timer pending when calling add.
>
> Looking at the vanilla kernel rtc.c, all these are protected by the
> rtc_lock.  So this was changed by -rt.
>
> So Ingo, Thomas or John, is it OK to put that back or what?
>
> -- Steve
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


Hi all,
   Happy New Year.

   Is this the same problem Steven? It happened when running MythTV
for the first time. Rerunning MythTV did not cause a second problem
and the program then ran fine.

- Mark

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/timer.h:83
invalid operand: 0000 [1] PREEMPT
CPU 0
Modules linked in: snd_seq_midi snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_mi di_event snd_seq realtime sbp2 ohci1394 ieee1394 snd_hdsp
snd_rawmidi snd_seq_de vice snd_hwdep snd_intel8x0 snd_ac97_codec
snd_ac97_bus snd_pcm snd_timer snd sn d_page_alloc radeon drm
Pid: 8553, comm: mythfrontend Not tainted 2.6.15-rc7-rt1 #1
RIP: 0010:[<ffffffff802ae2fa>] <ffffffff802ae2fa>{rtc_do_ioctl+730}
RSP: 0018:ffff81000adb9e08  EFLAGS: 00210282
RAX: 0000000000000000 RBX: 0000000000200202 RCX: ffff81001f9217c0
RDX: 0000000000000000 RSI: ffff81000a6d5030 RDI: ffff81001f9217c0
RBP: 0000000000000001 R08: ffff81000adb8000 R09: 0000000000000001
R10: 00002aaaaaac0660 R11: 0000000000200246 R12: 00000000fffffff3
R13: 0000000000007005 R14: 0000000000000013 R15: 00002aaaab3d3850
FS:  0000000043005960(0063) GS:ffffffff80573800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaac987620 CR3: 00000000063a9000 CR4: 00000000000006e0
Process mythfrontend (pid: 8553, threadinfo ffff81000adb8000, task
ffff81000a6d5 030)
Stack: ffff81001e986bc8 0000000000200246 0000000000200202 0000000000200246
      ffff81001ffa13c0 ffffffff80181331 0000000000008000 0000000000008000
      ffff81000adc56c0 ffff81001e986bc8
Call Trace:<ffffffff80181331>{chrdev_open+449} <ffffffff80181170>{chrdev_open+0}
      <ffffffff801771fc>{__dentry_open+332} <ffffffff804051da>{lock_kernel+42}
      <ffffffff8018b4e4>{do_ioctl+116} <ffffffff8018b7c2>{vfs_ioctl+690}
      <ffffffff8018b85a>{sys_ioctl+106} <ffffffff8010dba6>{system_call+126}


Code: 0f 0b 68 9d 5f 42 80 c2 53 00 48 8b 35 25 54 2a 00 48 c7 c7
RIP <ffffffff802ae2fa>{rtc_do_ioctl+730} RSP <ffff81000adb9e08>
