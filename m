Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWGCTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWGCTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWGCTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:17:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751230AbWGCTRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:17:24 -0400
Date: Mon, 3 Jul 2006 12:17:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Message-Id: <20060703121717.b36ef57e.akpm@osdl.org>
In-Reply-To: <a44ae5cd0607030704q63f1f64x5e46688cef6fa44c@mail.gmail.com>
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
	<20060703014016.9f598cef.akpm@osdl.org>
	<a44ae5cd0607030704q63f1f64x5e46688cef6fa44c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 07:04:05 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> On 7/3/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Mon, 3 Jul 2006 01:31:36 -0700
> > "Miles Lane" <miles.lane@gmail.com> wrote:
> >
> > > I get a system lockup on my laptop every time I remove my Linksys USB
> > > 10/100 Ethernet adapter.  Unfortunately, my laptop has no serial port,
> > > so debugging this kernel is difficult.  I tried netconsole tonight,
> > > but only got:
> > >
> > > BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
> >
> > Nice.
> >
> > >  printing eip:
> > > c101a44d
> > > *pde = 00000000
> > > Oops: 0000 [#1]
> > > 4K_STACKS PREEMPT
> > > last sysfs file: /block/hda/hda9/stat
> > > Modules linked in: netconsole binfmt_misc i915 drm ipv6
> > > speedstep_centrino cpufreq_powersave cpufreq_performance
> > > cpufreq_conservative video thermal button nls_ascii nls_cp437 vfat fat
> > > nls_utf8 ntfs nls_base md_mod sr_mod sbp2 scsi_mod parport_pc lp
> > > parport rtl8150 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
> > > snd_mixer_oss snd_pcm snd_timer snd evdev soundcore ipw2200
> > > intel_agpc3 89 e5 53 fa 61 0b 01 1d 14 c1 c7 14 3c 00 00 00 b0 1a 00
> > > eb <8b> 8b 43 85 75
> > >
> > > What should I try now?  I somehow doubt that I can make the kernel
> > > send info to a USB tty port.
> > >
> >
> > Can you get it to happen on the VGA console, make a record of the display?
> > (Digital photo is good).
> >
> >
> 

OK, thanks.  I uploaded that to
http://www.zip.com.au/~akpm/linux/patches/stuff/00003.jpg.

So we have a use-after-free in tasklet_action(), as a consequence of
unplugging a USB ethernet adapter.

The post-2.6.17 changes in drivers/usb/net/ are relatively modest, but
certainly enough to cause lifetime problems.  Do you know whether mainline
has the same bug?  And are you able to identify at which kernel version
this started to happen?

Thanks.

