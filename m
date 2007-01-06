Return-Path: <linux-kernel-owner+w=401wt.eu-S1751142AbXAFDV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXAFDV1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 22:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAFDV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 22:21:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46910 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbXAFDV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 22:21:26 -0500
Date: Sat, 6 Jan 2007 04:20:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@localhost.localdomain
To: "Cyrill V. Gorcunov" <gorcunov@gmail.com>
cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] qconf: fix SIGSEGV on empty menu items
In-Reply-To: <200701042106.37338.gorcunov@gmail.com>
Message-ID: <Pine.LNX.4.64.0701060415130.12512@localhost.localdomain>
References: <200701042106.37338.gorcunov@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Jan 2007, Cyrill V. Gorcunov wrote:

> qconf may cause SIGSEGV by trying to show debug
> information on empty menu items

Thanks, but this is more complex than necessary.
It simply lacks some initializers.

bye, Roman

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
Index: linux-2.6/scripts/kconfig/qconf.cc
===================================================================
--- linux-2.6.orig/scripts/kconfig/qconf.cc	2007-01-05 01:47:54.000000000 +0100
+++ linux-2.6/scripts/kconfig/qconf.cc	2007-01-05 01:56:54.000000000 +0100
@@ -915,7 +915,7 @@ void ConfigView::updateListAll(void)
 }
 
 ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
-	: Parent(parent, name), menu(0)
+	: Parent(parent, name), menu(0), sym(0)
 {
 	if (name) {
 		configSettings->beginGroup(name);
@@ -951,6 +951,7 @@ void ConfigInfoView::setInfo(struct menu
 	if (menu == m)
 		return;
 	menu = m;
+	sym = NULL;
 	if (!menu)
 		clear();
 	else
