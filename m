Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbRF0V1y>; Wed, 27 Jun 2001 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbRF0V1o>; Wed, 27 Jun 2001 17:27:44 -0400
Received: from mailhost.terra.es ([195.235.113.151]:46630 "EHLO
	tsmtppp1.teleline.es") by vger.kernel.org with ESMTP
	id <S265413AbRF0V12>; Wed, 27 Jun 2001 17:27:28 -0400
Message-ID: <3B3A525E.B321BC5@reymad.com>
Date: Wed, 27 Jun 2001 23:38:38 +0200
From: Gonzalo Aguilar <gad@reymad.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sched.h problem in 2.4.x and new gcc compilers
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, there is a little problem with some headers and
new glibs and compilers. Kernel fails to compile and worst
is the extern declaration in sched.h

Don't if this is a gcc or glib problem (surely gcc) but doesn't
works...

The patch is only redeclaring xtime in extern:

*************************** cut here ******************************
--- include/linux/sched.h	Wed Jun 27 23:19:04 2001
+++ include/linux/sched.h~	Thu Jun 21 12:36:26 2001
@@ -537,7 +537,7 @@
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern volatile struct timeval xtime __attribute__ ((aligned (16)));
+extern struct timeval xtime;
 extern void do_timer(struct pt_regs *);
 
 extern unsigned int * prof_buffer;
***************************** cut here ******************************

I made it with the copy that joe editor does, you know the change is:

-extern volatile struct timeval xtime __attribute__ ((aligned (16)));
+extern struct timeval xtime;

There are other problems with multiline string literals all over the
code
but this is only a warning... One is this...

/mnt/hd2/src/linux-2.4.5/include/asm/checksum.h:72:30: warning:
multi-line string literals are deprecated

Hope it helps. It's a ridiculous patch but now it's fixed.

Thanks
-- 
Gonzalo Aguilar. Madrid, España (Spain) |
Reymad Studios | gad@reymad.com		|
Privado        | eshero@airtel.net	|
----------------------------------------+
