Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSBHNKA>; Fri, 8 Feb 2002 08:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291563AbSBHNJu>; Fri, 8 Feb 2002 08:09:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:21229 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291569AbSBHNJf>; Fri, 8 Feb 2002 08:09:35 -0500
Date: Fri, 8 Feb 2002 14:06:29 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Problem with both CONFIG_FB_SIS_300 and CONFIG_FB_SIS_315
Message-ID: <Pine.NEB.4.44.0202081352410.5795-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

with the following in the .config:

CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y

gcc gices the following warnings when compiling sis_main.h:

<--  snip  -->

make[4]: Entering directory
`/home/bunk/linux/kernel-2.4/linux/drivers/video/sis'
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-DKBUILD_BASENAME=sis_main  -c -o sis_main.o sis_main.c
In file included from sis_main.c:46:
sis_main.h:33: warning: `HW_CURSOR_AREA_SIZE' redefined
sis_main.h:27: warning: this is the location of the previous definition
sis_main.h:92: warning: `IND_SIS_CRT2_WRITE_ENABLE' redefined
sis_main.h:89: warning: this is the location of the previous definition

<--  snip  -->

gcc is pretty right to give warnings because the affected lines are:

<--  snip  -->

...
/* For 300 series */
#ifdef CONFIG_FB_SIS_300
#define TURBO_QUEUE_AREA_SIZE     0x80000       /* 512K */
#define HW_CURSOR_AREA_SIZE       0x1000        /* 4K */
#endif

/* For 315 series */
#ifdef CONFIG_FB_SIS_315
#define COMMAND_QUEUE_AREA_SIZE   0x80000       /* 512K */
#define HW_CURSOR_AREA_SIZE       0x4000        /* 16K */
#define COMMAND_QUEUE_THRESHOLD   0x1F
#endif
...
// Eden Chen
#ifdef CONFIG_FB_SIS_300
#define IND_SIS_CRT2_WRITE_ENABLE 0x24
#endif
#ifdef CONFIG_FB_SIS_315
#define IND_SIS_CRT2_WRITE_ENABLE 0x2F
#endif
// ~Eden Chen
...

<--  snip  -->


I doubt that with both CONFIG_FB_SIS_300 and CONFIG_FB_SIS_315 enabled a
card that needs CONFIG_FB_SIS_300 would work.

I have no knowledge of this driver but there seem to be two possibilities
to resolve this:

1. Change the code to allow both CONFIG_FB_SIS_300 and CONFIG_FB_SIS_315
   to be enabled at the same time.
2. Change Config.in to allow only one of the two options in one kernel.


cu
Adrian


