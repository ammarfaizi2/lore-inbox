Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271982AbRI0IIC>; Thu, 27 Sep 2001 04:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271987AbRI0IHx>; Thu, 27 Sep 2001 04:07:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46012 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271982AbRI0IHk>;
	Thu, 27 Sep 2001 04:07:40 -0400
Date: Thu, 27 Sep 2001 04:08:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Morten Green Hermansen <mortengh@fanitas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Mounting /dev/hdh1 deletes /dev/hda1
In-Reply-To: <200109270747.f8R7lEP04226@calithturon.fanitas.com>
Message-ID: <Pine.GSO.4.21.0109270403150.29941-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Sep 2001, Morten Green Hermansen wrote:

> 2. I have inserted a new PCI based IDE adapter so I am able to use 8 IDE 
> disks. When mounting them one of the disks on the second controller 
> over-shadows a disk on the first (build-in)

I really doubt it.
 
[snip]
 
> [root@calithturon scripts]# df | grep hdh
> /dev/hdh1              3111408   2448976    504380  83% /
> /dev/hdh1              1771928    752468    929448  45% /mnt/hdh
> 
> (Now hdh1 has shadowed hda1. hdh1 is listed two times and with two different 
> disk sizes)
> See this:
> 
> [root@calithturon scripts]# umount /dev/hda1 (which used to be /)
> umount: /dev/hda1: not mounted

So you've got /etc/mtab fucked up.  Both umount(8) and df(1) read it
to find the set of mountpoints _and_ to get information about the
stuff mounted there.  Information left there by mount(8).

Check the contents of /etc/mtab and /proc/mounts.  If the latter contains
two lines with hdh1 - you've got a kernel bug.  If doesn't and /etc/mtab
does - userland bug in mount(8), talk to util-linux maintainer.

