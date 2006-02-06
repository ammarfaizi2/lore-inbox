Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWBFUbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWBFUbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWBFU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:25021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964790AbWBFU3e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:34 -0500
Cc: 76306.1226@compuserve.com
Subject: [PATCH] kobject: don't oops on null kobject.name
In-Reply-To: <1139257757388@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:17 -0800
Message-Id: <11392577571177@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kobject: don't oops on null kobject.name

kobject_get_path() will oops if one of the component names is
NULL.  Fix that by returning NULL instead of oopsing.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b365b3daf2a9e2a8b002ea9fef877af1c71513fd
tree dcd673d830b61ee37ab433af60c0f81ffaa86779
parent c171fef5c8566cf5f57877e7832fa696ecdf5228
author Chuck Ebbert <76306.1226@compuserve.com> Thu, 12 Jan 2006 20:02:00 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 lib/kobject.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index fe4ae36..efe67fa 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -72,6 +72,8 @@ static int get_kobj_path_length(struct k
 	 * Add 1 to strlen for leading '/' of each level.
 	 */
 	do {
+		if (kobject_name(parent) == NULL)
+			return 0;
 		length += strlen(kobject_name(parent)) + 1;
 		parent = parent->parent;
 	} while (parent);
@@ -107,6 +109,8 @@ char *kobject_get_path(struct kobject *k
 	int len;
 
 	len = get_kobj_path_length(kobj);
+	if (len == 0)
+		return NULL;
 	path = kmalloc(len, gfp_mask);
 	if (!path)
 		return NULL;

