Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318376AbSH1BSD>; Tue, 27 Aug 2002 21:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSH1BSD>; Tue, 27 Aug 2002 21:18:03 -0400
Received: from [213.4.129.129] ([213.4.129.129]:4982 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id <S318376AbSH1BSC>;
	Tue, 27 Aug 2002 21:18:02 -0400
Date: Wed, 28 Aug 2002 03:21:42 +0200
From: Arador <diegocg@teleline.es>
To: Alexander Viro <viro@math.psu.edu>
Cc: us15@os.inf.tu-dresden.de, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Message-Id: <20020828032142.5a218b08.diegocg@teleline.es>
In-Reply-To: <Pine.GSO.4.21.0208271646090.6084-100000@weyl.math.psu.edu>
References: <20020827224322.24561e60.us15@os.inf.tu-dresden.de>
	<Pine.GSO.4.21.0208271646090.6084-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002 16:47:45 -0400 (EDT)
Alexander Viro <viro@math.psu.edu> escribió:

> IDE merge is b0rken wrt partitioning.  Patchset that is supposed to fix
> that stuff is on ftp.math.psu.edu/pub/viro/IDE/* - waiting for ACK from
> Alan.

Hi. I've tested that stuff.
My extended partition isn't recongnized

this is the partition layout:
#fdisk -l /dev/hdc
Disk /dev/hdc: 255 heads, 63 sectors, 4865 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1   *         1      3935  31607856    5  Extended
/dev/hdc2          1217      2500  10313730   83  Linux
/dev/hdc3          3936      4764   6658942+  83  Linux
/dev/hdc5             1        33    265009+  83  Linux
/dev/hdc6   *        34      1204   9406026   83  Linux
/dev/hdc7          1205      1216     96358+  82  Linux swap

This is the expected behaviour under stable kernels

hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
 hdc: [DM6:DDO] [remap +63] [4865/255/63] hdc1 < hdc5 hdc6 hdc7 > hdc2 hdc3

but under unstable kernels the output is like this:
hdc: hdc1

So hdc6, the root partition can't be mounted. This happens
with/without the patches.


Diego Calleja.
