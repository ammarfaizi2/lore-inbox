Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTLSQRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTLSQRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:17:36 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:1028 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262323AbTLSQRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:17:34 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module Alias back compat code
References: <20031219031034.A38502C06C@lists.samba.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 20 Dec 2003 01:16:45 +0900
In-Reply-To: <20031219031034.A38502C06C@lists.samba.org>
Message-ID: <87hdzwye8i.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> The provides backwards compat for old char and block aliases.
> 
> MODULE_ALIAS_BLOCK() and MODULE_ALIAS_CHAR() define aliases of form
> "XXX-<major>-<minor>", so we should probe for modules using this
> form.  Unfortunately in 2.4, block aliases were "XXX-<major>" and
> char aliases were of both forms.
> 
> Ideally, all modules would now be using MODULE_ALIAS() macros to
> define their aliases, and the old configuration files wouldn't
> matter as much.  Unfortunately, this hasn't happened, so we make
> request_module() return the exit status of modprobe, and then
> do fallback when probing for char and block devices.

Umm.. Although I may be mis-understanding this problem, is the following
scripts the not enough?

This does

	block-major-1 -> block-major-1-*


--- generate-modprobe.conf.orig	2003-08-12 05:03:59.000000000 +0900
+++ generate-modprobe.conf	2003-12-20 00:31:17.000000000 +0900
@@ -59,8 +59,9 @@
 parse_alias()
 {
     PA_ALIAS=`resolve_alias $1 $3`
+    NAME=`echo $2|sed -e 's/\(block\|char\)-major-\([0-9]\+\)$/\1-major-\2-*/'`
 
-    echo "alias $2 $PA_ALIAS"
+    echo "alias $NAME $PA_ALIAS"
 }
 
 # Parse options: args modulename aliasto.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
