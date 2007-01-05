Return-Path: <linux-kernel-owner+w=401wt.eu-S1161055AbXAEK7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbXAEK7U (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbXAEK7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:59:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:20293 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161055AbXAEK7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:59:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MDBhWqHxu1DsGuUunuePmrl17ULbBkL8mWnfUWxRZuKo9dBrzAqTOgnPAnpgvAON5Mh2P1WMGsMNPtTrd+pcmt810EKIrSx1lsxvN6gcy8OLTKzZyOubKuOxcYz7kZTJdsCcpGNLJ+u98kCPzJRjdUNc9qdJOtGjAoetTAkTtcI=
Date: Fri, 5 Jan 2007 10:57:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Greg KH <greg@kroah.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.name>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc2-mm1: INFO: possible recursive locking detected in con_close
Message-ID: <20070105105718.GD17863@slug>
References: <20061228024237.375a482f.akpm@osdl.org> <45943638.30705@free.fr> <20061229110041.GA1441@slug> <20070105011004.GA7682@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105011004.GA7682@kroah.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 05:10:05PM -0800, Greg KH wrote:
> On Fri, Dec 29, 2006 at 11:00:41AM +0000, Frederik Deweerdt wrote:
> > On Thu, Dec 28, 2006 at 10:25:12PM +0100, Laurent Riffard wrote:
> > > Le 28.12.2006 11:42, Andrew Morton a ?crit :
> > > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/
> > > 
> > > Hello,
> > > 
> > > got this with 2.6.20-rc2-mm1, reverting 
> > > gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch made it disappear.
> > > 
> > Hi, 
> > 
> > This is due to sysfs_hash_and_remove() holding dir->d_inode->i_mutex
> > before calling sysfs_drop_dentry() which calls orphan_all_buffers()
> > which in turn takes node->i_mutex.
> > The following patch solves the problem by defering the buffers orphaning
> > after the dir->d_inode->imutex is released. Not sure it's the best
> > solution though, Greg?
> > 
> > Regards,
> > Frederik
> > 
> > Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
> 
> Maneesh and Oliver, any objections to this patch?
> 
Actually, there's a problem with the patch: inode is not initialized in 
sysfs_hash_and_remove, I'll repost a patch against 2.6.20-rc3-mm1.

Regards,
Frederik
