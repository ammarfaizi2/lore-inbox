Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWGKBHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWGKBHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 21:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWGKBHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 21:07:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:9778 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751400AbWGKBHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 21:07:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HWfbtBiIWeDXpeCxXXrz/3dwSHby7qjD7ShMR5vDlLgLfFzSK0GPTMqNVujkOr0kq8IH42VPa2EqLSnLSMT8fHHyezEzpHkgHfZUj6MV+WtM63V+cdj1Ty2A/0G/tArc+5fTghCjYVp8CLudCylKxWaJgQaufGQVoebMrPklpGQ=
Message-ID: <787b0d920607101807j2804023v17f7643bffeb2456@mail.gmail.com>
Date: Mon, 10 Jul 2006 21:07:46 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Opinions on removing /proc/tty?
Cc: ray-gmail@madrabbit.org, "Jon Smirl" <jonsmirl@gmail.com>,
       "Greg KH" <greg@kroah.com>, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0607110015030.5420@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
	 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
	 <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com>
	 <20060709193133.GA32457@flint.arm.linux.org.uk>
	 <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com>
	 <Pine.LNX.4.61.0607101601470.5071@yvahk01.tjqt.qr>
	 <787b0d920607100806u613e7594nb6a7a1e2965e11a6@mail.gmail.com>
	 <Pine.LNX.4.61.0607110015030.5420@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> > Just do /proc/*/tty links and all will be good. This even
> >> > handles the case of two different names for the same dev_t.
> >> >
> >> Is this for the controlling tty? Then it should be ctty.
> >
> > Eeeew, an extra byte so it can look ugly.
> > What other special tty is there?
> >
> Any fd, for that matter.
>
> 00:09 shanghai:/dev/shm > ls -l /proc/$$/fd
> total 4
> dr-x------  2 jengelh users  0 Jul 11 00:16 .
> dr-xr-xr-x  5 jengelh root   0 Jul 11 00:04 ..
> lrwx------  1 jengelh users 64 Jul 11 00:16 0 -> /dev/pts/2
> lrwx------  1 jengelh users 64 Jul 11 00:16 1 -> /dev/pts/2
> lrwx------  1 jengelh users 64 Jul 11 00:16 2 -> /dev/pts/2
> lrwx------  1 jengelh users 64 Jul 11 00:16 255 -> /dev/pts/2
> and CTTY is /dev/tty1.
>
> So what would /proc/$$/tty - ambiguous name - point to, the normal (attached)
> or the ctty? Not to mention exotic, yet possible things

The tty is obviously one and the same as:

a. "tty" in the kernel's struct signal_struct
b. the "TTY" or "TT" reported by ps.
c. what "/dev/tty" refers to

Any other tty is not "the tty". Exactly one tty is special.

On any of Linux, MacOS, Solaris, NetBSD, OpenBSD:

$ ls /dev/tty /dev/ctty
ls: /dev/ctty: No such file or directory
/dev/tty

Lord only knows why FreeBSD has both.
Unlike Linux, they don't supply a man page.
On a Linux system, "man 4 tty" is useful.
On a Solaris system, "man -s 7d tty" is useful.
