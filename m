Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbTCLIQI>; Wed, 12 Mar 2003 03:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263090AbTCLIQI>; Wed, 12 Mar 2003 03:16:08 -0500
Received: from noc6.BelWue.DE ([129.143.2.12]:47774 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id <S263089AbTCLIQG>;
	Wed, 12 Mar 2003 03:16:06 -0500
Date: Wed, 12 Mar 2003 09:26:23 +0100 (MET)
From: Oliver Tennert <tennert@science-computing.de>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: Kernel setup()
Message-ID: <Pine.GHP.4.53.0303120915340.16277@alderaan.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I am lacking some understanding concerning the setup() routine of Linux
>=2.4.19.

If I understand it right, then with kernel version 2.4.19, some novelties
concerning the handling of initrd and rootdevs has entered the kernel.

The same "linuxrc" program, e.g., can work with a 2.4.18, but not with a
2.4.19/20.

I have thought (and the initrd documentation in the Documentation/
directory states it, too) that the pivot_root mechanism is the "new one",
whereas the change_root machanism which automatically takes place if the
linuxrc programs exits for some reason, is the "old one".

Now have a look a the following example linuxrc sniplet, taken from
SuSE-7.3/8.0.


--- mk_initrd   Tue Mar  4 14:13:43 2003
+++ mk_initrd   Tue Mar  4 14:14:43 2003
...

 mount -n -t proc proc /proc
+echo 0x0100 > /proc/sys/kernel/real-root-dev
 mount -n -t $rootfstype $rootdev /mnt
 rm -f /mnt/.initrd 2>/dev/null
 mkdir -p /mnt/.initrd
..

The point is that without the "echo ..." line, the mounting of the
__real__ root device (harddisk partition) won't work for kernels >=2.4.19.

On the other hand, this should actually not be necessary if using a
pivot_root call.

Recent distributions now handle the problem by just having linuxrc loading
the necessary modules and exiting all of a sudden, and everything works.

My question is: is pivot_root deprecated by now? I just am quite dazzled
and want to know how to __cleanly__ handle the mounting of a new root
device.

Best regards

Oliver


		   Dr. Oliver Tennert

  		   +49 -7071 -9457-598

 		   e-mail: O.Tennert@science-computing.de
  		   science + computing AG
  		   Hagellocher Weg 71
   		   D-72070 Tuebingen


