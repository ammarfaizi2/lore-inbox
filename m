Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313248AbSDDQdw>; Thu, 4 Apr 2002 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313250AbSDDQdm>; Thu, 4 Apr 2002 11:33:42 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:62704 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313248AbSDDQd0>;
	Thu, 4 Apr 2002 11:33:26 -0500
Date: Thu, 4 Apr 2002 18:33:24 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204041633.SAA10837@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: 2.5.8-pre1 binutils-related regression on x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.8-pre1 includes the following patch:

diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Wed Apr  3 17:11:13 2002
+++ b/arch/i386/boot/setup.S	Wed Apr  3 17:11:13 2002
@@ -544,7 +544,7 @@
 	cmpw	$0, %cs:realmode_swtch
 	jz	rmodeswtch_normal
 
-	lcall	*%cs:realmode_swtch
+	lcall	%cs:realmode_swtch
 
 	jmp	rmodeswtch_end
 
The "*" was put there early in the 2.5 series, to allow non-
antique binutils to assemble the code cleanly without warnings.
This patch reintroduces those warnings. Uncool.

/Mikael
