Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUDBBXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUDBBXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:23:37 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:24988 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263507AbUDBBXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:23:34 -0500
Date: Fri, 2 Apr 2004 03:23:33 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 2/5
Message-ID: <20040402012333.GB13851@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075723.GD31818@MAIL.13thfloor.at> <20040318121650.GI31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318121650.GI31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:16:50PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Mar 15, 2004 at 08:57:23AM +0100, Herbert Poetzl wrote:
> > -void update_atime(struct inode *inode)
> > +void update_atime(struct inode *inode, struct vfsmount *mnt)
> 
> _Hell_, no.  Proper solution is to move the callers upstream instead
> of propagating vfsmounts downstream.  That, BTW, was the main reason
> for readdir() patch.

# 04/03/18	viro@parcelfarce.linux.theplanet.co.uk	1.1795.6.4
# [PATCH] add touch_atime() helper
# 
# Preparation for per-mountpoint noatime, nodiratime and later -
# per-mountpoint r/o.  Depends on file_accessed() patch, should go after
# it.
# 
# New helper - touch_atime(mnt, dentry).  It's a wrapper for
# update_atime() and that's where all future per-mountpoint checks will
# go.

static inline void touch_atime(struct vfsmount *mnt, struct dentry *dentry)
{
        /* per-mountpoint checks will go here */
        update_atime(dentry->d_inode);
}

Hum, so that is what you call 'moving the callers upstream'
instead of 'propagating vfsmounts downstream' ...

best,
Herbert

> BTW, update_atime() is exported.  And it's 2.6 now...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
