Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbTJ1QVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTJ1QVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:21:32 -0500
Received: from psemail.epfl.ch ([128.178.50.179]:11524 "HELO psemail.epfl.ch")
	by vger.kernel.org with SMTP id S264019AbTJ1QVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:21:31 -0500
Date: Tue, 28 Oct 2003 17:21:29 +0100 (CET)
From: Samuel Ortiz <samuel.ortiz@smartdata.ch>
X-X-Sender: samuel@jourdain
Reply-To: samuel.ortiz@smartdata.ch
To: linux-kernel@vger.kernel.org
Subject: [PATCH] JFFS compile error
Message-ID: <Pine.LNX.4.58.0310281718510.1426@jourdain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When compiling JFFS as a module, set_special_pids is missing since it is
not exported from kernel/exit.c.
Here is a trivial patch to fix that :


--- linux-2.6.0-test9/kernel/exit.c	2003-10-25 20:44:37.000000000 +0200
+++ linux-2.6.0-test9-devlp/kernel/exit.c	2003-10-28 16:45:50.000000000 +0100
@@ -260,6 +260,7 @@
 	__set_special_pids(session, pgrp);
 	write_unlock_irq(&tasklist_lock);
 }
+EXPORT_SYMBOL(set_special_pids);

 /*
  * Let kernel threads use this to say that they
