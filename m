Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTE1FG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTE1FG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:06:56 -0400
Received: from opus.cs.columbia.edu ([128.59.20.100]:63437 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S264509AbTE1FGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:06:52 -0400
Subject: permission() operating on inode instead of dentry?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054099180.6942.71.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 01:19:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc: responses to me, have 10k message backlog in l-k folder)

Is there a good reason why the fs permission function operates on the
inode instead of the dentry? It would seem if the dentry was passed into
the function instead of the inode, one would have a better structure to
play with, such as being able to use d_put() to get the real path name. 
The inode is still readily accessible from the dentry.

in fact that std case seems to be (from sys_truncate)

pathwalk to get nameidata, this gives us dentry, this gives us inode,
test permissions on inode.

If permission took the dentry, I could easily extend it to have an out
of filesystem permission scheme that worked on a file's path without
serious surgery on the kernel (think SubDomain) as well as being very
low overhead (just d_put() the path  inside the perm function and go
from there)

anyways, just wondering if there's a reason I'm not thinking of for why
it needs to operate on the inode directly, and if I'm not missing
anything if there's any chance that a patch would be accepted to make it
operate on the dentry instead?

thanks,

shaya

