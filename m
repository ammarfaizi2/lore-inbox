Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbSJGUlu>; Mon, 7 Oct 2002 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263176AbSJGUlu>; Mon, 7 Oct 2002 16:41:50 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:18094 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263172AbSJGUlr>; Mon, 7 Oct 2002 16:41:47 -0400
To: torvalds@transmeta.com
Subject: [PATCH] Make it possible to compile in the Bluetooth subsystem
Cc: linux-kernel@vger.kernel.org, maxk@qualcomm.com, marcel@holtmann.org
Message-Id: <E17yelj-0005CD-00@pegasus>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 07 Oct 2002 22:46:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.709, 2002-10-07 22:08:56+02:00, marcel@holtmann.org
  Make it possible to compile in the Bluetooth subsystem


 af_bluetooth.c |    8 +++-----
 rfcomm/tty.c   |    8 +-------
 2 files changed, 4 insertions(+), 12 deletions(-)


diff -Nru a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	Mon Oct  7 22:16:14 2002
+++ b/net/bluetooth/af_bluetooth.c	Mon Oct  7 22:16:14 2002
@@ -320,7 +320,7 @@
 	PF_BLUETOOTH, bluez_sock_create
 };
 
-static int __init bluez_init(void)
+int __init bluez_init(void)
 {
 	BT_INFO("BlueZ Core ver %s Copyright (C) 2000,2001 Qualcomm Inc",
 		 VERSION);
@@ -337,7 +337,7 @@
 		BT_ERR("BlueZ socket cache creation failed");
 		return -ENOMEM;
 	}
-	
+
 	sock_register(&bluez_sock_family_ops);
 
 	hci_core_init();
@@ -345,7 +345,7 @@
 	return 0;
 }
 
-static void __exit bluez_cleanup(void)
+void __exit bluez_cleanup(void)
 {
 	hci_sock_cleanup();
 	hci_core_cleanup();
@@ -356,11 +356,9 @@
 	remove_proc_entry("bluetooth", NULL);
 }
 
-#ifdef MODULE
 module_init(bluez_init);
 module_exit(bluez_cleanup);
 
 MODULE_AUTHOR("Maxim Krasnyansky <maxk@qualcomm.com>");
 MODULE_DESCRIPTION("BlueZ Core ver " VERSION);
 MODULE_LICENSE("GPL");
-#endif
diff -Nru a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c	Mon Oct  7 22:16:14 2002
+++ b/net/bluetooth/rfcomm/tty.c	Mon Oct  7 22:16:14 2002
@@ -501,12 +501,6 @@
 #endif
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
-#define __minor MINOR
-#else
-#define __minor minor
-#endif
-
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -514,7 +508,7 @@
 	struct rfcomm_dlc *dlc;
 	int err, id;
 
-        id = __minor(tty->device) - tty->driver.minor_start;
+        id = minor(tty->device) - tty->driver.minor_start;
 
 	BT_DBG("tty %p id %d", tty, id);
 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch19808
M'XL(`([KH3T``\U5;6O;,!#^'/V*@WYI*;9/KW8\4KJV8QO;6.GHMT%0;*4V
MB>U@*VD[_.,G.UO2CBS;2@>U#2?)IT>G>YZ3#N"Z,74\*'2=F#DY@'=58^-!
M5LUMH<O2K^H;-WA556XPR*K"!#]_!9/<SHQ9F#J8S)?FF\=\29SOI;9)!BM3
M-_&`^GPS8N\7)AY<O7E[_?'U%2&C$9QGNKPQ7XR%T8C8JE[I>=J<:IO-J]*W
MM2Z;PECM)U71;EQ;ALC<*VG(4:J6*A1AF]"44BVH29&)2(DMVL*4-\M\/QQ%
M#&G$&*I641PR<@'4#W$(R`**`8;`6(Q1+-4QN@;".EFG#Y,$QPP\)&?PO/LX
M)PE\TC,#N85%U33Y9&[<$N"P%KEKYB78S,"9(\`ZCC)HEI/FOK&F(!]`4>XV
M<[G-,_'^\2$$-9(36'0,[MY1:6S/?[]\H*?C3<=/MIN,N.2BI>&0LY:K%#6C
MB@Y1:3.<[$KGGV$[TAB5',-62,6%B[+0=[/35>X4Z1^656F.?D&IIR[@(K#V
M?HLA$;D0K'4<R*B-PA13)JD14ZV5G/Y%:+M`76!"2=Y*B:'LI?[[.9WVGS]P
M\L3`43"DK@RXB(9]&8@'1<!CH6+)]Q4!!2]\646PYN`S>/5M_SE17^ZAXPDE
M<B%1@'*&AD#)^[6!'T^>P@B*O*SJ0X?OG:1FE2?F"#Q8=^O<G91^[S!NK*[M
MJQUZ>2S_3C'_M2!)[;SWZ7%W.0H'RKEJ'6<8]N)1C\0C>8SA/O%P\.3+$L_Z
M9-DKGL>Y>(I\...=;M8F+RV,QWGIHNUOU;YYN*KR],AY"NP]>_.UZT?K?F<Z
M'S?5W&VF)G.CR^5B,UL.G=L%5\J9S;6<9":9-<MBQ"91)(64Y#L%=!MS$P@`
!````
`
end
