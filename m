Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314068AbSDZP0A>; Fri, 26 Apr 2002 11:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSDZPZ7>; Fri, 26 Apr 2002 11:25:59 -0400
Received: from [209.249.147.146] ([209.249.147.146]:44807 "EHLO
	addr-mx02.addr.com") by vger.kernel.org with ESMTP
	id <S314068AbSDZPZ5>; Fri, 26 Apr 2002 11:25:57 -0400
Date: Fri, 26 Apr 2002 11:24:23 -0400
From: Daniel Gryniewicz <dang@fprintf.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: dreher@math.tu-freiberg.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7: root filesystem issues
Message-Id: <20020426112423.1c172ab0.dang@fprintf.net>
In-Reply-To: <Pine.GSO.4.21.0204260227270.20558-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002 02:32:23 -0400 (EDT)
Alexander Viro <viro@math.psu.edu> wrote:

> 
> 
> On Fri, 26 Apr 2002, Michael Dreher wrote:
> 
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
> 
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

On a related note (the listing of /dev/root reminded me), as of
2.4.19-pre7-ac2, I can no longer boot with a "root=/dev/discs/disc0/part1"
command line, I have to use "root=/dev/ide/host2/bus0/target0/lun0/part1".  My
previous kernel (2.4.19-pre4-ac2-radix) and all ones before that worked fine
with the first version of the command line.  Is this an intended change or is
it a bug?  I can give more information if necessary, and it's happening on two
different AMD based systems with different chipsets.

Daniel
--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

