Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSDZROj>; Fri, 26 Apr 2002 13:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313715AbSDZROi>; Fri, 26 Apr 2002 13:14:38 -0400
Received: from [195.39.17.254] ([195.39.17.254]:37520 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313571AbSDZROi>;
	Fri, 26 Apr 2002 13:14:38 -0400
Date: Fri, 26 Apr 2002 18:15:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Michael Dreher <dreher@math.tu-freiberg.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7: rootfs mounted twice
Message-ID: <20020426161540.GF3783@elf.ucw.cz>
In-Reply-To: <200204261520.g3QFKbQ00938@karpfen.mathe.tu-freiberg.de> <Pine.GSO.4.21.0204260227270.20558-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > dreher@karpfen:~ > df
> > Filesystem           1k-blocks      Used Available Use% Mounted on
> > rootfs                 7060308   6276188    425472  94% /
> 
> df(1) is wrong.  There is (see /proc/mounts below) rootfs mounted as
> root (ramfs, actually) and ext3 mounted over it.  df sees two entries
> in /etc/mtab (on your box - /proc/mounts) with mountpoint "/" and
> does statfs("/", &buf); for both.  Surprise, surprise, results of
> two calls of statf2(2) are identical - what with arguments being
> the same both times - and refer to the filesystem where your "/"
> lives.  I.e. to ext3.

df might be wrong, but lets say that this /proc/mounts become
interesting. This could not have happened in the past. That means you
changed kernel interface in stable series, and that's wrong.

> > /dev/root              7060308   6276188    425472  94% /
> > /dev/hda4              3794936   3042316    559840  84% /home
> > 
> > dreher@karpfen:~ > cat /proc/mounts
> > rootfs / rootfs rw 0 0
> > /dev/root / ext3 rw,noatime,nodiratime 0 0
> > proc /proc proc rw 0 0
> > /dev/hda4 /home ext3 rw,noatime,nodiratime 0 0
> > usbdevfs /proc/bus/usb usbdevfs rw 0 0
> > devpts /dev/pts devpts rw 0 0

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
