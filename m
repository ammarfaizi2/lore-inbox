Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSIWSFK>; Mon, 23 Sep 2002 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSIWSFK>; Mon, 23 Sep 2002 14:05:10 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5760 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261177AbSIWSFJ>;
	Mon, 23 Sep 2002 14:05:09 -0400
Date: Mon, 23 Sep 2002 19:35:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Fix thermal managment
Message-ID: <20020923173501.GA6313@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Without this, thermal throttling never goes beyond T1 state because it
forgets previous state each time. This cooks machines. Please apply,
								Pavel

--- clean/drivers/acpi/processor.c	2002-09-23 00:09:12.000000000 +0200
+++ linux-swsusp/drivers/acpi/processor.c	2002-09-23 00:10:11.000000000 +0200
@@ -1478,6 +1478,9 @@
 	 * performance state.
 	 */
 
+	px = pr->limit.thermal.px;
+	tx = pr->limit.thermal.tx;
+
 	switch (type) {
 
 	case ACPI_PROCESSOR_LIMIT_NONE:

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
