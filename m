Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVKWCPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVKWCPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVKWCPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:15:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:7049 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932391AbVKWCPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:15:48 -0500
Date: Wed, 23 Nov 2005 02:15:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
Message-ID: <20051123021545.GP27946@ftp.linux.org.uk>
References: <17283.52960.913712.454816@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17283.52960.913712.454816@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:07:28PM +1100, Neil Brown wrote:
> After putting in copious tracing printk, the offending test is:
> 
> 	if (user_nd.mnt->mnt_parent == user_nd.mnt)
> 		goto out2; /* not attached */
> 
> If I remove this, it works (or seems to).
> Presumably the initial root file system is 'not attached'.  But that
> shouldn't be a problem, should it?

Initial root is root and will remain root, period.

> Could this be related to the new shared mounts stuff???

No.  And no, it's not going to change - any memory you win on killing
initramfs is not going to be worth the extra code needed to special-case
it.

pivot_root() does work in chroot jail (including the one we get after
chrooting to "final" root), but that's all it does.
