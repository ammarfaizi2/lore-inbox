Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbTLHPTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbTLHPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:19:22 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:34961 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S265399AbTLHPTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:19:21 -0500
Date: Mon, 8 Dec 2003 08:19:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH][RESEND] Fix booting on a number of Motorola PPC32 machines
Message-ID: <20031208151919.GX912@stop.crashing.org>
References: <20031203163526.GH912@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203163526.GH912@stop.crashing.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I first sent this on 3 Dec 2003, with no response or followup.
Currently a number of Motorola PPC32 machine will not boot, as
the final zImage isn't built correctly for them.  The problem is that
we end up setting a Makefile variable to ' y' instead of 'y'.  After
talking with Sam Ravnborg, the following is acceptable.

===== arch/ppc/boot/simple/Makefile 1.23 vs edited =====
--- 1.23/arch/ppc/boot/simple/Makefile	Mon Sep 15 01:01:24 2003
+++ edited/arch/ppc/boot/simple/Makefile	Mon Dec  1 12:25:29 2003
@@ -73,9 +73,8 @@
    cacheflag-$(CONFIG_K2)		:= -include $(clear_L2_L3)
 
 # kconfig 'feature', only one of these will ever be 'y' at a time.
-# The rest will be unset.
-motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
-$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
+# The rest will be unset.  Each of these must be on one line.
+motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
 pcore := $(CONFIG_PCORE)$(CONFIG_POWERPMC250)
 
       zimage-$(motorola)		:= zImage-PPLUS


-- 
Tom Rini
http://gate.crashing.org/~trini/
