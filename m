Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTDNTED (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDNTEC (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:04:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263855AbTDNTEB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:04:01 -0400
Date: Mon, 14 Apr 2003 12:15:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [FBDEV BK] Updates and fixes.
In-Reply-To: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0304141209420.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, James Simmons wrote:
> 
> Linus, please do a
> 
> 	bk pull http://fbdev.bkbits.net/fbdev-2.5

This seems to cause

	arch/i386/boot/setup.o(.text+0x9a4): In function `video':
	: undefined reference to `store_edid'

which is apparently because I don't configure VIDEO_SELECT.

I did this to make it compile, but you should check what the real issue 
is.

		Linus
----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1034  -> 1.1035 
#	arch/i386/boot/video.S	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/14	torvalds@home.transmeta.com	1.1035
# Store EDID only when CONFIG_VIDEO_SELECT is set and edid
# function actually exists.
# --------------------------------------------
#
diff -Nru a/arch/i386/boot/video.S b/arch/i386/boot/video.S
--- a/arch/i386/boot/video.S	Mon Apr 14 12:14:46 2003
+++ b/arch/i386/boot/video.S	Mon Apr 14 12:14:46 2003
@@ -133,9 +133,9 @@
 #ifdef CONFIG_VIDEO_RETAIN
 	call	restore_screen			# Restore screen contents
 #endif /* CONFIG_VIDEO_RETAIN */
+	call	store_edid
 #endif /* CONFIG_VIDEO_SELECT */
 	call	mode_params			# Store mode parameters
-	call	store_edid
 	popw	%ds				# Restore original DS
 	ret
 

