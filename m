Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVDEUer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVDEUer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVDEUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:32:44 -0400
Received: from mandjes.xs4all.nl ([213.84.157.203]:64040 "EHLO
	iris.hendrikweg.doorn") by vger.kernel.org with ESMTP
	id S261910AbVDEUIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:08:47 -0400
From: Kees Bakker <kees.bakker@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2 atkbd Multi_key changed into mouse button 4
Date: Tue, 5 Apr 2005 22:08:39 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504052208.39573.kees.bakker@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.12-rc1 (and rc2) the Multi_key on my keyboard gives mouse button 4
events. I found out that it is caused by the change in the atkbd.scroll
parameter (see drivers/input/keyboard/atkbd.c). If I change it to 0,
the keyboard is back at its old behavior. Probably Vojtech assumed it
was OK to switch it on by default. To me it seems that the default should
be off, since there are obviously conflicts with standard keyboards
(assuming mine is one).

Here is a patch that undoes the change.

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c    2005-04-04 09:40:48 -07:00
+++ b/drivers/input/keyboard/atkbd.c    2005-04-04 09:40:48 -07:00
@@ -54,7 +54,7 @@
 module_param_named(softraw, atkbd_softraw, bool, 0);
 MODULE_PARM_DESC(softraw, "Use software generated rawmode");

-static int atkbd_scroll = 1;
+static int atkbd_scroll;
 module_param_named(scroll, atkbd_scroll, bool, 0);
 MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");



		Kees
