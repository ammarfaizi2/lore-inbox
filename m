Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbUKWGdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUKWGdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUKWGOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:14:37 -0500
Received: from [211.58.254.17] ([211.58.254.17]:58522 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262139AbUKWGM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:12:58 -0500
Date: Tue, 23 Nov 2004 15:12:52 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH REPOST 2.6.10-rc2 0/4] module sysfs: module sysfs related clean ups
Message-ID: <20041123061252.GA14209@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Greg.  Hello, Rusty.

 I forgot kfree(mk) in params.c:kernel_param_sysfs_setup() on failure
path.  You can just add kfree(mk) like the following.

	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip))
+	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
		kobject_unregister(&mk->kobj);
+		kfree(mk);
+	}

 I also regenerated all patches.  Sorry for the inconvenience.

-- 
tejun

