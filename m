Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTDGOIM (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTDGOIM (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:08:12 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:24212 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263449AbTDGOII (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:08:08 -0400
Date: Mon, 7 Apr 2003 10:15:38 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.66-bk12: "smbfs" module mounted as unsafe
Message-ID: <Pine.LNX.4.44.0304071010160.1529-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  the (annotated) output of a "script" session, trying to use
smbmount to mount an XP share:

  [beginning of session -- note no smbfs module loaded yet]

Script started on Mon 07 Apr 2003 10:07:05 AM EDT
[root@localhost root]# lsmod
Module                  Size  Used by
autofs                 15392  0 
orinoco_cs              8936  1 
orinoco                42752  1 orinoco_cs
hermes                  8832  2 orinoco_cs,orinoco,[permanent]
ds                     15936  3 orinoco_cs
yenta_socket           16128  2 
pcmcia_core            64704  3 orinoco_cs,ds,yenta_socket
ohci1394               33536  0 
ieee1394               69836  1 ohci1394
parport_pc             30404  0 
ide_scsi               15552  0 
scsi_mod               73340  1 ide_scsi
ide_cd                 40672  0 
cdrom                  35648  1 ide_cd

  [try to smbmount ...]

[root@localhost root]# smbmount //treefort/share /mnt/xpshare
Password: 
ERROR: smbfs filesystem not supported by the kernel
Please refer to the smbmnt(8) manual page
smbmnt failed: 255

  [where is smbfs module?  not loaded yet ... why not?]

[root@localhost root]# lsmod
Module                  Size  Used by
autofs                 15392  0 
orinoco_cs              8936  1 
orinoco                42752  1 orinoco_cs
hermes                  8832  2 orinoco_cs,orinoco,[permanent]
ds                     15936  3 orinoco_cs
yenta_socket           16128  2 
pcmcia_core            64704  3 orinoco_cs,ds,yenta_socket
ohci1394               33536  0 
ieee1394               69836  1 ohci1394
parport_pc             30404  0 
ide_scsi               15552  0 
scsi_mod               73340  1 ide_scsi
ide_cd                 40672  0 
cdrom                  35648  1 ide_cd

  [ok, load it manually]

[root@localhost root]# modprobe smbfs

  [and there it is ...]

[root@localhost root]# lsmod
Module                  Size  Used by
smbfs                  66320  0 
autofs                 15392  0 
orinoco_cs              8936  1 
orinoco                42752  1 orinoco_cs
hermes                  8832  2 orinoco_cs,orinoco,[permanent]
ds                     15936  3 orinoco_cs
yenta_socket           16128  2 
pcmcia_core            64704  3 orinoco_cs,ds,yenta_socket
ohci1394               33536  0 
ieee1394               69836  1 ohci1394
parport_pc             30404  0 
ide_scsi               15552  0 
scsi_mod               73340  1 ide_scsi
ide_cd                 40672  0 
cdrom                  35648  1 ide_cd

  [now try to smbmount again ...]

[root@localhost root]# mount //treefort/share /mnt/xpshare
Password: 


[root@localhost root]# lsmod
Module                  Size  Used by
smbfs                  66320  2 [unsafe]     <-- ???????
autofs                 15392  0 
orinoco_cs              8936  1 
orinoco                42752  1 orinoco_cs
hermes                  8832  2 orinoco_cs,orinoco,[permanent]
ds                     15936  3 orinoco_cs
yenta_socket           16128  2 
pcmcia_core            64704  3 orinoco_cs,ds,yenta_socket
ohci1394               33536  0 
ieee1394               69836  1 ohci1394
parport_pc             30404  0 
ide_scsi               15552  0 
scsi_mod               73340  1 ide_scsi
ide_cd                 40672  0 
cdrom                  35648  1 ide_cd

[root@localhost root]# umount /mnt/xpshare

  [what happens when i try to unload smbfs module?]

[root@localhost root]# modprobe -r smbfs
FATAL: Error removing smbfs (/lib/modules/2.5.66-bk12/kernel/fs/smbfs/smbfs.ko): Device or resource busy



  thoughts?  i've never seen this before.

rday

