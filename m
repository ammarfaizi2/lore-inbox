Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbUB0VzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUB0VzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:55:22 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:9156 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S263163AbUB0Vy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:54:29 -0500
Date: Fri, 27 Feb 2004 14:54:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: [KGDB PATCH][7/7] Move debugger_entry()
Message-ID: <20040227215428.GJ1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net> <20040227214031.GF1052@smtp.west.cox.net> <20040227214605.GH1052@smtp.west.cox.net> <20040227215211.GI1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227215211.GI1052@smtp.west.cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  When we use kgdboe, we can't use it until do_basic_setup() is done.
So we have two options, not allow kgdboe to use the initial breakpoint
or move debugger_entry() to be past the point where kgdboe will be usable.
I've opted for the latter, as if an earlier breakpoint is needed you can
still use serial and throw kgdb_schedule_breakpoint/breakpoint where desired.

--- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 11:33:51.854388988 -0700
@@ -581,6 +582,7 @@ static int init(void * unused)
 
 	smp_init();
 	do_basic_setup();
+	debugger_entry();
 
 	prepare_namespace();
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
