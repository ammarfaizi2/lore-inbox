Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270331AbRHHFWI>; Wed, 8 Aug 2001 01:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270329AbRHHFV6>; Wed, 8 Aug 2001 01:21:58 -0400
Received: from smtp-out.hamburg.pop.de ([195.222.210.86]:24330 "EHLO
	smtp-out.hamburg.pop.de") by vger.kernel.org with ESMTP
	id <S270331AbRHHFVk>; Wed, 8 Aug 2001 01:21:40 -0400
Date: Wed, 8 Aug 2001 07:21:47 +0200
From: Michael Reincke <reincke.m@stn-atlas.de>
To: linux-kernel@vger.kernel.org
Subject: problem: devfs scsi tape permissions
Message-Id: <20010808072147.00943ce9.reincke.m@stn-atlas.de>
Organization: STN ATLAS Elektronik GmbH
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've some trouble with devfs and the permission on my SCSI-tape drive:

after a reboot the permissions on /dev/scsi/host0/bus0/target4/lun0 are as
follows
drwxr-xr-x    1 root     root            0 Jan  1  1970 lun0/

A request on the tape-drive as normal user gives a permission denied and
the permissions on /dev/scsi/host0/bus0/target4/lun0  set to 
drw-------    1 root     root            0 Jan  1  1970 lun0/

all nodes in lun0 are having the right permissions:
ls -l /dev/scsi/host0/bus0/target4/lun0/

total 0
crw-rw----    1 root     tape       9,   0 Jan  1  1970 mt
crw-rw----    1 root     tape       9,  96 Jan  1  1970 mta
crw-rw----    1 root     tape       9, 224 Jan  1  1970 mtan
crw-rw----    1 root     tape       9,  32 Jan  1  1970 mtl
crw-rw----    1 root     tape       9, 160 Jan  1  1970 mtln
crw-rw----    1 root     tape       9,  64 Jan  1  1970 mtm
crw-rw----    1 root     tape       9, 192 Jan  1  1970 mtmn
crw-rw----    1 root     tape       9, 128 Jan  1  1970 mtn

So to get the whole thing work i need on /dev/scsi/host0/bus0/target4/lun0
the following permissions:
drwxrwx---    1 root     tape            0 Jan  1  1970 lun0

How could i reach this??  I tried using CFUNCTION 

CREATE nst0 CFUNCTION GLOBAL chmod ${mntpnt}/scsi/host0/bus0/target4/lun0 770
CREATE nst0 CFUNCTION GLOBAL chown ${mntpnt}/scsi/host0/bus0/target4/lun0 0 26

but no work. Setiing the permissions by hand and activatinfg saving and restoring the state is also not working.


-- 
Michael Reincke, NUT Team 2 (Software Build Management)

STN ATLAS Elektronik GmbH, Bremen (Germany)
E-mail : reincke.m@stn-atlas.de |  mail: Sebaldsbrücker Heerstr 235    
phone  : +49-421-457-2302       |        28305 Bremen                  
fax    : +49-421-457-3913       |

