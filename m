Return-Path: <linux-kernel-owner+w=401wt.eu-S932768AbWLZTeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWLZTeI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 14:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWLZTeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 14:34:07 -0500
Received: from mout0.freenet.de ([194.97.50.131]:45060 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932768AbWLZTeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 14:34:06 -0500
X-Greylist: delayed 4321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 14:34:06 EST
Content-Disposition: inline
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Immediately update integer and string values in xconfig display
Date: Tue, 26 Dec 2006 19:22:06 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200612261922.06930.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In xconfig's display integer and string values are also shown as part of
the config item's descriptive text.
This patch updates the descriptive text, when the corresponding
value has been changed.
Fix for http://bugzilla.kernel.org/show_bug.cgi?id=7744

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- rc1/scripts/kconfig/qconf.cc	2006-12-23 21:35:12.000000000 +0100
+++ rc1-rt6-kw/scripts/kconfig/qconf.cc	2006-12-26 18:51:51.000000000 +0100
@@ -89,6 +89,8 @@ void ConfigItem::okRename(int col)
 {
 	Parent::okRename(col);
 	sym_set_string_value(menu->sym, text(dataColIdx).latin1());
+	sym_calc_value(menu->sym);
+	updateMenu();
 }
 #endif
 
