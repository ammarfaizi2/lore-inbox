Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUDHEDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 00:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUDHEDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 00:03:43 -0400
Received: from ozlabs.org ([203.10.76.45]:36073 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261528AbUDHEDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 00:03:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16500.52998.651443.786@cargo.ozlabs.ibm.com>
Date: Thu, 8 Apr 2004 14:03:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] disable VT on iSeries by default
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch from Julie DeWandel makes CONFIG_VT default to N on iSeries
machines which are using the iSeries virtual console driver viocons.c.
The VT console and the viocons code can't coexist because they use the
same tty numbers, that is, viocons supplies /dev/tty1.  Without this
patch the user has to figure out somehow that s/he has to turn on
CONFIG_EMBEDDED in order to be able to turn off CONFIG_VT, which is
really very non-obvious.

Please apply.

Thanks,
Paul.

--- linux-2.6/drivers/char/Kconfig.orig	2004-03-17 08:54:06.000000000 -0500
+++ linux-2.6/drivers/char/Kconfig	2004-04-06 15:17:00.000000000 -0400
@@ -7,7 +7,7 @@ menu "Character devices"
 config VT
 	bool "Virtual terminal" if EMBEDDED
 	select INPUT
-	default y
+	default y if !VIOCONS
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
