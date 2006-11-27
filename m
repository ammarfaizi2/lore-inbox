Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756914AbWK0GX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbWK0GX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 01:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756916AbWK0GX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 01:23:58 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:17944 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756914AbWK0GX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 01:23:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=e0aXP+El+UW+C6rMJtTa6ZktZihPjjmPPSPlvIeNqhjji/6TBOmE6tZ+Vd91z/eYm24mpzwks4tL8IoTiJn09BDD6KdBBUwV1EMUHMkKxq7ap4mzn56mkLnkwsMEvnuhafyEl3/qu1s3WtQ+Qzl6pAjQYHpBPlPPtxyjI7J84Mc=
Date: Mon, 27 Nov 2006 15:16:48 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Subject: [PATCH] selinux: fix dentry_open() error check
Message-ID: <20061127061648.GA20065@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
	James Morris <jmorris@namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of dentry_open() shoud be checked by IS_ERR().

Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work-fault-inject/security/selinux/hooks.c
===================================================================
--- work-fault-inject.orig/security/selinux/hooks.c
+++ work-fault-inject/security/selinux/hooks.c
@@ -1760,7 +1760,8 @@ static inline void flush_unauthorized_fi
 						get_file(devnull);
 					} else {
 						devnull = dentry_open(dget(selinux_null), mntget(selinuxfs_mount), O_RDWR);
-						if (!devnull) {
+						if (IS_ERR(devnull)) {
+							devnull = NULL;
 							put_unused_fd(fd);
 							fput(file);
 							continue;
