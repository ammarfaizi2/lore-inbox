Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVASWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVASWIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVASWHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:07:42 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:36003 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261923AbVASV7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:59:06 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050119214519.GG26051@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Wed, 19 Jan 2005 21:45:19 +0000)
Subject: Re: [PATCH] Can't unmount bad inode
References: <E1CrNFz-0001JF-00@dorka.pomaz.szeredi.hu> <20050119214519.GG26051@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1CrNqa-0001Nq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Jan 2005 22:58:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch fixes a problem when a inode which is the root of a mount
> > becomes bad (make_bad_inode()).  In this case follow_link will return
> > -EIO, so the name resolution fails, and umount won't work.  The
> > solution is just to remove the follow_link method from bad_inode_ops.
> > Any filesystem operation (other than unmount) will still fail, since
> > every other method returns -EIO.
> 
> I'm not all that sure that we want to follow symlinks in the last
> pathname component upon umount, actually...

That could break existing usage, couldn't it?  The damage wouldn't be
too bad I guess, but still it would be a bigger change, than fixing
bad_inode.

Miklos

