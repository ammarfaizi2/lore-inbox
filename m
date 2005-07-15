Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVGOVfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVGOVfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 17:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVGOVfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 17:35:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14346 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261207AbVGOVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 17:35:02 -0400
Date: Fri, 15 Jul 2005 23:34:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Urban Widmark <urban@teststation.com>
Cc: samba@samba.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/smbfs/request.c: turn NULL dereference into BUG()
Message-ID: <20050715213454.GF18059@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a case documented as

  We should never be called with any of these states

BUG() in a case that would later result in a NULL pointer dereference.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Mar 2005

--- linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c.old	2005-03-26 13:19:19.000000000 +0100
+++ linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c	2005-03-26 13:41:30.000000000 +0100
@@ -786,8 +642,7 @@ int smb_request_recv(struct smb_sb_info 
 		/* We should never be called with any of these states */
 	case SMB_RECV_END:
 	case SMB_RECV_REQUEST:
-		server->rstate = SMB_RECV_END;
-		break;
+		BUG();
 	}
 
 	if (result < 0) {
