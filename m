Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSGXTPu>; Wed, 24 Jul 2002 15:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317566AbSGXTPu>; Wed, 24 Jul 2002 15:15:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317561AbSGXTPs>; Wed, 24 Jul 2002 15:15:48 -0400
Date: Wed, 24 Jul 2002 15:20:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kareem Dana <kareemy@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
In-Reply-To: <20020724145919.01c79fce.kareemy@earthlink.net>
Message-ID: <Pine.LNX.3.95.1020724151622.31533A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Kareem Dana wrote:

> Hello,
> 
> I've noticed in kernel 2.4.18 that my loop module remains busy after
> I umount the device using it. For example
> 
> mount -t iso9660 -o loop file.iso /mnt
> * loop module gets loaded
> * lsmod shows "loop                    7952   1 (autoclean)"
> * ps ax shows [loop0] process
>

On Linux-2.4.18 there is no such problem here.


Script started on Wed Jul 24 15:13:59 2002
# lsmod
Module                  Size  Used by
st                     29272   0  (autoclean) (unused)
nfs                    46836   0  (autoclean)
lockd                  36988   0  (autoclean) [nfs]
sunrpc                 62812   0  (autoclean) [nfs lockd]
ipchains               33624   6 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17200   0  (unused)
loop                    8472   0 
sr_mod                 11932   0  (unused)
cdrom                  27808   0  [sr_mod]
BusLogic               35768   7 
sd_mod                 10104  14 
scsi_mod               51740   4  [st sr_mod BusLogic sd_mod]
# mount -o loop raw.bin /mnt
# lsmod
Module                  Size  Used by
st                     29272   0  (autoclean) (unused)
nfs                    46836   0  (autoclean)
lockd                  36988   0  (autoclean) [nfs]
sunrpc                 62812   0  (autoclean) [nfs lockd]
ipchains               33624   6 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17200   0  (unused)
loop                    8472   3 
sr_mod                 11932   0  (unused)
cdrom                  27808   0  [sr_mod]
BusLogic               35768   7 
sd_mod                 10104  14 
scsi_mod               51740   4  [st sr_mod BusLogic sd_mod]
# ls /mnt
boot.b	initrd-2.4.18  map  message  vmlinuz-2.4.18
# umount /mnt
# lsmod
Module                  Size  Used by
st                     29272   0  (autoclean) (unused)
nfs                    46836   0  (autoclean)
lockd                  36988   0  (autoclean) [nfs]
sunrpc                 62812   0  (autoclean) [nfs lockd]
ipchains               33624   6 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17200   0  (unused)
loop                    8472   0 
sr_mod                 11932   0  (unused)
cdrom                  27808   0  [sr_mod]
BusLogic               35768   7 
sd_mod                 10104  14 
scsi_mod               51740   4  [st sr_mod BusLogic sd_mod]
# rmmod loop
# lsmod
Module                  Size  Used by
st                     29272   0  (autoclean) (unused)
nfs                    46836   0  (autoclean)
lockd                  36988   0  (autoclean) [nfs]
sunrpc                 62812   0  (autoclean) [nfs lockd]
ipchains               33624   6 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17200   0  (unused)
sr_mod                 11932   0  (unused)
cdrom                  27808   0  [sr_mod]
BusLogic               35768   7 
sd_mod                 10104  14 
scsi_mod               51740   4  [st sr_mod BusLogic sd_mod]
# mount -o loop raw.bin /mnt
# lsmod
Module                  Size  Used by
loop                    8568   3  (autoclean)
st                     29272   0  (autoclean) (unused)
nfs                    46836   0  (autoclean)
lockd                  36988   0  (autoclean) [nfs]
sunrpc                 62812   0  (autoclean) [nfs lockd]
ipchains               33624   6 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17200   0  (unused)
sr_mod                 11932   0  (unused)
cdrom                  27808   0  [sr_mod]
BusLogic               35768   7 
sd_mod                 10104  14 
scsi_mod               51740   4  [st sr_mod BusLogic sd_mod]
# umount /mnt
# lsmod
Module                  Size  Used by
loop                    8568   0  (autoclean)
st                     29272   0  (autoclean) (unused)
nfs                    46836   0  (autoclean)
lockd                  36988   0  (autoclean) [nfs]
sunrpc                 62812   0  (autoclean) [nfs lockd]
ipchains               33624   6 
ipx                    18724   0  (unused)
3c59x                  27968   1  (autoclean)
nls_cp437               4472   4  (autoclean)
isofs                  17200   0  (unused)
sr_mod                 11932   0  (unused)
cdrom                  27808   0  [sr_mod]
BusLogic               35768   7 
sd_mod                 10104  14 
scsi_mod               51740   4  [st sr_mod BusLogic sd_mod]
# rmmod loop
# exit
Script done on Wed Jul 24 15:15:49 2002

 
Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

