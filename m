Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbTCYQKu>; Tue, 25 Mar 2003 11:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbTCYQKu>; Tue, 25 Mar 2003 11:10:50 -0500
Received: from CPE-144-132-194-153.nsw.bigpond.net.au ([144.132.194.153]:23937
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S262708AbTCYQKt>; Tue, 25 Mar 2003 11:10:49 -0500
Date: Wed, 26 Mar 2003 00:13:58 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Cc: pleb@cse.unsw.edu.au
Subject: [Patch] [arm] support older plebs
Message-ID: <20030325161358.GA30538@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


This patch has been in my patch directory for a while.

The PLEB is a SA-1100-based ARM computer developed at CSE at the
University of New South Wales.  I have discovered some of the earlier
models would not set register 1 properly, which was required for Linux
to boot.  This was inside their (very old) kernel tree but which they 
never submitted for inclusion (?)  It is a Photon1 with catapult
bootloader combination.


	- G.
	
-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="arm-pleb.patch"

diff -urNp -X exclude linux-2.4.19-pleb.orig/arch/arm/kernel/head-armv.S linux-2.4.19-pleb/arch/arm/kernel/head-armv.S
--- linux-2.4.19-pleb.orig/arch/arm/kernel/head-armv.S	2002-10-29 18:57:10.000000000 +0800
+++ linux-2.4.19-pleb/arch/arm/kernel/head-armv.S	2002-10-29 19:18:42.000000000 +0800
@@ -130,6 +130,9 @@ __entry:
  */
 		mov	r1, #MACH_TYPE_L7200
 #endif
+#if defined(CONFIG_SA1100_PLEB)
+		mov	r1, #MACH_TYPE_PLEB
+#endif
 
 		mov	r0, #F_BIT | I_BIT | MODE_SVC	@ make sure svc mode
 		msr	cpsr_c, r0			@ and all irqs disabled

--OXfL5xGRrasGEqWY--
