Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTKQJke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTKQJke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:40:34 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:28430 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263447AbTKQJkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:40:33 -0500
Date: Mon, 17 Nov 2003 20:40:26 +1100
To: neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [LOCKD] Fix double module_put
Message-ID: <20031117094026.GA12562@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch fixes a double module_put in lockd.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/fs/lockd/clntlock.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/lockd/clntlock.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 clntlock.c
--- kernel-source-2.5/fs/lockd/clntlock.c	27 Jul 2003 17:09:35 -0000	1.1.1.3
+++ kernel-source-2.5/fs/lockd/clntlock.c	17 Nov 2003 09:37:40 -0000
@@ -188,7 +188,7 @@
 		nlmclnt_prepare_reclaim(host, newstate);
 		nlm_get_host(host);
 		__module_get(THIS_MODULE);
-		if (kernel_thread(reclaimer, host, CLONE_KERNEL))
+		if (kernel_thread(reclaimer, host, CLONE_KERNEL) < 0)
 			module_put(THIS_MODULE);
 	}
 }

--vkogqOf2sHV7VnPd--
