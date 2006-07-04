Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWGDU3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWGDU3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWGDU3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:29:06 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:51099 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S932390AbWGDU3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:29:05 -0400
Date: Tue, 4 Jul 2006 22:29:04 +0200
From: Petr Vandrovec <petr@vandrovec.name>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add note that lockdep is not allowed with non-GPL modules
Message-ID: <20060704202904.GA24150@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
  can you add this small notice to the lockdep option ?  

Lock dependency infrastructure forces all legacy code which uses lock to now
depend on lockdep_init_map symbol, which is GPL-only.  It means that almost
no modules can work on kernel with CONFIG_LOCKDEP set.  Let's warn user about
that.

vmmon: module license 'unspecified' taints kernel.
vmmon: Unknown symbol lockdep_init_map

				Thanks,
					Petr Vandrovec

Signed-off-by: Petr Vandrovec <petr@vandrovec.name>


--- linux-2.6.17-3130.dist/lib/Kconfig.debug	2006-07-04 19:31:36.000000000 +0200
+++ linux-2.6.17-3130/lib/Kconfig.debug	2006-07-04 21:55:35.000000000 +0200
@@ -214,6 +214,9 @@
 
 	 For more details, see Documentation/lockdep-design.txt.
 
+	 Do not enable this option if you are using non-GPL modules, or
+	 they will fail to load due to missing symbol lockdep_init_map.
+
 config LOCKDEP
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
