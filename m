Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRG1QDn>; Sat, 28 Jul 2001 12:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbRG1QDd>; Sat, 28 Jul 2001 12:03:33 -0400
Received: from femail41.sdc1.sfba.home.com ([24.254.60.35]:54497 "EHLO
	femail41.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S266884AbRG1QDW>; Sat, 28 Jul 2001 12:03:22 -0400
Message-ID: <3B62E1C6.2F4BFBA1@didntduck.org>
Date: Sat, 28 Jul 2001 12:01:10 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix math emulation
Content-Type: multipart/mixed;
 boundary="------------7B35CE14E51319C736651582"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------7B35CE14E51319C736651582
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

There was an optimization done in 2.4.6 which broke the call to the math
emulation code.  With ret_from_exception no longer pushed onto the
stack, its placeholder in the math emu struct needs to be removed.

-- 

						Brian Gerst
--------------7B35CE14E51319C736651582
Content-Type: text/plain; charset=us-ascii;
 name="mathemu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mathemu.diff"

diff -urN linux-2.4.7/include/asm-i386/math_emu.h linux/include/asm-i386/math_emu.h
--- linux-2.4.7/include/asm-i386/math_emu.h	Thu Jun 22 00:21:37 2000
+++ linux/include/asm-i386/math_emu.h	Sat Jul 28 11:28:40 2001
@@ -12,7 +12,6 @@
    */
 struct info {
 	long ___orig_eip;
-	long ___ret_from_system_call;
 	long ___ebx;
 	long ___ecx;
 	long ___edx;

--------------7B35CE14E51319C736651582--

