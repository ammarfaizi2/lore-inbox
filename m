Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268268AbRGWPmo>; Mon, 23 Jul 2001 11:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268270AbRGWPme>; Mon, 23 Jul 2001 11:42:34 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:52801 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268268AbRGWPm0>; Mon, 23 Jul 2001 11:42:26 -0400
Date: Mon, 23 Jul 2001 15:42:17 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: nfs weirdness
Message-ID: <20010723154217.F19492@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux grobbebol 2.4.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


yesterday cleanly installed a system that is known to export three dirs
without problems with NFS on 2.2.16.

The system is at 2.4.4 (SuSE) and while the same exports file is used, I
get a problem that is identified with exportfs.

using knfsd, exports looks like :

/cdrom          192.168.1.2(ro)
/windows        192.168.1.2(ro)
/udf            192.168.1.2(ro)

exportfs -av with :
 
/dev/hdd on /udf type udf; /dev/hdc on /media/cdrom type iso9660 and
/windows is NOT mounted.

exporting 192.168.1.2:/media/cdrom
exporting 192.168.1.2:/windows
exporting 192.168.1.2:/udf
reexporting 192.168.1.2:/media/cdrom to kernel
reexporting 192.168.1.2:/windows to kernel
reexporting 192.168.1.2:/udf to kernel

looks good. remote mounts als shows no error :

toshiba:/cdrom          575506    575506         0 100% /tcdrom
toshiba:/windows        976216    895820     30804  97% /windows
toshiba:/udf            545984    530948     15036  98% /udf

except that /windows was NOT mounted so should be empty. it in fact
reflects the fs size, free etc of the root FS of toshiba. ls /windows on
192.168.1.2 shows no files.

now, if I mount /windows on toshiba, there are files. all ok, however,
exporting it causes :

reexporting 192.168.1.2:/windows to kernel
192.168.1.2:/windows: Invalid argument

(/dev/hda1 on /windows type vfat)

and mounting via nfs :

mount: toshiba:/windows failed, reason given by server: Permission
denied

/v/l/m shows :

rpc.mountd: authenticated mount request from 192.168.1.2:670 for /windows (/windows)
rpc.mountd: getfh failed: Operation not permitted

I'm lost, completely now. it worked with the old kernel/setup, now it
doesn't.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
