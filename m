Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbTD3H4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 03:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbTD3H4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 03:56:51 -0400
Received: from pc-80-195-84-110-du.blueyonder.co.uk ([80.195.84.110]:47745
	"EHLO skymoo.dyndns.org") by vger.kernel.org with ESMTP
	id S262124AbTD3H4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 03:56:50 -0400
Date: Wed, 30 Apr 2003 09:09:10 +0100
From: Adam Mercer <r.a.mercer@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH 2.4.21-rc1] vesafb with large memory
Message-ID: <20030430080910.GA5011@skymoo.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I've recently been having a problem with the vesafb refusing to boot on
my system, after investigation the problem further I found that it had
been mentioned on the 27 March 2003, in this thread

http://marc.theaimsgroup.com/?l=linux-kernel&m=104878364823195&w=2

In the thread Walt H, waltabbyh <at> comcast <dot> net, provides a fix.
After just downloading 2.4.21-rc1 I noticed that this fix was not
present. So heres a patch against 2.4.21-rc1 to fix this probelm.

Please CC me with any responses as I'm not on the list.

Cheers

Adam

diff -urN linux-2.4.21-rc1-orig/drivers/video/vesafb.c linux-2.4.21-rc1/drivers/video/vesafb.c
--- linux-2.4.21-rc1-orig/drivers/video/vesafb.c  2002-11-28 23:53:15.000000000 +0000
+++ linux-2.4.21-rc1/drivers/video/vesafb.c 2003-04-30 08:32:02.000000000 +0100
@@ -520,7 +520,7 @@
	video_width         = screen_info.lfb_width;
	video_height        = screen_info.lfb_height;
	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_size * 65536;
+	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
	video_visual = (video_bpp == 8) ?
		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;						

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.21-rc1-vesafb-highmem.patch"

diff -urN linux-2.4.21-rc1-orig/drivers/video/vesafb.c linux-2.4.21-rc1/drivers/video/vesafb.c
--- linux-2.4.21-rc1-orig/drivers/video/vesafb.c	2002-11-28 23:53:15.000000000 +0000
+++ linux-2.4.21-rc1/drivers/video/vesafb.c	2003-04-30 08:32:02.000000000 +0100
@@ -520,7 +520,7 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_size * 65536;
+	video_size          = screen_info.lfb_width * screen_info.lfb_height * video_bpp;
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 

--6TrnltStXW4iwmi0--
