Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSBGGAC>; Thu, 7 Feb 2002 01:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSBGF7w>; Thu, 7 Feb 2002 00:59:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22020 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282967AbSBGF7k>; Thu, 7 Feb 2002 00:59:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: autofs on 64-bit systems
Date: 6 Feb 2002 21:59:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3t53o$tl4$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to change the API for autofs on 64-bit systems, *except*
Alpha, MIPS64 and SPARC64.  As far as I count, this means IA-64,
S/390x and x86-64.

The problem is that current setup doesn't work well with the emulation
layer; currently this is special-cased for MIPS64 and Sparc64, but the
other 64-bit architectures didn't follow suit.

How much pain or lack thereof will this cause?  In particular, IA-64
seems to be one which just may want to pass on this, otherwise I'll
expect to send this patch to Linus and Marcelo as well as make an
autofs 3.1.8 with this patch in it:

--- include/linux/auto_fs.h~	Mon Jan 14 13:33:50 2002
+++ include/linux/auto_fs.h	Wed Feb  6 21:57:16 2002
@@ -45,7 +45,7 @@
  * If so, 32-bit user-space code should be backwards compatible.
  */
 
-#if defined(__sparc__) || defined(__mips__)
+#ifndef __alpha__
 typedef unsigned int autofs_wqt_t;
 #else
 typedef unsigned long autofs_wqt_t;
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
