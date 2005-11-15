Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVKOMiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVKOMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVKOMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:38:09 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:47122 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932436AbVKOMiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:38:08 -0500
To: neilb@suse.de
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
In-reply-to: <1051115020002.9459@suse.de> (message from NeilBrown on Tue, 15
	Nov 2005 13:00:02 +1100)
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
References: <20051115125657.9403.patches@notabene> <1051115020002.9459@suse.de>
Message-Id: <E1Ebxp3-0003me-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Nov 2005 11:13:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Finally, if vmtruncate succeeds, and ATTR_SIZE is the only change
> requested, we now fall-through and mark_inode_dirty.  If a filesystem
> did not have a ->truncate function, then vmtruncate will have changed
> i_size, without marking the inode as 'dirty', and I think this is wrong.

And if filesystem does not have a ->truncate() function and it caller
was [f]truncate(), ctime and mtime won't be set.

That's wrong too, isn't it?

Miklos
