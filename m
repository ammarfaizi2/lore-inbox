Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153926AbPGIKoB>; Fri, 9 Jul 1999 06:44:01 -0400
Received: by vger.rutgers.edu id <S153931AbPGIKnR>; Fri, 9 Jul 1999 06:43:17 -0400
Received: from [210.140.67.114] ([210.140.67.114]:1558 "EHLO soto.zerosoft.co.jp") by vger.rutgers.edu with ESMTP id <S153918AbPGIKlM>; Fri, 9 Jul 1999 06:41:12 -0400
Date: Fri, 09 Jul 1999 19:41:24 +0900
From: Masahiro Adegawa <adegawa@zerosoft.co.jp>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] SGI's kdb version v0.4
Message-Id: <3785D1D4130.9F7FADEGAWA@mail.zerosoft.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver 1.25.04
Sender: owner-linux-kernel@vger.rutgers.edu

Hello,

1. simple numeric address for `bp'
2. `rd c' and 'rd d'

diff -u linux-2.2.9-ik/arch/i386/kdb/kdb_bp.c linux/arch/i386/kdb/kdb_bp.c
--- linux-2.2.9-ik/arch/i386/kdb/kdb_bp.c       Mon Jun 21 15:28:32 1999
+++ linux/arch/i386/kdb/kdb_bp.c        Thu Jul  8 18:18:42 1999
@@ -348,7 +348,7 @@
 #endif

        nextarg = 1;
-       diag = kdbgetaddrarg(argc, argv, &nextarg, &addr, &offset, &symname, regs);
+       diag = kdbgetaddrarg(argc, argv, &nextarg, &addr, &offset, NULL, regs);
        if (diag)
                return diag;

diff -u linux-2.2.9-ik/arch/i386/kdb/kdbsupport.c linux/arch/i386/kdb/kdbsupport.c
--- linux-2.2.9-ik/arch/i386/kdb/kdbsupport.c   Mon Jun 21 15:28:32 1999
+++ linux/arch/i386/kdb/kdbsupport.c    Fri Jul  9 11:26:02 1999
@@ -730,8 +730,8 @@
                           dr[0], dr[1], dr[2], dr[3]);
                kdb_printf("dr6 = 0x%8.8x  dr7 = 0x%8.8x\n",
                           dr[6], dr[7]);
+               return 0;
        }
-               break;
        case 'c':
        {
                unsigned long cr[5];
@@ -741,8 +741,8 @@
                }
                kdb_printf("cr0 = 0x%8.8x  cr1 = 0x%8.8x  cr2 = 0x%8.8x  cr3 = 0x%8.8x\ncr4 = 0x%8.8x\n",
                           cr[0], cr[1], cr[2], cr[3], cr[4]);
+               return 0;
        }
-               break;
        case 'm':
                break;
        case 'r':

/*********************************************************/
(3.only Japanese 86/106 keyboards)

--- linux-2.2.9-kdb/arch/i386/kdb/kdb_io.c.org  Sat Jun  5 23:46:12 1999
+++ linux-2.2.9-kdb/arch/i386/kdb/kdb_io.c      Sun Jun  6 10:46:16 1999
@@ -183,6 +183,12 @@
                if (scancode == 0xe0) {
                        continue;
                }
+
+               if (scancode == 0x73) {         /* see driver/char/pc_keyb.c */
+                       scancode = 0x59;        /* for Japanese 86/106 keyboards */
+               } else if (scancode == 0x7d) {
+                       scancode = 0x7c;
+               }

                if (!shift_lock && !shift_key) {
                        keychar = plain_map[scancode];

 -Masahiro Adegawa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
