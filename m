Return-Path: <linux-kernel-owner+w=401wt.eu-S1422720AbXAMRIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbXAMRIW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 12:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbXAMRIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 12:08:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:32316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422720AbXAMRIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 12:08:21 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dvZNowZsQ7hJg1gvYfWwT3qFPy0ttIN+LhnWnvWwbGc0VPrz5Er8E/zhfK/DfMcR5X3PEYuPJNHRL33GjRWNM5o2ukyU9lf2HD1uCv4rnwYWmJ6fz9j20V/AZKb7yFthZzndHkSo8rlhQLJCx5KgLVJmZTcJORlIi3YqiUNYYRY=
Date: Sat, 13 Jan 2007 20:06:44 +0300
From: "Cyrill V. Gorcunov" <gorcunov@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel-list <linux-kernel@vger.kernel.org>,
       "Cyrill V. Gorcunov" <gorcunov@gmail.com>
Subject: [PATCH] qconf: Back button behaviour normalization
Message-ID: <20070113170644.GA2415@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does "Back" button behaviour normalization so
it is enabled starting from second-level menu only. 

Signed-off-by: Cyrill V. Gorcunov <gorcunov@gmail.com>

---

Roman, please check it... may be a better way does exist to do it.
The diff is produced over pure Linux v2.6.20-rc5

 scripts/kconfig/qconf.cc |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index c0ae0a7..34f1faf 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1467,7 +1467,10 @@ void ConfigMainWindow::searchConfig(void)
 void ConfigMainWindow::changeMenu(struct menu *menu)
 {
 	configList->setRootMenu(menu);
-	backAction->setEnabled(TRUE);
+	if (configList->rootEntry->parent == &rootmenu)
+		backAction->setEnabled(FALSE);
+	else
+		backAction->setEnabled(TRUE);
 }
 
 void ConfigMainWindow::setMenuLink(struct menu *menu)

