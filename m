Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUANJIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUANJIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:08:35 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:19840 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265178AbUANJHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:07:49 -0500
Date: Wed, 14 Jan 2004 10:07:43 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: [PATCH] Add -Winline
Message-ID: <20040114090743.GA1975@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add -Winline by default. This makes the compiler warn when something
marked inline is not getting inlined. This is often because the 

It should only make a difference with gcc 3.4, because in earlier
compilers we use always_inline and not inlining with always_inline
is an error already.

--- linux-34/Makefile-o	2004-01-09 09:27:08.000000000 +0100
+++ linux-34/Makefile	2004-01-14 09:36:18.172866544 +0100
@@ -448,6 +449,9 @@
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 
+# warn about impossible inlines
+CFLAGS += $(call check_gcc,-Winline,)
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
 # images.  Uncomment if you want to place them anywhere other than root.
