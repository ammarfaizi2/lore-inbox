Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbULBHA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbULBHA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULBHA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:00:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50084 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261564AbULBHAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:00:23 -0500
Date: Thu, 2 Dec 2004 07:00:22 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: maneesh@in.ibm.com, akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch?] Teach sysfs_get_name not to use a dentry
Message-ID: <20041202070022.GD26051@parcelfarce.linux.theplanet.co.uk>
References: <200412020641.iB26f8W26315@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412020641.iB26f8W26315@adam.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 10:41:08PM -0800, Adam J. Richter wrote:
> Hi Maneesh,
> 
> 	The following patch changes syfs_getname to avoid using
> sysfs_dirent->s_dentry for getting the names of directories (as
> this pointer may be NULL in a future version where sysfs would
> be able to release the inode and dentry for each sysfs directory).
> It does so by defining different sysfs_dirent.s_type values depending
> on whether the diretory represents a kobject or an attribute_group.
> 
> 	This patch is ground work for unpinning the struct inode
> and struct dentry used by each sysfs directory.  The patch also may
> facilitate eliminating the sysfs_dentry for each member of an
> attribute group.  The patch has no benefits by itself, but I'm posting
> it now separately in the hopes of making it easier for people
> to spot problems, and, also, because if it is integrated, I think
> it will make the rest of the change to unpin directories (which
> I have not yet written) easier to understand.

Vetoed until you show an acceptable locking scheme for the latter.
I do not believe that it's feasible; feel free to prove me wrong,
but until then you'll have to carry the patchset on your own.
