Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUFEUnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUFEUnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUFEUnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:43:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:19126 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261913AbUFEUng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:43:36 -0400
Date: Sat, 5 Jun 2004 22:43:34 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check missing
Message-ID: <20040605204334.GA1134@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


packet_recvmsg() gets the flags from the compat_sys_socketcall(), but it
does not check for the active MSG_CMSG_COMPAT bit. As a result, it
returns -EINVAL and makes the user rather unhappy


diff -purN linux-2.6.7-rc2-bk5.orig/net/packet/af_packet.c linux-2.6.7-rc2-bk5/net/packet/af_packet.c
--- linux-2.6.7-rc2-bk5.orig/net/packet/af_packet.c	2004-06-05 09:34:48.000000000 +0200
+++ linux-2.6.7-rc2-bk5/net/packet/af_packet.c	2004-06-05 22:32:16.000000000 +0200
@@ -1037,7 +1037,7 @@ static int packet_recvmsg(struct kiocb *
 	int copied, err;
 
 	err = -EINVAL;
-	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
+	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC|MSG_CMSG_COMPAT))
 		goto out;
 
 #if 0
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
