Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWFOLA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWFOLA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFOLA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:00:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16326 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964783AbWFOLA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:00:26 -0400
Date: Thu, 15 Jun 2006 12:00:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sctp_unpack_cookie() fix
Message-ID: <20060615110024.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof(pointer) != sizeof(array)...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 net/sctp/sm_make_chunk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

ce06687e3f7fea0950ce36423349d113e9cd0d3a
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 5e0de3c..2a87736 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1402,14 +1402,14 @@ struct sctp_association *sctp_unpack_coo
 	sg.length = bodysize;
 	key = (char *)ep->secret_key[ep->current_key];
 
-	memset(digest, 0x00, sizeof(digest));
+	memset(digest, 0x00, SCTP_SIGNATURE_SIZE);
 	sctp_crypto_hmac(sctp_sk(ep->base.sk)->hmac, key, &keylen, &sg,
 			 1, digest);
 
 	if (memcmp(digest, cookie->signature, SCTP_SIGNATURE_SIZE)) {
 		/* Try the previous key. */
 		key = (char *)ep->secret_key[ep->last_key];
-		memset(digest, 0x00, sizeof(digest));
+		memset(digest, 0x00, SCTP_SIGNATURE_SIZE);
 		sctp_crypto_hmac(sctp_sk(ep->base.sk)->hmac, key, &keylen,
 				 &sg, 1, digest);
 
-- 
1.3.GIT

