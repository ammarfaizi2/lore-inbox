Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUBOHDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUBOHDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:03:41 -0500
Received: from dp.samba.org ([66.70.73.150]:27541 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264163AbUBOHDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:03:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: Keith M Wesolowski <wesolows@foobazco.org>, linux-kernel@vger.kernel.org
Subject: [PATCH]: Sparc no longer Fucked Up
Date: Sun, 15 Feb 2004 13:44:43 +1100
Message-Id: <20040215070352.1B07F2C0F8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith M Wesolowski <wesolows@foobazco.org>

As of 2.6.3, restore_flags will no longer modify cwp on sparc.
Therefore you can apply this patch to the locking guide.

[ Indeed.  I'll also remove the atomic comments from Hacking
  Guide as part of my revision there when I get back to it.  --RR ]

diff -Nru a/Documentation/DocBook/kernel-locking.tmpl b/Documentation/DocBook/kernel-locking.tmpl
--- a/Documentation/DocBook/kernel-locking.tmpl	Sun Feb  8 15:07:26 2004
+++ b/Documentation/DocBook/kernel-locking.tmpl	Sun Feb  8 15:07:26 2004
@@ -1444,27 +1444,6 @@
     </para>
    </sect1>
 
-   <sect1 id="sparc">
-    <title>The Fucked Up Sparc</title>
-
-    <para>
-      Alan Cox says <quote>the irq disable/enable is in the register
-      window on a sparc</quote>.  Andi Kleen says <quote>when you do
-      restore_flags in a different function you mess up all the
-      register windows</quote>.
-    </para>
-
-    <para>
-      So never pass the flags word set by
-      <function>spin_lock_irqsave()</function> and brethren to another
-      function (unless it's declared <type>inline</type>).  Usually no-one
-      does this, but now you've been warned.  Dave Miller can never do
-      anything in a straightforward manner (I can say that, because I have
-      pictures of him and a certain PowerPC maintainer in a compromising
-      position).
-    </para>
-   </sect1>
-
   </chapter>
 
  <chapter id="Efficiency">

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


