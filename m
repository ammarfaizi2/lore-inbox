Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133054AbRDLHBt>; Thu, 12 Apr 2001 03:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133055AbRDLHBk>; Thu, 12 Apr 2001 03:01:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60321 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S133054AbRDLHB3>;
	Thu, 12 Apr 2001 03:01:29 -0400
Message-ID: <3AD552CA.B56AA740@mandrakesoft.com>
Date: Thu, 12 Apr 2001 03:01:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: George Bonser <george@gator.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.4.4-pre2 nbd compile error
In-Reply-To: <CHEKKPICCNOGICGMDODJCEHHCLAA.george@gator.com>
Content-Type: multipart/mixed;
 boundary="------------71B54C916EA0C6D1C628E25B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------71B54C916EA0C6D1C628E25B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

George Bonser wrote:
> 
> gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall -Wstrict-prototypes -O
> 2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary
> =2 -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/local/src/linux/include/linux/modversions.h   -c -o nbd.o nbd.c
> nbd.c: In function `nbd_send_req':
> nbd.c:160: `MSG_MORE' undeclared (first use in this function)
> nbd.c:160: (Each undeclared identifier is reported only once
> nbd.c:160: for each function it appears in.)

Some zerocopy patch leakage :(

> nbd.c: At top level:
> nbd.c:481: warning: static declaration for `nbd_init' follows non-static

See the attached patch....

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
--------------71B54C916EA0C6D1C628E25B
Content-Type: text/plain; charset=us-ascii;
 name="blk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk.patch"

Index: include/linux/blk.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/blk.h,v
retrieving revision 1.1.1.37
diff -u -r1.1.1.37 blk.h
--- include/linux/blk.h	2001/04/12 03:17:07	1.1.1.37
+++ include/linux/blk.h	2001/04/12 05:57:14
@@ -42,7 +42,6 @@
 extern int swimiop_init(void);
 extern int amiga_floppy_init(void);
 extern int atari_floppy_init(void);
-extern int nbd_init(void);
 extern int ez_init(void);
 extern int bpcd_init(void);
 extern int ps2esdi_init(void);

--------------71B54C916EA0C6D1C628E25B--

