Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264786AbUDWMLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbUDWMLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264787AbUDWMLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:11:55 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:58125 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264786AbUDWMLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:11:54 -0400
Date: Fri, 23 Apr 2004 13:11:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm1
Message-ID: <20040423131149.B1218@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, raven@themaw.net,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040421014544.37942eb4.akpm@osdl.org> <Pine.LNX.4.58.0404222321310.6767@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404222321310.6767@donald.themaw.net>; from raven@themaw.net on Thu, Apr 22, 2004 at 11:32:39PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 11:32:39PM +0800, raven@themaw.net wrote:
> +static int __may_umount_tree(struct vfsmount *mnt, int root_mnt_only)
> +{
> +	struct list_head *next;
> +	struct vfsmount *this_parent = mnt;
> +	int actual_refs;
> +	int minimum_refs;
> +
> +	spin_lock(&vfsmount_lock);
> +	actual_refs = atomic_read(&mnt->mnt_count);
> +	minimum_refs = 2;
> +
> +	if (root_mnt_only) {
> + 		spin_unlock(&vfsmount_lock);
> +		if (actual_refs > minimum_refs)
> +			return -EBUSY;
> +		return 0;

Sorry for changing my opionin, but I somehow thought autofs3 could make
more use of this function.  it it's really just a single atomic_read that's
shared it doesn't really make a lot of sense, does it?

