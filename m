Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHaCkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHaCkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHaCkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 22:40:09 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:47262 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S266293AbUHaCkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 22:40:06 -0400
Subject: MAX_NESTED_LINKS
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093920028.2445.2.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 30 Aug 2004 21:40:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_NESTED_LINKS seems to have been set to 5, but the comment in
fs/namei.c indicates a larger number.  Is that intentional?

* This limits recursive symlink follows to 8, while
* limiting consecutive symlinks to 40.
@@ -405,19 +407,30 @@
static inline int do_follow_link(struct dentry *dentry, struct nameidata
*nd)
{
int err = -ELOOP;
if (current->link_count >= MAX_NESTED_LINKS)
	goto loop;
if (current->total_link_count >= 40)
	goto loop;
BUG_ON(nd->depth >= MAX_NESTED_LINKS);

