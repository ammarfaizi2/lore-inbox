Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUHCNDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUHCNDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUHCNDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:03:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266117AbUHCND3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:03:29 -0400
Date: Tue, 3 Aug 2004 14:02:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] Stop pinning dentries & inodes for leaves
Message-ID: <20040803130256.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com> <20040729204031.GE4592@in.ibm.com> <20040729204359.GF4592@in.ibm.com> <20040729204449.GG4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729204449.GG4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:44:49PM -0500, Maneesh Soni wrote:
> 
> 
> 
> o This patch stops the pinning of non-directory or leaf dentries and inodes. 
>   The leaf dentries and inodes are created during lookup based on the
>   entries on sysfs_dirent tree. These leaves are removed from the dcache
>   through the VFS dentry ageing process during shrink dcache operations. Thus
>   reducing about 80% of sysfs lowmem needs.
> 
> o This implments the ->lookup() for sysfs directory inodes and allocates
>   dentry and inode if the lookup is successful and avoids the need of 
>   allocating and pinning of dentry and inodes during the creation of 
>   corresponding sysfs leaf entry. As of now the implementation has not 
>   required negative dentry creation on failed lookup. As sysfs is still a
>   RAM based filesystem, negative dentries are not of any use IMO.
> 
> o The leaf dentry allocated after successful lookup is connected to the 
>   existing corresponding sysfs_dirent through the d_fsdata field. This 
>   increments the ref count of sysfs_dirent. The ref count is released through 
>   ->d_iput() dentry_operation when dentry dies.

ACK; there's some reordering that might make sense here, but that depends on
what will fall out of changes in previous chunks.
