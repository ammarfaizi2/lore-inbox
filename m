Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135821AbREBTvZ>; Wed, 2 May 2001 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135796AbREBTvO>; Wed, 2 May 2001 15:51:14 -0400
Received: from pc-62-30-139-55-nm.blueyonder.co.uk ([62.30.139.55]:24068 "EHLO
	gate.leinster") by vger.kernel.org with ESMTP id <S135792AbREBTvG>;
	Wed, 2 May 2001 15:51:06 -0400
Date: Wed, 2 May 2001 20:50:58 +0100 (BST)
From: Shaw Carruthers <shaw@shawc.freeserve.co.uk>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.2.19 toshiba.c won't build(PATCH)
Message-ID: <Pine.LNX.4.05.10105022010350.18895-100000@leaf.leinster>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Correcting the obvious error

#include <linux/toshiba.h>

still leaves:

toshiba.c:93: parse error before string constant
toshiba.c:93: warning: type defaults to `int' in declaration of `MODULE_PARM'
toshiba.c:93: warning: function declaration isn't a prototype
toshiba.c:93: warning: data definition has no type or storage class
toshiba.c: In function `tosh_open':
toshiba.c:286: `MOD_INC_USE_COUNT' undeclared (first use in this function)
toshiba.c:286: (Each undeclared identifier is reported only once
toshiba.c:286: for each function it appears in.)
toshiba.c: In function `tosh_release':
toshiba.c:294: `MOD_DEC_USE_COUNT' undeclared (first use in this function)
make[3]: *** [toshiba.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_char] Error 2
make: *** [_dir_drivers] Error 2


So needs if not built as a module:

--- /usr/src/linux-2.2.19/drivers/char/toshiba.c	Mon Apr 16 23:25:05 2001
+++ linux/drivers/char/toshiba.c	Wed May  2 20:39:54 2001
@@ -60,10 +60,8 @@
 #define TOSH_VERSION "1.9 22/3/2001"
 #define TOSH_DEBUG 0
 
-#ifdef MODULE
 #include<linux/module.h>
 #include<linux/version.h>
-#endif
 #include<linux/kernel.h>
 #include<linux/sched.h>
 #include<linux/types.h>
@@ -78,7 +76,7 @@
 #include<linux/proc_fs.h>
 #endif
 
-#include"toshiba.h"
+#include<linux/toshiba.h>
 
 #define TOSH_MINOR_DEV 181
 



-- 
Shaw Carruthers - shaw@shawc.freeserve.co.uk
London SW14 7JW UK
This is not a sig( with homage to Magritte).
  


