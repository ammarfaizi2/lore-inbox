Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSGBFdC>; Tue, 2 Jul 2002 01:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSGBFdB>; Tue, 2 Jul 2002 01:33:01 -0400
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:38417 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S316629AbSGBFdA>; Tue, 2 Jul 2002 01:33:00 -0400
Subject: Loopback + NFS: files copied partially with bogus error message.
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Jul 2002 22:35:28 -0700
Message-Id: <1025588128.13795.13.camel@ulthar.internal.mclure.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running two machines, one ("leng") running a Red Hat 2.4.9-31
kernel, the other ("ulthar") running a 2.4.18+lowlatency kernel. On
"leng", I have ISO images of the Red Hat 7.3 install CDs mounted through
loopback, and exported via NFS. "ulthar" mounts the images via NFS from
"leng":

/dev/hda3 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/hda1 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/var/sharedspace/RH73_ISOs/valhalla-i386-disc1.iso on /mnt/rh73/disc1
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH73_ISOs/valhalla-i386-disc2.iso on /mnt/rh73/disc2
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH73_ISOs/valhalla-i386-disc3.iso on /mnt/rh73/disc3
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH73_ISOs/valhalla-SRPMS-disc1.iso on /mnt/rh73/SRPMS1
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH73_ISOs/valhalla-SRPMS-disc2.iso on /mnt/rh73/SRPMS2
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH73_ISOs/valhalla-docs.iso on /mnt/rh73/docs type
iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH72_ISOs/enigma-i386-disc1.iso on /mnt/rh72/disc1 type
iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH72_ISOs/enigma-i386-disc2.iso on /mnt/rh72/disc2 type
iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH72_ISOs/enigma-SRPMS-disc1.iso on /mnt/rh72/SRPMS1
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH72_ISOs/enigma-SRPMS-disc2.iso on /mnt/rh72/SRPMS2
type iso9660 (ro,nosuid,nodev)
/var/sharedspace/RH72_ISOs/enigma-docs.iso on /mnt/rh72/docs type
iso9660 (ro,nosuid,nodev)


[root@ulthar root]# mount
/dev/hdb3 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/hdb1 on /boot type ext3 (rw)
/dev/hdc1 on /home type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /win98c type vfat (rw,gid=100,umask=2)
leng:/var/sharedspace on /sharedspace type nfs (rw,addr=10.1.1.1)
leng:/mnt/rh73/disc1 on /mnt/rh73/disc1 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh73/disc2 on /mnt/rh73/disc2 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh73/disc3 on /mnt/rh73/disc3 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh73/SRPMS1 on /mnt/rh73/SRPMS1 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh73/SRPMS2 on /mnt/rh73/SRPMS2 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh73/docs on /mnt/rh73/docs type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh72/disc1 on /mnt/rh72/disc1 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh72/disc2 on /mnt/rh72/disc2 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh72/SRPMS1 on /mnt/rh72/SRPMS1 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh72/SRPMS2 on /mnt/rh72/SRPMS2 type nfs (ro,addr=10.1.1.1)
leng:/mnt/rh72/docs on /mnt/rh72/docs type nfs (ro,addr=10.1.1.1)
/dev/cdrom on /mnt/cdrom type iso9660 (ro)

This is working fine for accessing the data on the Red Hat images from
"ulthar", unless I am trying to access a large file. If I do on
"ulthar":

[root@ulthar root]# ls -l /tmp/XFree86-4.2.0-8.src.rpm
ls: /tmp/XFree86-4.2.0-8.src.rpm: No such file or directory
[root@ulthar root]# cp /mnt/rh73/SRPMS1/SRPMS/XFree86-4.2.0-8.src.rpm
/tmp
cp: reading `/mnt/rh73/SRPMS1/SRPMS/XFree86-4.2.0-8.src.rpm': No such
file or directory
[root@ulthar root]# ls -l /tmp/XFree86-4.2.0-8.src.rpm
-rw-r--r--    1 root     root      9977856 Jul  1 22:30
/tmp/XFree86-4.2.0-8.src.rpm
[root@ulthar root]# 

As you can see, it does a partial copy and then fails with a "No such
file or directory" error. The size of the file after the failed copy
varies - sometimes I've seen up to 26MB be copied (the actual size of
the file is 42M). No errors are listed in the system logs of either
system. Copies from the loopback filesystem to a local file on "leng"
succeed, as are copies from an ext3 filesystem on "leng" to "ulthar"
over NFS - the problem only seems to happen with the combination.

Does anyone have any idea about what's going on? Thanks!

-- 
Manuel A. McLure KE6TAW <manuel@mclure.org> <http://www.mclure.org>
...for in Ulthar, according to an ancient and significant law,
no man may kill a cat.                       -- H.P. Lovecraft

