Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVCQCZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVCQCZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVCQCZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:25:11 -0500
Received: from ixca-out.ixiacom.com ([67.133.120.10]:47146 "EHLO
	ixca-ex1.ixiacom.com") by vger.kernel.org with ESMTP
	id S261766AbVCQCZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:25:04 -0500
Message-ID: <4238EA7F.6050602@rincewind.tv>
Date: Wed, 16 Mar 2005 18:25:03 -0800
X-Sybari-Trust: e2ff72bb 98cd19fb d7e1a431 0000010c
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] af_key: broken error handling in pfkey_xfrm_state2msg()
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000209090306090404070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000209090306090404070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The pfkey_xfrm_state2msg() was missing a return in an EINVAL statement.  
This patch resolves the problem.

Please cc my address on any replies, as I am not on the linux kernel 
mailing list.

Ollie

--------------000209090306090404070601
Content-Type: text/x-patch;
 name="pfkey_xfrm_state2msg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pfkey_xfrm_state2msg.patch"

Fixes broken error handling in pfkey_xfrm_state2msg().

--- net/key/af_key.c.orig	2005-03-16 16:18:10.120476234 -0800
+++ net/key/af_key.c	2005-03-16 16:18:29.665280065 -0800
@@ -598,7 +598,7 @@
 	/* address family check */
 	sockaddr_size = pfkey_sockaddr_size(x->props.family);
 	if (!sockaddr_size)
-		ERR_PTR(-EINVAL);
+		return ERR_PTR(-EINVAL);
 
 	/* base, SA, (lifetime (HSC),) address(SD), (address(P),)
 	   key(AE), (identity(SD),) (sensitivity)> */

--------------000209090306090404070601--
