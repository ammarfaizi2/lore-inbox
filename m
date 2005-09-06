Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVIFJUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVIFJUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVIFJUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:20:44 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:48903 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S932453AbVIFJUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:20:43 -0400
Date: Tue, 6 Sep 2005 11:20:30 +0200 (CEST)
From: gl@dsa-ac.de
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: input/touchscreen (was Re: who sets boot_params[].screen_info.orig_video_isVGA?)
In-Reply-To: <431D5442.1030002@gmail.com>
Message-ID: <Pine.LNX.4.63.0509061052080.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
 <E1ECIub-00088O-00@chiark.greenend.org.uk> <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
 <431CEEAF.5090701@gmail.com> <Pine.LNX.4.63.0509060918310.11341@pcgl.dsa-ac.de>
 <431D5442.1030002@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005, Antonino A. Daplas wrote:

> There might be a bug with the ioremap patch that got in by the time
> linux-2.6.13 was released. The intelfb maintainer is still working on it.
> You can try to revert that patch (just make sure that the graphics
> aperture in the BIOS is set to <= 128MB) or use vesafb for now.
>
> Here's the link to that patch:
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=6bd49341f2806168c877e12cefca77b93437bac2;hp=89204c40a03346cd951e698d854105db4cfedc28

Indeed, reverting this patch I get fb, but I still get those "cursor was 
killed" messages permanently, and, indeed, there is no cursos, and 
starting X over fb produces:

(EE) FBDEV(0): FBIOPUT_VSCREENINFO: Invalid argument
(EE) FBDEV(0): mode initialization failed

Actually, I did manage to get it working with vesafb in 0x111 mode and X 
over it. So far so good. Now to my actual task - touchscreen... We are 
using UR7HCTS2-FG from Semtech. As I cat /dev/input/ts0 and touch the 
screen, some bytes come out, but that's about all I can say. I guess, it 
should be used with summa protocol, right? X doesn't want to accept summa 
device as a core pointer, gpm -t summa produces only errors:

Error in read()ing first: No such file or directory

from strace looke like it cannot write to it:

6977  open("/dev/input/ts0", O_RDWR|O_NONBLOCK) = 0
6977  fcntl64(0, F_GETFL)               = 0x802 (flags O_RDWR|O_NONBLOCK)
6977  fcntl64(0, F_SETFL, O_RDWR)       = 0
6977  ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbf9bb56c) = -1 EINVAL (Invalid argument)
6977  ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbf9bb53c) = -1 EINVAL (Invalid argument)
6977  ioctl(0, SNDCTL_TMR_CONTINUE or TCSETSF, {B9600 -opost -isig -icanon -echo ...}) = -1 EINVAL (Invalid argument)
6977  write(0, "*q", 2)                 = -1 EINVAL (Invalid argument)
6977  nanosleep({0, 100000000}, NULL)   = 0
6977  ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbf9bb53c) = -1 EINVAL (Invalid argument)
6977  ioctl(0, SNDCTL_TMR_CONTINUE or TCSETSF, {B9600 -opost -isig -icanon -echo ...}) = -1 EINVAL (Invalid argument)
6977  write(0, NULL, 1)                 = -1 EINVAL (Invalid argument)
6977  nanosleep({0, 400000000}, NULL)   = 0
6977  write(0, "B", 1)                  = -1 EINVAL (Invalid argument)
6977  write(0, "z?", 2)                 = -1 EINVAL (Invalid argument)
6977  select(1024, [0], NULL, NULL, {0, 200000}) = 0 (Timeout)
6977  write(0, NULL, 1)                 = -1 EINVAL (Invalid argument)
6977  nanosleep({0, 400000000}, NULL)   = 0
...

and reading from it doesn't get any bytes:

6977  select(2, [0 1], NULL, NULL, {86400, 0}) = 1 (in [0], left {86400, 0})
6977  open("/dev/tty0", O_RDONLY)       = 2
6977  ioctl(2, KDGETMODE, 0xbf9bb7d4)   = 0
6977  close(2)                          = 0
6977  read(0, "", 1)                    = 0

It's a completely different topic now, jost in case - any ideas anybody?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
