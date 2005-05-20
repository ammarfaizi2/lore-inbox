Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVETFdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVETFdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 01:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVETFdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 01:33:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:6580 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261338AbVETFdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 01:33:18 -0400
Message-ID: <428D7680.5040304@sw.ru>
Date: Fri, 20 May 2005 09:32:48 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021224
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] random poolsize sysctl fix
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030503080306090904010502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503080306090904010502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcelo,

SWSoft Linux kernel Team has discovered that your patch 
http://linux.bkbits.net:8080/linux-2.4/gnupatch@41e2c4fetTJmVti-Xxql21xXjfbpag
which should fix a random poolsize sysctl handler integer overflow, is 
wrong.
You have changed a variable definition in function proc_do_poolsize(), 
but you had to fix an another function, poolsize_strategy()

Vasily Averin
SWSoft Linux kernel Team

--------------030503080306090904010502
Content-Type: text/plain;
 name="diff-security-rndpoolsize-20050520"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-security-rndpoolsize-20050520"

--- ./drivers/char/random.c.rndps	Wed Jan 19 17:09:48 2005
+++ ./drivers/char/random.c	Fri May 20 09:09:18 2005
@@ -1771,7 +1771,7 @@ static int change_poolsize(int poolsize)
 static int proc_do_poolsize(ctl_table *table, int write, struct file *filp,
 			    void *buffer, size_t *lenp)
 {
-	unsigned int	ret;
+	int	ret;
 
 	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
 
@@ -1787,7 +1787,7 @@ static int poolsize_strategy(ctl_table *
 			     void *oldval, size_t *oldlenp,
 			     void *newval, size_t newlen, void **context)
 {
-	int	len;
+	unsigned int	len;
 	
 	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
 

--------------030503080306090904010502--

