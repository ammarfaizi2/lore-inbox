Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317295AbSFLFCC>; Wed, 12 Jun 2002 01:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSFLFCB>; Wed, 12 Jun 2002 01:02:01 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:63480 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S317295AbSFLFCB>; Wed, 12 Jun 2002 01:02:01 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15622.54728.469214.307901@wombat.chubb.wattle.id.au>
Date: Wed, 12 Jun 2002 15:02:00 +1000
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(2.5.21)  The third argument to BLKGETSIZE64 is declared as u64 in
include/linux/fs.h

I think it should be uint64_t to allow glibc to copy and mangle the file into
its header tree. 


===== include/linux/fs.h 1.112 vs edited =====
--- 1.112/include/linux/fs.h    Wed Jun 12 10:16:52 2002
+++ edited/include/linux/fs.h   Wed Jun 12 14:30:36 2002
@@ -196,7 +196,7 @@
 /* A jump here: 108-111 have been used for various private purposes. */
 #define BLKBSZGET  _IOR(0x12,112,sizeof(int))
 #define BLKBSZSET  _IOW(0x12,113,sizeof(int))
-#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))        /* return device size in b
ytes (u64 *arg) */
+#define BLKGETSIZE64 _IOR(0x12,114,sizeof(uint64_t))   /* return device size in b
ytes (u64 *arg) */
 
 #define BMAP_IOCTL 1           /* obsolete - kept for compatibility */
 #define FIBMAP    _IO(0x00,1)  /* bmap access */
