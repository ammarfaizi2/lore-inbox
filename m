Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136821AbREISo6>; Wed, 9 May 2001 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136822AbREISot>; Wed, 9 May 2001 14:44:49 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:17150 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136821AbREISog>; Wed, 9 May 2001 14:44:36 -0400
Date: Wed, 9 May 2001 20:44:35 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make distclean tries to delete dirs in tmpfs
Message-ID: <20010509204434.Q754@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

make distclean deletes anything with size 0. This includes
directories, while making the kernel in tmpfs or ramfs.

This patch solves it, by not deleting directories in this rule.

Patch applies to any official kernel and with offsets even to
recent ac series.

--- linux-2.4.2-ac19/Makefile.orig  Wed May  9 10:47:04 2001
+++ linux-2.4.2-ac19/Makefile Wed May  9 10:51:04 2001
@@ -415,7 +415,8 @@
 	$(MAKE) -C Documentation/DocBook mrproper

 distclean: mrproper
-	rm -f core `find . \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
+	rm -f core `find . \( -not -type d \) -and \
+		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -print` TAGS tags


Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
