Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWGJWUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWGJWUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWGJWUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:20:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:36542 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965020AbWGJWUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:20:06 -0400
Date: Tue, 11 Jul 2006 00:17:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: ray-gmail@madrabbit.org, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Opinions on removing /proc/tty?
In-Reply-To: <787b0d920607100806u613e7594nb6a7a1e2965e11a6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0607110015030.5420@yvahk01.tjqt.qr>
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com> 
 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com> 
 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com> 
 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com> 
 <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com> 
 <20060709193133.GA32457@flint.arm.linux.org.uk> 
 <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com> 
 <Pine.LNX.4.61.0607101601470.5071@yvahk01.tjqt.qr>
 <787b0d920607100806u613e7594nb6a7a1e2965e11a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Just do /proc/*/tty links and all will be good. This even
>> > handles the case of two different names for the same dev_t.
>> > 
>> Is this for the controlling tty? Then it should be ctty.
>
> Eeeew, an extra byte so it can look ugly.
> What other special tty is there?
>
Any fd, for that matter.

00:09 shanghai:/dev/shm > ls -l /proc/$$/fd
total 4
dr-x------  2 jengelh users  0 Jul 11 00:16 .
dr-xr-xr-x  5 jengelh root   0 Jul 11 00:04 ..
lrwx------  1 jengelh users 64 Jul 11 00:16 0 -> /dev/pts/2
lrwx------  1 jengelh users 64 Jul 11 00:16 1 -> /dev/pts/2
lrwx------  1 jengelh users 64 Jul 11 00:16 2 -> /dev/pts/2
lrwx------  1 jengelh users 64 Jul 11 00:16 255 -> /dev/pts/2
and CTTY is /dev/tty1.

So what would /proc/$$/tty - ambiguous name - point to, the normal (attached)
or the ctty? Not to mention exotic, yet possible things

00:09 shanghai:/dev/shm > ls -l /proc/$$/fd
total 4
dr-x------  2 jengelh users  0 Jul 11 00:16 .
dr-xr-xr-x  5 jengelh root   0 Jul 11 00:04 ..
lrwx------  1 jengelh users 64 Jul 11 00:16 0 -> /dev/pts/1
lrwx------  1 jengelh users 64 Jul 11 00:16 1 -> /dev/pts/2
lrwx------  1 jengelh users 64 Jul 11 00:16 2 -> /dev/pts/3
lrwx------  1 jengelh users 64 Jul 11 00:16 255 -> /dev/pts/4
and an even different ctty.

> It's always been "tty" in the kernel as far as I know.
> See "struct tty_struct *tty" in sched.h's struct signal_struct.
>
> Various "ps" programs have always used "TTY" or "TT".
> This makes "tt" more reasonable than "ctty".
>

Jan Engelhardt
-- 
