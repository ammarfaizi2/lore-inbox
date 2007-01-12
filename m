Return-Path: <linux-kernel-owner+w=401wt.eu-S932120AbXALQk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbXALQk6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 11:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbXALQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 11:40:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:57832 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbXALQk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 11:40:57 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ODJYBDAhtU+xyaHVZtqlE0SJTIB9WIXt33SrNTLGBJvnafKBts/pTt0PNicfdt4fRfO5zUylQq/LwgJ/xX9pOsHCckfhwXIiLwrfvmOoOS+ROK7O06GIC7yehY3NVgUaa7x5NxGTe2rwkp939/vh88i7yeaErCL9EBZq4QgVdSM=
Date: Fri, 12 Jan 2007 19:39:16 +0300
From: "Cyrill V. Gorcunov" <gorcunov@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel-list <linux-kernel@vger.kernel.org>
Subject: [PATCH] qconf: fix showing help info on failed search
Message-ID: <20070112163916.GA13958@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

qconf does not clear help text in search window
if previous search has been failed.

Signed-off-by: Cyrill V. Gorcunov <gorcunov@mail.ru>

---

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index c0ae0a7..f9a63a4 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1247,6 +1247,7 @@ void ConfigSearchWindow::search(void)
 
 	free(result);
 	list->list->clear();
+	info->clear();
 
 	result = sym_re_search(editField->text().latin1());
 	if (!result)
