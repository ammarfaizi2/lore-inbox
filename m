Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSKJVEa>; Sun, 10 Nov 2002 16:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265178AbSKJVEa>; Sun, 10 Nov 2002 16:04:30 -0500
Received: from pop.gmx.de ([213.165.64.20]:59597 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265177AbSKJVEa> convert rfc822-to-8bit;
	Sun, 10 Nov 2002 16:04:30 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Mehrmann <daniel.mehrmann@gmx.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] [2.4.20-rc1] compiler fix drivers/ide/pdc202xx.c
Date: Sun, 10 Nov 2002 22:11:10 +0100
User-Agent: KMail/1.4.3
Cc: lkm <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211102211.10277.daniel.mehrmann@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

i fix a compiler warning from pdc202xx.c.
The "default:" value in the switch was empty. Gcc don`t like
this. We don`t need this one. 

error:
gcc -D__KERNEL__ -I/usr/src/bk/work-2.4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 
-march=athlon-tbird    -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=pdc202xx  -c -o pdc202xx.o pdc202xx.c
pdc202xx.c: In function `pdc202xx_new_tune_chipset':
pdc202xx.c:636: warning: deprecated use of label at end of compound 
statement

patch:
daniel@deepblue:/usr/src/bk/linux-2.4/drivers/ide$ diff -Pu 
pdc202xx.c pdc202xx.c.fine
--- pdc202xx.c  2002-11-03 04:55:30.000000000 +0100
+++ pdc202xx.c.fine     2002-11-10 21:55:43.000000000 +0100
@@ -632,11 +632,10 @@
                                        OUT_BYTE((0x13 + adj), 
indexreg);
                                        OUT_BYTE(0xac, datareg);
                                        break;
-                               default:
                        }
                }
        }
       return err;
 }

greetings,
Daniel


