Return-Path: <linux-kernel-owner+w=401wt.eu-S1754308AbWLYIQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbWLYIQJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 03:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbWLYIQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 03:16:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:32824 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbWLYIQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 03:16:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=Og+hni6PSpLUH96aS+CS+e1iJAM8IK13ssaioFxn8EC9eJytMuU2k/WrZ231nPc2vBDeJD4bT2RAwsohZDUXhMpFoZtnh285HNna//GK7i1tNNb57Ck961aaLRafmxkNg/b1jW0tBbrcB+n+l9qXKE/9NVgi2ZjYSvr5I6IrPEw=
Date: Mon, 25 Dec 2006 17:15:57 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] module: fix mod_sysfs_setup() return value
Message-ID: <20061225081557.GD3869@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mod_sysfs_setup() doesn't return error when kobject_add_dir() failed.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 kernel/module.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: 2.6-mm/kernel/module.c
===================================================================
--- 2.6-mm.orig/kernel/module.c
+++ 2.6-mm/kernel/module.c
@@ -1132,8 +1132,10 @@ static int mod_sysfs_setup(struct module
 		goto out;
 
 	mod->drivers_dir = kobject_add_dir(&mod->mkobj.kobj, "drivers");
-	if (!mod->drivers_dir)
+	if (!mod->drivers_dir) {
+		err = -ENOMEM;
 		goto out_unreg;
+	}
 
 	err = module_param_sysfs_setup(mod, kparam, num_params);
 	if (err)
