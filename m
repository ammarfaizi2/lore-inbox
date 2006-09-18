Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWIRStF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWIRStF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWIRStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:49:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42448 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751788AbWIRStC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:49:02 -0400
Subject: [PATCH] slim: socket_post_create hook return code
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 11:48:54 -0700
Message-Id: <1158605334.16727.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The socket_post_create LSM hook has gone from a void return to an int.
This patch properly updates the SLIM hook definition and return to
reflect this change.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-of-by: Kylene Hall <kjhall@us.ibm.com>
---
 security/slim/slm_main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc6-mm2/security/slim/slm_main.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/security/slim/slm_main.c
+++ linux-2.6.18-rc6-mm2/security/slim/slm_main.c
@@ -1129,7 +1131,7 @@ int slm_socket_create(int family, int ty
 /*
  * Didn't have the family type previously, so update the inode security now.
  */
-static void slm_socket_post_create(struct socket *sock, int family,
+static int slm_socket_post_create(struct socket *sock, int family,
 				   int type, int protocol, int kern)
 {
 	struct slm_tsec_data *cur_tsec = current->security;
@@ -1145,6 +1147,7 @@ static void slm_socket_post_create(struc
 	} else
 		set_level_untrusted(&slm_isec->level);
 	spin_unlock(&slm_isec->lock);
+	return 0;
 }
 
 /*


