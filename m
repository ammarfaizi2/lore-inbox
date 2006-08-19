Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWHSIlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWHSIlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 04:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWHSIlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 04:41:55 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:51099 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751302AbWHSIlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 04:41:55 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: 2.4.34-pre1 USB mass-storage burped...
Date: Sat, 19 Aug 2006 18:41:50 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <9aide2d3ano7v3853kgfhhpbgarmns4t2f@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Running NFS testing (continuous kernel build + untar, diff against previous) 
over two NFS mounts.  Also running continuous kernel build to USB HDD:

No datestamp on rebuild start, sorry -- about 6 or 7 builds from end of 
log roughly matches logged events' datestamp, only 1 of 25 builds has 
the error:

/bin/sh: line 1: 29947 Bus error               /mnt/hd/linux-2.4.33/scripts/mkdep -D__KERNEL__ -I/mnt/hd/linux-2.4.33/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=athlon -nostdinc -iwithprefix include -- amdtp.c amdtp.h cmp.c cmp.h csr.c csr.h dma.c dma.h dv1394-private.h dv1394.c dv1394.h eth1394.c eth1394.h highlevel.c highlevel.h hosts.c hosts.h ieee1394-ioctl.h
ieee1394.h ieee1394_core.c ieee1394_core.h ieee1394_hotplug.h ieee1394_transactions.c ieee1394_transactions.h ieee1394_types.h iso.c iso.h nodemgr.c nodemgr.h ohci1394.c ohci1394.h pcilynx.c pcilynx.h raw1394-private.h raw1394.c raw1394.h sbp2.c
sbp2.h video1394.c video1394.h >.depend
make[4]: *** [fastdep] Error 135
make[3]: *** [_sfdep_ieee1394] Error 2
make[2]: *** [fastdep] Error 2
make[1]: *** [_sfdep_drivers] Error 2
make: *** [dep-files] Error 2

/var/log/messages:
Aug 19 14:04:26 sempro kernel: Initializing USB Mass Storage driver...
Aug 19 14:04:26 sempro kernel: usb.c: registered new driver usb-storage
Aug 19 14:04:26 sempro kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Aug 19 14:04:26 sempro kernel:  sdc: sdc1 sdc2 sdc3
Aug 19 14:04:26 sempro kernel: USB Mass Storage support registered.
Aug 19 14:09:34 sempro sshd[31910]: Accepted publickey for grant from 192.168.1.31 port 1940 ssh2
Aug 19 14:24:23 sempro -- MARK --
Aug 19 14:44:23 sempro -- MARK --
Aug 19 15:04:23 sempro -- MARK --
Aug 19 15:24:23 sempro -- MARK --
Aug 19 15:44:23 sempro -- MARK --
Aug 19 16:04:23 sempro -- MARK --
Aug 19 16:24:23 sempro -- MARK --
Aug 19 16:44:23 sempro -- MARK --
Aug 19 17:04:23 sempro -- MARK --
Aug 19 17:08:54 sempro kernel: usb.c: USB disconnect on device 00:10.4-5 address 4
Aug 19 17:08:54 sempro kernel: hub.c: new USB device 00:10.4-5, assigned address 5
Aug 19 17:08:54 sempro kernel: Product: USB TO IDE
Aug 19 17:24:23 sempro -- MARK --

/var/log/syslog:
Aug 19 17:08:54 sempro kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 70000
Aug 19 17:08:54 sempro kernel:  I/O error: dev 08:22, sector 238536
Aug 19 17:08:54 sempro kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 70000
Aug 19 17:08:54 sempro kernel:  I/O error: dev 08:22, sector 345840
Aug 19 17:08:54 sempro kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 70000
Aug 19 17:08:54 sempro kernel:  I/O error: dev 08:22, sector 345848
Aug 19 17:08:54 sempro kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 70000
Aug 19 17:08:54 sempro kernel:  I/O error: dev 08:22, sector 345840
Aug 19 17:08:54 sempro kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 70000
Aug 19 17:08:54 sempro kernel:  I/O error: dev 08:22, sector 345840

I'll leave the test running overnight, unless I smell smoke ;)

Test boxen dmesg + comment stripped config:
  <http://bugsplatter.mine.nu/test/boxen/peetoo/2.4.xx/> NFS server
  <http://bugsplatter.mine.nu/test/boxen/sempro/2.4.xx/> NFS client and build host

Both running 2.4.34-pre1 for this test.  

Recent kernel rebuild testing over NFS produced no errors:
grant@sempro:~$ grep Error /home/public/kbuildtest-2.4.log-2.4.33-final
grant@sempro:~$ grep Error /home/public/kbuildtest-2.4.log-2.6.17.8-tcp
grant@sempro:~$ grep Error /home/public/kbuildtest-2.4.log-2.6.17.8-udp
grant@sempro:~$ grep Error /home/public/kbuildtest-2.4.log  <<== current test

Grant.
