Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVCZNLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVCZNLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVCZNLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:11:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54290 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262042AbVCZNLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:11:35 -0500
Date: Sat, 26 Mar 2005 14:11:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Urban Widmark <urban@teststation.com>, samba@samba.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [2.6 patch] fs/smbfs/request.c: turn NULL dereference into BUG()
Message-ID: <20050326131132.GB3237@stusta.de>
References: <20050325001540.GF3966@stusta.de> <20050326100253.3edbb2fc.khali@linux-fr.org> <20050326125301.GA3237@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326125301.GA3237@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 01:53:01PM +0100, Adrian Bunk wrote:
>...
> The problem is actually only in the SMB_RECV_END and SMB_RECV_REQUEST 
> cases and all code after the NULL pointer dereference is actually dead 
> code.
>...

OK, this was also wrong...

Third try.

cu
Adrian


<--  snip  -->


In a case documented as

  We should never be called with any of these states

BUG() in a case that would later result in a NULL pointer dereference.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
