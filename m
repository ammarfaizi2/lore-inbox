Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280804AbRK1WCt>; Wed, 28 Nov 2001 17:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280807AbRK1WCj>; Wed, 28 Nov 2001 17:02:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:56783 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S280804AbRK1WCa>;
	Wed, 28 Nov 2001 17:02:30 -0500
Date: Wed, 28 Nov 2001 22:58:42 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200111282158.WAA02746@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: 2.4.16 Compiler warning
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org, mblack@csihq.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001 16:19:35 +0100 (CET), Kai Germaschewski wrote:
>On Wed, 28 Nov 2001, Mike Black wrote:
>
>> This appears to be a non-fatal warning....does this need to be cleaned up?
>> [...]
>> {standard input}: Assembler messages:
>> {standard input}:1107: Warning: indirect lcall without `*'
>> {standard input}:1192: Warning: indirect lcall without `*'
>> [...]
>
>I believe this cannot be cleaned up in 2.4 because it breaks older 
>binutils. However, what about the appended patch for 2.5?

Kai's patch is almost identical to what I've been applying to every 2.3/2.4
kernel for the last year, ever since RedHat included a newer binutils
which printed these "indirect lcall without `*'" warnings.
My patch kit also fixes an occurrence in bootsect.S -- see below.

This really ought to go into 2.5 ASAP, IMHO.

/Mikael

--- linux-2.4.17-pre1/arch/i386/boot/bootsect.S.~1~	Fri Nov 23 22:40:14 2001
+++ linux-2.4.17-pre1/arch/i386/boot/bootsect.S	Wed Nov 28 20:33:06 2001
@@ -236,7 +236,7 @@
 rp_read:
 #ifdef __BIG_KERNEL__			# look in setup.S for bootsect_kludge
 	bootsect_kludge = 0x220		# 0x200 + 0x20 which is the size of the
-	lcall	bootsect_kludge		# bootsector + bootsect_kludge offset
+	lcall	*bootsect_kludge	# bootsector + bootsect_kludge offset
 #else
 	movw	%es, %ax
 	subw	$SYSSEG, %ax
