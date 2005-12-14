Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVLNVKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVLNVKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVLNVKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:10:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31246 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964973AbVLNVKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:10:41 -0500
Date: Wed, 14 Dec 2005 22:10:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       Charles Lever <Charles.Lever@netapp.com>, netdev@vger.kernel.org
Subject: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
Message-ID: <20051214211041.GD23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes ths unused function xdr_decode_string().


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Neil Brown <neilb@suse.de>
Acked-by: Charles Lever <Charles.Lever@netapp.com>

---

 include/linux/sunrpc/xdr.h |    1 -
 net/sunrpc/xdr.c           |   21 ---------------------
 2 files changed, 22 deletions(-)

--- linux-2.6.15-rc1-mm2-full/include/linux/sunrpc/xdr.h.old	2005-11-23 02:03:01.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/linux/sunrpc/xdr.h	2005-11-23 02:03:08.000000000 +0100
@@ -91,7 +91,6 @@
 u32 *	xdr_encode_opaque_fixed(u32 *p, const void *ptr, unsigned int len);
 u32 *	xdr_encode_opaque(u32 *p, const void *ptr, unsigned int len);
 u32 *	xdr_encode_string(u32 *p, const char *s);
-u32 *	xdr_decode_string(u32 *p, char **sp, int *lenp, int maxlen);
 u32 *	xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen);
 u32 *	xdr_encode_netobj(u32 *p, const struct xdr_netobj *);
 u32 *	xdr_decode_netobj(u32 *p, struct xdr_netobj *);
--- linux-2.6.15-rc1-mm2-full/net/sunrpc/xdr.c.old	2005-11-23 02:03:17.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/sunrpc/xdr.c	2005-11-23 02:03:27.000000000 +0100
@@ -93,27 +93,6 @@
 }
 
 u32 *
-xdr_decode_string(u32 *p, char **sp, int *lenp, int maxlen)
-{
-	unsigned int	len;
-	char		*string;
-
-	if ((len = ntohl(*p++)) > maxlen)
-		return NULL;
-	if (lenp)
-		*lenp = len;
-	if ((len % 4) != 0) {
-		string = (char *) p;
-	} else {
-		string = (char *) (p - 1);
-		memmove(string, p, len);
-	}
-	string[len] = '\0';
-	*sp = string;
-	return p + XDR_QUADLEN(len);
-}
-
-u32 *
 xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen)
 {
 	unsigned int	len;

