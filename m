Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWGSDxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWGSDxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 23:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWGSDxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 23:53:42 -0400
Received: from atpro.com ([12.161.0.3]:24588 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932484AbWGSDxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 23:53:42 -0400
Date: Tue, 18 Jul 2006 23:52:54 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Chris Largret <largret@gmail.com>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic related to ReiserFS (v3)
Message-ID: <20060719035253.GF17426@mail>
Mail-Followup-To: Chris Largret <largret@gmail.com>,
	John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
References: <1153208388.8074.18.camel@localhost> <17596.57854.569394.880757@stoffel.org> <1153269675.9726.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153269675.9726.3.camel@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/06 05:41:15PM -0700, Chris Largret wrote:
> On Tue, 2006-07-18 at 09:28 -0400, John Stoffel wrote:
> 
> > Chris> Jul 17 23:42:49 localhost kernel: Modules linked in: usb_storage vmnet
> > Chris> parport_pc parport vmmon snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
> > Chris> ipt_REJECT xt_state iptable_filter nfs lockd nfs_acl sunrpc r8169
> > Chris> ohci1394 ieee1394 emu10k1_gp gameport snd_emu10k1 snd_rawmidi
> > Chris> snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
> > Chris> snd_page_alloc snd_util_mem snd_hwdep snd 8250_pci 8250 serial_core
> > Chris> tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
> > Chris> v4l1_compat v4l2_common btcx_risc videodev nvidia forcedeth i2c_nforce2
> > Chris> pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core
> > Chris> Jul 17 23:42:49 localhost kernel: Pid: 7770, comm: firefox-bin Tainted:
> > Chris> P      2.6.16.16 #1
> > 
> > 
> > You've got a binary kernel module loaded here, please try to re-create
> > this crash without the nvidia module loaded.  We (hah!  Not me
> > actually... :-) can't debug this with such a module.
> > 
> > The key is the 'Tainted' flag.  
> 
> Even though the back-trace doesn't touch the video drivers? I wish I
> could reproduce this easily. I have been using this kernel and firefox
> for several weeks, and this is the first time it has panic'd on me.

Yes, all kernel modules have full reign on the system so they can overwrite
memory not related to them at all. The nVidia could have overwritten some
piece of reiserfs's memory and continued on it's own merry way leaving
reiserfs to panic the next time it looked there. Personally, I use the
nVidia driver all the time and have never had a problem so it's probably
not the culprit, but the only way to be sure is to repeat the problem
without it ever having been loaded. Booting up and rmmod'ing the module
isn't good enough, it has to be a 100% clean boot.

Jim.
