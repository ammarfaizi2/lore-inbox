Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbUKLXEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbUKLXEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbUKLXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:39060 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262655AbUKLXAk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:40 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <1100300406618@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:06 -0800
Message-Id: <11003004062835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2094, 2004/11/12 11:42:03-08:00, miltonm@bga.com

[PATCH] fix sysfs backing store error path confusion

On Nov 3, 2004, at 3:42 PM, Greg KH wrote:

|On Tue, Nov 02, 2004 at 10:03:34AM -0600, Maneesh Soni wrote:
||On Tue, Nov 02, 2004 at 02:46:58AM -0600, Milton Miller wrote:
|||sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
|||were expecting NULL.
||
||Thanks for spotting this. But as you said, I will prefer to change the callee.
||How about this patch?
..
||-		return -ENOMEM;
||+		return NULL;
|
|Actually, this needs to be a 0, not NULL, otherwise the compiler
|complains with a warning.  I've fixed it up and applied it.
|
|thanks,
|
|greg k-h

I wondered why greg thought the type was wrong.   After it was merged I
realized that the wrong function was changed.  Here's an attempt to fix
both errors.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-12 14:53:33 -08:00
+++ b/fs/sysfs/dir.c	2004-11-12 14:53:33 -08:00
@@ -38,7 +38,7 @@
 
 	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
 	if (!sd)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
@@ -56,7 +56,7 @@
 
 	sd = sysfs_new_dirent(parent_sd, element);
 	if (!sd)
-		return 0;
+		return -ENOMEMurn -ENOMEM;
 
 	sd->s_mode = mode;
 	sd->s_type = type;

