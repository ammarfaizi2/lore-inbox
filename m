Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVJaLNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVJaLNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVJaLNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:13:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21510 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932286AbVJaLNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:13:54 -0500
Date: Mon, 31 Oct 2005 12:13:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Urban Widmark <urban@teststation.com>, samba@samba.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/smbfs/request.c: turn NULL dereference into BUG()
Message-ID: <20051031111349.GG8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a case documented as

  We should never be called with any of these states

BUG() in a case that would later result in a NULL pointer dereference.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Jul 2005
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
