Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbTDIF0P (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTDIF0P (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:26:15 -0400
Received: from dp.samba.org ([66.70.73.150]:41412 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262733AbTDIF0O (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 01:26:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER? 
In-reply-to: Your message of "Wed, 09 Apr 2003 01:06:05 -0400."
             <3E93AA3D.4050104@pobox.com> 
Date: Wed, 09 Apr 2003 15:27:12 +1000
Message-Id: <20030409053753.E613E2C06A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E93AA3D.4050104@pobox.com> you write:
> 
> looks ok to me

After months of intense negotiation, we have... a comment. 8)

Thanks Jeff.

Linus, please apply.
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67-bk1/include/linux/module.h working-2.5.67-bk1-set-owner/include/linux/module.h
--- linux-2.5.67-bk1/include/linux/module.h	2003-04-08 11:15:01.000000000 +1000
+++ working-2.5.67-bk1-set-owner/include/linux/module.h	2003-04-09 15:15:47.000000000 +1000
@@ -408,6 +408,12 @@ __attribute__((section(".gnu.linkonce.th
 #endif /* MODULE */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
+
+/* If you want backwards compat: some structs didn't have owner fields once */
+/* Think of SET_MODULE_OWNER like an IBM mainframe: leave it in a dark 
+   corner for years, don't break it, but don't ever upgrade it either :) 
+   If there is something newer and sexier than the mainframe, it's ok to 
+   use that instead.  The mainframe won't feel lonely. -- Jeff Garzik */
 #define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
