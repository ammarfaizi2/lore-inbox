Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSENI1G>; Tue, 14 May 2002 04:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315446AbSENI1F>; Tue, 14 May 2002 04:27:05 -0400
Received: from cgate-1.netactive.net ([196.22.160.77]:55732 "EHLO
	cgate-1.netactive.net") by vger.kernel.org with ESMTP
	id <S315388AbSENI1E>; Tue, 14 May 2002 04:27:04 -0400
Message-ID: <297DCD5CCA4AD411A246009027F646B30276489D@NETMAIL>
From: Wickus Botha <Wickus@na.co.za>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: hd.c not compiling.
Date: Tue, 14 May 2002 10:24:51 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

I'm busy testing the new development kernel 2.5.15. Each time it gets to
compiling the ide stuff it fails. 

make[3]: Entering directory `/usr/src/linux-2.5.15/drivers/ide'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=hd  -c
-o hd.o hd.c
hd.c: In function `hd_out':
hd.c:282: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c:282: (Each undeclared identifier is reported only once
hd.c:282: for each function it appears in.)
hd.c: In function `unexpected_hd_interrupt':
hd.c:363: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `read_intr':
hd.c:432: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `write_intr':
hd.c:470: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `hd_request':
hd.c:553: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `hd_init':
hd.c:830: `DEVICE_REQUEST' undeclared (first use in this function)
hd.c: At top level:
hd.c:615: warning: `do_hd_request' defined but not used
make[3]: *** [hd.o] Error 1

I've noticed /usr/src/linux/include/linux/blk.h doesn't have the following 2
entries anymore

#define TIMEOUT_VALUE (6*HZ)
#define DEVICE_REQUEST do_hd_request

I added them to the blk.h file and its compiling fine now

#elif (MAJOR_NR == HD_MAJOR)

/* Hard disk:  timeout is 6 seconds. */
#define DEVICE_NAME "hard disk"
#define DEVICE_INTR do_hd
#define TIMEOUT_VALUE (6*HZ)
#define DEVICE_REQUEST do_hd_request
#define DEVICE_NR(device) (minor(device)>>6)





---------------------------------------------------------------------------
VIRUS FREE EMAIL: This message has been screened and determined free
of all known viruses by NetActive Mail Control. For more information on 
Mail Scanning, Internet Access, Virtual Private Networks (VPN), Managed 
Firewall security and other IT Services, please visit us at 
http://www.netactive.co.za
