Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWCYEbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWCYEbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWCYE2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:00 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:46524
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750843AbWCYE12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:28 -0500
Date: Fri, 24 Mar 2006 20:27:05 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Maneesh Soni <maneesh@in.ibm.com>, Oliver Neukum <oliver@neukum.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/20] sysfs: fix a kobject leak in sysfs_add_link on the error path
Message-ID: <20060325042705.GJ21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-0023-sysfs-fix-a-kobject-leak-in-sysfs_add_link-on-the-error-path.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
As pointed out by Oliver Neukum.

Cc: Maneesh Soni <maneesh@in.ibm.com>
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/symlink.c |    1 +
 1 file changed, 1 insertion(+)

b3229087c5e08589cea4f5040dab56f7dc11332a
--- linux-2.6.16.orig/fs/sysfs/symlink.c
+++ linux-2.6.16/fs/sysfs/symlink.c
@@ -66,6 +66,7 @@ static int sysfs_add_link(struct dentry 
 	if (!error)
 		return 0;
 
+	kobject_put(target);
 	kfree(sl->link_name);
 exit2:
 	kfree(sl);

--
