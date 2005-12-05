Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVLEOea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVLEOea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVLEOea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:34:30 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:47268 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751374AbVLEOe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:34:29 -0500
Subject: [patch 1/2] selinux:  ARRAY_SIZE cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Tobias Klauser <tklauser@nuerscht.ch>, Nicolas Kaiser <nikai@nikai.net>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 05 Dec 2005 09:40:42 -0500
Message-Id: <1133793642.20862.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Kaiser <nikai@nikai.net>

Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]).

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.15-rc5-mm1/security/selinux/selinuxfs.c a/security/selinux/selinuxfs.c
--- linux-2.6.15-rc5-mm1/security/selinux/selinuxfs.c	2005-12-05 09:07:04.000000000 -0500
+++ a/security/selinux/selinuxfs.c	2005-12-05 09:10:23.000000000 -0500
@@ -376,7 +376,7 @@ static ssize_t selinux_transaction_write
 	char *data;
 	ssize_t rv;
 
-	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino])
+	if (ino >= ARRAY_SIZE(write_op) || !write_op[ino])
 		return -EINVAL;
 
 	data = simple_transaction_get(file, buf, size);
@@ -1161,7 +1161,7 @@ static int sel_make_avc_files(struct den
 #endif
 	};
 
-	for (i = 0; i < sizeof (files) / sizeof (files[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 

-- 
Stephen Smalley
National Security Agency

