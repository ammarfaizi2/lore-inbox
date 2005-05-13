Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVEMJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVEMJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVEMJ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 05:26:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:59862 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262306AbVEMJ0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 05:26:02 -0400
Subject: Re: [PATCH] sync_sb_inodes cleanup
From: Vladimir Saveliev <vs@namesys.com>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <1115833764.6810.32.camel@betsy>
References: <1115737238.4456.320.camel@tribesman.namesys.com>
	 <1115739301.6810.15.camel@betsy>
	 <1115797036.29007.359.camel@tribesman.namesys.com>
	 <1115833764.6810.32.camel@betsy>
Content-Type: text/plain
Message-Id: <1115976353.3973.91.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 13 May 2005 13:25:53 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2005-05-11 at 21:49, Robert Love wrote:
> On Wed, 2005-05-11 at 11:37 +0400, Vladimir Saveliev wrote:
> 
> > I did not want to un-const start. It would be required for the
> > assignment move, wouldn't it?
> 
> Well, the const is just a programming convention.  It is useful here,
> but just a convention; removing it changes nothing behavior-wise.  Your
> patch, though, changes behavior.
> 
ok, I will move assignment.

> How bad do you need to push the spin locks into the function?
> 

The reason is that reiser4 implements its own sync_inodes method of
struct super_operations. reiser4_sync_inodes first calls
generic_sync_sb_inodes and then calls reiser4' function to flush atoms
to disk. If generic_sync_sb_inodes would exit with inode_lock locked,
reiser4_sync_inodes would have to unlock inode_lock after
generic_sync_sb_inodes and lock it before exit. inode_lock is static for
fs/inode.c, so, we asked whether it would be possible to have
spinlocking in generic_sync_sb_inodes.


