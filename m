Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTEQTDU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 15:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEQTDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 15:03:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34316 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261775AbTEQTDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 15:03:19 -0400
Date: Sat, 17 May 2003 21:16:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove 'strchr' warning from reiserfs
Message-ID: <20030517191611.GA10417@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please apply - maintainer cc:ed for info.

Reiserfs emits a warning about strchr being defined but not
used. I finally tracked down the reason for this.
gcc - when seeing strstr(x, "%") recognized that the second parameter
is a char, and therefore uses strchr instead of strstr.
The workaround to avoid the warning is to replace the call
to strstr with strchr - which is OK.

This hides the warning, and brings us down to 6 warnings for a
make defconfig bzImage.

	Sam

===== fs/reiserfs/prints.c 1.21 vs edited =====
--- 1.21/fs/reiserfs/prints.c	Sun Mar 23 07:14:13 2003
+++ edited/fs/reiserfs/prints.c	Sat May 17 21:08:16 2003
@@ -164,7 +164,7 @@
 
   *skip = 0;
   
-  while ((k = strstr (k, "%")) != NULL)
+  while ((k = strchr (k, '%')) != NULL)
   {
     if (k[1] == 'k' || k[1] == 'K' || k[1] == 'h' || k[1] == 't' ||
 	      k[1] == 'z' || k[1] == 'b' || k[1] == 'y' || k[1] == 'a' ) {
