Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUABBiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUABBiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:38:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:25487 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262164AbUABBiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:38:06 -0500
Date: Thu, 1 Jan 2004 17:32:38 -0800
From: Greg KH <greg@kroah.com>
To: "Eduard <master^shadow> Roccatello" 
	<lilo.please.no.spam@roccatello.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference
Message-ID: <20040102013238.GC19598@kroah.com>
References: <200401011944.51109.lilo.please.no.spam@roccatello.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401011944.51109.lilo.please.no.spam@roccatello.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 07:44:50PM +0100, Eduard <master^shadow> Roccatello wrote:
> Hi there,
> 
> i got an oops on USB mouse disconnect. i have tried to reproduce the oops 
> but it happened only once. I'm running 2.6.0 vanilla with nvidia binary 
> drivers but they not seems to be involved in the oops (imho).
> USB modules i use are: hid, hcd-ohci, hcd-ehci

There is a patch in the -mm tree to fix this.  I've included it here
below.

thanks,

greg k-h


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	Mon Dec 22 16:02:07 2003
+++ b/fs/sysfs/dir.c	Mon Dec 22 16:02:07 2003
@@ -83,7 +83,8 @@
 	struct dentry * parent = dget(d->d_parent);
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
-	simple_rmdir(parent->d_inode,d);
+	if (d->d_inode)
+		simple_rmdir(parent->d_inode,d);
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
