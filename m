Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTENOri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTENOri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:47:38 -0400
Received: from port-212-202-185-200.reverse.qdsl-home.de ([212.202.185.200]:49796
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262361AbTENOrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:47:36 -0400
Message-ID: <3EC259FD.1010706@trash.net>
Date: Wed, 14 May 2003 17:00:13 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]: set state to XFRM_STATE_DEAD before calling xfrm_state_put
 in pfkey_msg2xfrm_state
Content-Type: multipart/mixed;
 boundary="------------020707040309080103090309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020707040309080103090309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch sets x->state to XFRM_STATE_DEAD before calling
xfrm_state_put in pfkey_msg2xfrm_state to avoid triggering
the BUG_TRAP in __xfrm_state_destroy. The patch applies to both
2.5 and the 2.4 backport.

Best regards,
Patrick




--------------020707040309080103090309
Content-Type: text/plain;
 name="af_key-set-xfrm-dead.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="af_key-set-xfrm-dead.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1113  -> 1.1114 
#	    net/key/af_key.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/14	kaber@trash.net	1.1114
# [IPSEC]: set state to XFRM_STATE_DEAD before calling xfrm_state_put in pfkey_msg2xfrm_state
# --------------------------------------------
#
diff -Nru a/net/key/af_key.c b/net/key/af_key.c
--- a/net/key/af_key.c	Wed May 14 16:56:52 2003
+++ b/net/key/af_key.c	Wed May 14 16:56:52 2003
@@ -1090,6 +1090,7 @@
 	return x;
 
 out:
+	x->type = XFRM_STATE_DEAD;
 	xfrm_state_put(x);
 	return ERR_PTR(-ENOBUFS);
 }

--------------020707040309080103090309--

