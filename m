Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWD1TqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWD1TqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWD1TqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:46:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751119AbWD1TqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:46:24 -0400
Date: Fri, 28 Apr 2006 12:44:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-Id: <20060428124416.6215714e.akpm@osdl.org>
In-Reply-To: <OF41D6EA13.CE34B289-ON4225715E.00501AB1-4225715E.0060B9BD@de.ibm.com>
References: <20060428025621.2c7577a0.akpm@osdl.org>
	<OF41D6EA13.CE34B289-ON4225715E.00501AB1-4225715E.0060B9BD@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Holzheu <HOLZHEU@de.ibm.com> wrote:
>
> > > +   if (filp->f_mode & FMODE_WRITE) {
>  > > +      if (!(inode->i_mode & S_IWUGO))
>  > > +         return -EACCES;
>  > > +   }
>  > > +   if (filp->f_mode & FMODE_READ) {
>  > > +      if (!(inode->i_mode & S_IRUGO))
>  > > +         return -EACCES;
>  > > +   }
>  >
>  > Is the standard VFS permission checking not appropriate?
>  >
>  > (A comment should be added here).
> 
>  You mean using .permission in the inode operations
>  and using the generic_permission() function?
> 
>  Currently I do not have own inode operations (and
>  I don't want to have them ...)

The VFS-level open() code implements standard permission-checking so I
_think_ you don't need to do anything in here.  See how ramfs does it.

ramfs does have an inode_operations, for ->getattr() support.  So it can
return a correct number in stat->blocks.

sysfs implements inode_operations, so it can do stuff in ->setattr().

I don't think hypfs needs either of those, so you still shouldn't need a
file_inode_operations.

