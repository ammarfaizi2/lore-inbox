Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVJQVhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVJQVhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVJQVhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:37:40 -0400
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:32899 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932339AbVJQVhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:37:39 -0400
Date: Mon, 17 Oct 2005 22:37:37 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mark __init code noinline to stop erroneous inclusions
Message-ID: <20051017213737.GA18686@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Make __init also have the noinline attribute attached
to it, to stop code marked as __init being included
into non __init code. This not only wastes space, but
also makes it impossible to track down any calls from
non-init code as differing compilers and optimisations
make differing decisions on what to inline.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="init-noinline-code.patch"

--- linux-2.6.14-rc4-git4-bjd2/include/linux/init.h	2005-09-01 21:02:39.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd3/include/linux/init.h	2005-10-17 22:26:48.000000000 +0100
@@ -41,7 +41,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__attribute__ ((__section__ (".init.text")))
+#define __init		noinline __attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))

--k+w/mQv8wyuph6w0--
