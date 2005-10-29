Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVJ2VGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVJ2VGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 17:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVJ2VGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 17:06:38 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20399 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751083AbVJ2VGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 17:06:37 -0400
Date: Sat, 29 Oct 2005 17:06:21 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Matt Mackall <mpm@selenic.com>
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
In-Reply-To: <1130504043.9574.56.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
 <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
 <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I already posted this patch to Matt and LKML, but I'm posting it again
incase anyone else has this problem using ketchup on 2.6.14 from nothing,
and does a google looking for a fix.

Here's the current output error:

$ ketchup 2.6.14
None -> 2.6.14
Unpacking linux-2.6.14.tar.bz2
rmdir: `linux-2.6.14': Directory not empty
ketchup: Unpacking failed:
256


Here's the patch:

-- Steve

Index: Ketchup-d9503020b3c1/ketchup
===================================================================
--- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 08:38:50.000000000 -0400
+++ Ketchup-d9503020b3c1/ketchup	2005-10-28 10:45:43.000000000 -0400
@@ -482,7 +482,7 @@
         error("Unpacking failed: ", err)
         sys.exit(-1)

-    err = os.system("mv linux*/* . ; rmdir linux*")
+    err = os.system("shopt -s dotglob; mv linux*/* . ; rmdir linux*")
     if err:
         error("Unpacking failed: ", err)
         sys.exit(-1)

