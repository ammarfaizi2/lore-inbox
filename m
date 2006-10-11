Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030792AbWJKEmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030792AbWJKEmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030793AbWJKEmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 00:42:15 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:33340 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030792AbWJKEmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 00:42:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rureYHNQNa2wI1WrZ2fQpufpvp1rMmhWWMhnYQatHJsX6K7oN/sBZelQNbK66TWY87PMdzybD0CVp1iGBFFl7QZHabxJdixwXASBBYm6rLUwg17ZRIjlDLJVeVEUt0jHULhiy4DZV7BfA8vAGAmVkDuJkMS2ZMbaeV4tuv2nJpA=
Date: Tue, 10 Oct 2006 21:42:00 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1] drivers/media/video/videocodec.c: check
 kmalloc() return value.
Message-Id: <20061010214200.1c88e51b.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function videocodec_build_table(), in file drivers/media/video/videocodec.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/videocodec.c b/drivers/media/video/videocodec.c
index 2ae3fb2..16fc1dd 100644
--- a/drivers/media/video/videocodec.c
+++ b/drivers/media/video/videocodec.c
@@ -348,6 +348,8 @@ #define LINESIZE 100
 	kfree(videocodec_buf);
 	videocodec_buf = (char *) kmalloc(size, GFP_KERNEL);
 
+	if (!videocodec_buf)
+		return 0;
 	i = 0;
 	i += scnprintf(videocodec_buf + i, size - 1,
 		      "<S>lave or attached <M>aster name  type flags    magic    ");
