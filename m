Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbTFLJKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbTFLJKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:10:32 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:520 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264799AbTFLJKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:10:31 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: rth@twiddle.net, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix srmcons tty_operations
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Thu, 12 Jun 2003 11:21:14 +0200
Message-ID: <wrpn0gn8xdh.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

The included patch fixes srmcons by adding a missing
tty_set_operations. Booted the patched kernel on a test box with
success.

Thanks,

        M.

===== arch/alpha/kernel/srmcons.c 1.5 vs edited =====
--- 1.5/arch/alpha/kernel/srmcons.c	Wed Jun 11 21:33:05 2003
+++ edited/arch/alpha/kernel/srmcons.c	Thu Jun 12 11:10:35 2003
@@ -291,6 +291,7 @@
 		driver->type = TTY_DRIVER_TYPE_SYSTEM;
 		driver->subtype = SYSTEM_TYPE_SYSCONS;
 		driver->init_termios = tty_std_termios;
+		tty_set_operations(driver, &srmcons_ops);
 		err = tty_register_driver(driver);
 		if (err) {
 			put_tty_driver(driver);

-- 
Places change, faces change. Life is so very strange.
