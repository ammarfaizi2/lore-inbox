Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSJ0J2S>; Sun, 27 Oct 2002 04:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSJ0J2S>; Sun, 27 Oct 2002 04:28:18 -0500
Received: from [80.66.38.208] ([80.66.38.208]:48133 "EHLO
	cerberos.puchmayr1.linznet.at") by vger.kernel.org with ESMTP
	id <S262326AbSJ0J2Q>; Sun, 27 Oct 2002 04:28:16 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Alexander Puchmayr <alexander.puchmayr@jku.at>
Reply-To: alexander.puchmayr@jku.at
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Swap doesn't work
Date: Sun, 27 Oct 2002 10:34:20 +0100
User-Agent: KMail/1.4.3
References: <20021027092337.GA4507@steel> <000601c27d96$15654540$4500a8c0@cybernet.cz>
In-Reply-To: <000601c27d96$15654540$4500a8c0@cybernet.cz>
Organization: =?utf-8?q?Universit=C3=A4t?= Linz
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210271034.20272.alexander.puchmayr@jku.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Oktober 2002 09:51 schrieb Vladimír Trebický:
> > Does your swap partition show up in /proc/swaps? It has to contain
> > something like this:
>
> I have
> /dev/hda6                       partition       594364  0       -1
> in my /proc/swaps
>
> > Btw, do you see something swap-related in dmesg? Like:
> >
> >   Unable to find swap-space signature
> >   Unable to handle swap header version ...
> >   Swap area shorter than signature indicates
> >   Empty swap-file
> >
> > And do you actually see something like this:
> >   Adding Swap: 506008k swap-space (priority -1)
>
> In dmesg I see only this, but some problem with signanture is in syslog
> (at the
> end of this mail)
>
> $ dmesg | grep swap
> Starting kswapd
> Adding Swap: 594364k swap-space (priority -1)
>
> > How did you initialized the swap partition? Recent kernels support both
> > v1 and v2 swaps, which is can be set for mkswap using -v0 (-v1).
> > Actually i mean did you initialized it at all? 8)
>
> I just created a partition with fdisk /dev/hda6, done "mkswap /dev/hda6"
> put the information to /etc/fstab and turned it on with "swapon -a". TOP
> shows Swap:  594364K av,       0K used,  594364K free
>
> syslog logs these kinds of kernel messages (those I guess are important):
>
> Sep 29 22:04:19 shunka kernel: swap_free: Bad swap offset entry 1b3d0000
> ...
> Sep 29 22:04:19 shunka kernel: swap_free: Bad swap offset entry 1b3d0000
> ...
> Sep 10 10:03:28 shunka2 kernel: swap_dup: Bad swap file entry 00000022
> ...
> Sep  4 21:30:40 shunka kernel: Unable to find swap-space signature       
> // !!!!!!!!
> ...

Just one hint, maybe this works: dump your swap partition witz zeros, i.e. 
dd if=/dev/zero of=/dev/hda6
Keep an eye on the logs  (Any IO-errors here regarding /dev/hda6?)
re-create your swap partition with mkswap

Of course, you should turn off swapping before starting this ;-)

Greetings,
	Alex

-- 
Alexander Puchmayr            Systemadministrator for Theoretical Physics
University Linz, Austria      e-mail: alexander.puchmayr@jku.at
Altenbergerstrasse 69         phone: +43/732/2468-8633
A-4040 Linz-Auhof             FAX:   +43/732/2468-8585
