Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUHCMyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUHCMyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHCMyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:54:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266200AbUHCMyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:54:31 -0400
Date: Tue, 3 Aug 2004 13:52:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] Free sysfs_dirent on file removal
Message-ID: <20040803125231.GU12308@parcelfarce.linux.theplanet.co.uk>
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com> <20040729204031.GE4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729204031.GE4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:40:31PM -0500, Maneesh Soni wrote:
> 
> 
> o The following patch implements the code to free up the sysfs_dirents upon
>   directory or file removal. It uses the sysfs_dirent based tree in order
>   to remove the directory contents before removing the directory itself.
>   It could do this without taking dcache_lock in sysfs_remove_dir() as
>   it doesnot use dentry based tree.

ACK, but some of that (freeing sysfs_dirent upon removal, no smarts, just
enough to plug the leak) belongs in the first chunk.

Note that there we shouldn't care about refcounts - that stuff belongs here.
