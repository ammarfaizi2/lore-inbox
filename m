Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313680AbSDZGc0>; Fri, 26 Apr 2002 02:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313681AbSDZGcZ>; Fri, 26 Apr 2002 02:32:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313680AbSDZGcY>;
	Fri, 26 Apr 2002 02:32:24 -0400
Date: Fri, 26 Apr 2002 02:32:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Dreher <dreher@math.tu-freiberg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7: rootfs mounted twice
In-Reply-To: <200204261520.g3QFKbQ00938@karpfen.mathe.tu-freiberg.de>
Message-ID: <Pine.GSO.4.21.0204260227270.20558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Apr 2002, Michael Dreher wrote:

> dreher@karpfen:~ > df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> rootfs                 7060308   6276188    425472  94% /

df(1) is wrong.  There is (see /proc/mounts below) rootfs mounted as
root (ramfs, actually) and ext3 mounted over it.  df sees two entries
in /etc/mtab (on your box - /proc/mounts) with mountpoint "/" and
does statfs("/", &buf); for both.  Surprise, surprise, results of
two calls of statf2(2) are identical - what with arguments being
the same both times - and refer to the filesystem where your "/"
lives.  I.e. to ext3.

> /dev/root              7060308   6276188    425472  94% /
> /dev/hda4              3794936   3042316    559840  84% /home
> 
> dreher@karpfen:~ > cat /proc/mounts
> rootfs / rootfs rw 0 0
> /dev/root / ext3 rw,noatime,nodiratime 0 0
> proc /proc proc rw 0 0
> /dev/hda4 /home ext3 rw,noatime,nodiratime 0 0
> usbdevfs /proc/bus/usb usbdevfs rw 0 0
> devpts /dev/pts devpts rw 0 0


