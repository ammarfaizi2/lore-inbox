Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTLPDAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTLPDAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:00:02 -0500
Received: from [24.35.117.106] ([24.35.117.106]:50819 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264305AbTLPC77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 21:59:59 -0500
Date: Mon, 15 Dec 2003 21:59:58 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Is Rational rational?
Message-ID: <Pine.LNX.4.58.0312152105550.5094@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the enclosed patch to fs/namei.c make sense?

IBM/Rational Software is advocating use of the following patch to deal 
with a situation where users of Clearcase are having difficulties deleting 
sockets, devices, and named pipes when using the mvfs file system.  The 
problem reportedly arises from populating a shadow filesystem with the 
contents of the system root and the handling of sockets, devices and named 
pipes.  The full text of the problem report response can be accessed by 
going to:

http://www.ibm.com/software/rational/support/

and entering 1154790 in the search box.


--- /usr/src/linux/fs/namei.c Tue Oct 30 10:03:52 2001
+++ /usr/src/linux-patched/namei.c Fri Jun 20 05:12:16 2003
@@ -907,7 +907,7 @@
static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
{
int error;
- if (!victim->d_inode || victim->d_parent->d_inode != dir)
+ if (!victim->d_inode)
return -ENOENT;
error = permission(dir,MAY_WRITE | MAY_EXEC);
if (error)

I'm not really competent to evaluate this proposesd patch, but it 
certainly makes me nervous.  Their comment on this also bothers me: 
"Rational Software believes that the check that is removed by this patch
is one that should never fail for any properly operating filesystem. "
