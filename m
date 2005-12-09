Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVLISVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVLISVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVLISUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:20:43 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:3544 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964856AbVLISUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:20:00 -0500
Message-Id: <20051209182053.821119000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:17 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>,
       Geoff Levand <geoff.levand@am.sony.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 3/8] spufs: fix hexdump format
Content-Disposition: inline; filename=spufs-fix-hexdump.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Output from hexdump with "%08x" depends on HOST platform's endian.
When building linux by cross toolchain, that difference makes errors.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Geoff Levand <geoff.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/Makefile
@@ -46,7 +46,7 @@ cmd_hexdump   = ( \
 		echo " * Do not edit!" ; \
 		echo " */" ; \
 		echo "static unsigned int $*_code[] __page_aligned = {" ; \
-		hexdump -v -e '4/4 "0x%08x, " "\n"' $< ; \
+		hexdump -v -e '"0x" 4/1 "%02x" "," "\n"' $< ; \
 		echo "};" ; \
 		) > $@
 quiet_cmd_hexdump = HEXDUMP $@

--

