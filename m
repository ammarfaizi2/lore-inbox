Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760266AbWLFGn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760266AbWLFGn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760268AbWLFGn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:43:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35005 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760266AbWLFGn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:43:26 -0500
Date: Tue, 5 Dec 2006 22:43:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, val_henson@linux.intel.com,
       viro@zeniv.linux.org.uk
Subject: Re: + ocfs2-relative-atime-support-tweaks.patch added to -mm tree
Message-Id: <20061205224311.5dcfaf20.akpm@osdl.org>
In-Reply-To: <20061206062809.GD4497@ca-server1.us.oracle.com>
References: <200612060612.kB66CjNW025289@shell0.pdx.osdl.net>
	<20061206062809.GD4497@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 22:28:09 -0800
Mark Fasheh <mark.fasheh@oracle.com> wrote:

> >  	if (vfsmnt->mnt_flags & MNT_RELATIME) {
> > -		if ((timespec_compare(&inode->i_atime, &inode->i_mtime) < 0) ||
> > -		    (timespec_compare(&inode->i_atime, &inode->i_ctime) < 0))
> > +		if ((timespec_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
> > +		    (timespec_compare(&inode->i_atime, &inode->i_ctime) <= 0))
> >  			return 1;
> Hmm, should we fix up touch_atime() to use "<=" as well? Maybe I didn't read
> it correctly...

The logic I have there is the same (I hope)...

+			if (timespec_compare(&inode->i_mtime,
+						&inode->i_atime) < 0 &&
+			    timespec_compare(&inode->i_ctime,
+						&inode->i_atime) < 0)
+				return;

