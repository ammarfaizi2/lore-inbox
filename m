Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVASVtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVASVtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVASVsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:48:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27040 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261919AbVASVpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:45:21 -0500
Date: Wed, 19 Jan 2005 21:45:19 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Can't unmount bad inode
Message-ID: <20050119214519.GG26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CrNFz-0001JF-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CrNFz-0001JF-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 10:20:51PM +0100, Miklos Szeredi wrote:
> Andrew,
> 
> This patch fixes a problem when a inode which is the root of a mount
> becomes bad (make_bad_inode()).  In this case follow_link will return
> -EIO, so the name resolution fails, and umount won't work.  The
> solution is just to remove the follow_link method from bad_inode_ops.
> Any filesystem operation (other than unmount) will still fail, since
> every other method returns -EIO.

I'm not all that sure that we want to follow symlinks in the last
pathname component upon umount, actually...
