Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUFRUsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUFRUsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUFRUsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:48:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:50880 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262905AbUFRUpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:45:45 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20040618132628.45e1d364.akpm@osdl.org>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
	 <1087563810.8002.116.camel@watt.suse.com>
	 <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
	 <1087570031.8002.153.camel@watt.suse.com>
	 <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
	 <1087573303.8002.172.camel@watt.suse.com>
	 <20040618154330.GY12308@parcelfarce.linux.theplanet.co.uk>
	 <1087574752.8002.194.camel@watt.suse.com>
	 <20040618132628.45e1d364.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087591484.1512.14.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 16:44:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 16:26, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > Maybe the real bug is the FS inode should never have ended up in the
> > dirty list.
> 
> It'd be interesting to find out where and why it is being dirtied (atime?),
> but even if we can prevent that from happening, people can still do things
> like chmod on it, so we're back in the same situation.
> 
> There's tight coupling between writing back the inode and writing back its
> pages, and at times it has caused problems.  It's not clear _why_ there
> should be such a coupling but it's never been a sufficient problem to
> justify ripping it all up.
> 
> >  This should all work fine if the bdev inode were the only
> > one to ever hit a dirty list.
> 
> Something like this?

[ skip writing block-special inodes ]

Hmmm, any risk in missing data integrity syncs because of this?

-chris


