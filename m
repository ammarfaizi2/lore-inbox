Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTICNiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTICNhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:37:32 -0400
Received: from chello080109223066.lancity.graz.surfer.at ([80.109.223.66]:20612
	"EHLO lexx.delysid.org") by vger.kernel.org with ESMTP
	id S262182AbTICNgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:36:49 -0400
To: linux-kernel@vger.kernel.org
CC: dave@mielke.cc
Subject: 2.6.0-test4: fbcon missing con_set_default_unimap?
From: Mario Lang <mlang@delysid.org>
Date: Wed, 03 Sep 2003 15:36:54 +0200
Message-ID: <87fzjegfih.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Well, I investigated the previously reported issue
regarding a empty SFM when using fbcon a bit more.

What looks strange to me is that it seems that con_set_default_unimap
is never called when using fbcon.  Below patch fixes my problems,
after boot, I have a correctly defined sfm.  However, since
I am totally new to kernel hacking, I suspect it is not really
correct.  However, it is tested, and it works for me as expected.

--- linux-2.6.0-test4/drivers/video/console/fbcon.c.orig	2003-09-03 15:32:42.000000000 +0200
+++ linux-2.6.0-test4/drivers/video/console/fbcon.c	2003-09-03 15:27:09.000000000 +0200
@@ -695,6 +695,7 @@
 		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
 	else
 		fb_display[unit].scrollmode = SCROLL_YREDRAW;
+	con_set_default_unimap(unit);
 	fbcon_set_display(vc, init, !init);
 }
 

-- 
CYa,
  Mario | Debian Developer <URL:http://debian.org/>
        | Get my public key via finger mlang@db.debian.org
        | 1024D/7FC1A0854909BCCDBE6C102DDFFC022A6B113E44
