Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbTADNa6>; Sat, 4 Jan 2003 08:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbTADNa6>; Sat, 4 Jan 2003 08:30:58 -0500
Received: from isp247n.hispeed.ch ([62.2.95.247]:2478 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id <S266898AbTADNa5>;
	Sat, 4 Jan 2003 08:30:57 -0500
Message-ID: <005f01c2b3f6$b66ba5b0$0400a8c0@gwaihir>
From: "Simon Scheiwiller" <simon@hornweb.ch>
To: <linux-kernel@vger.kernel.org>
Subject: kobject.h makes lilo compile break
Date: Sat, 4 Jan 2003 14:39:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I'm compiling lilo on a machine with kernel 2.5.54, I get the following
error:


gcc -c -O2 -Wall -g `( if [ -r $ROOT/etc/lilo.defines ]; then cat
$ROOT/etc/lilo.defines; else
echo -DBDATA -DBUILTIN -DDSECS=3 -DIGNORECASE -DLBA32 -DLVM -DEVMS -DM386 -D
ONE_SHOT -DPASS160 -DREISERFS -DREWRITE_TABLE -DSOLO_CHAIN -DVARSETUP -DVERS
ION -DUNIFY; fi ) | sed 's/-D/-DLFC_/g'` `[ -r /usr/include/asm/boot.h ] &&
echo -DHAS_BOOT_H` `cat mylilo.h` lilo.c
In file included from /usr/include/linux/kobject.h:10,
                 from /usr/include/linux/device.h:28,
                 from /usr/include/linux/genhd.h:15,
                 from common.h:20,
                 from lilo.c:25:
/usr/include/linux/list.h:323:2: warning: #warning "don't include kernel
headers in userspace"
In file included from /usr/include/linux/device.h:28,
                 from /usr/include/linux/genhd.h:15,
                 from common.h:20,
                 from lilo.c:25:
/usr/include/linux/kobject.h:20: field `entry` has incomplete type
/usr/include/linux/kobject.h:24: confused by earlier errors, bailing out
make: *** [lilo.o] Error 1
rm temp2.img


As far as I got it, it's the kobject.h which causes the error as it includes
list.h which can't be included in userspace, but in the end the genhd.h
should work so can compile lilo.

Can someone help me how to solve that?

TIA
Cheers, Simon

