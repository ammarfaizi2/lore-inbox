Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423001AbWJFXU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423001AbWJFXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWJFXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:20:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423001AbWJFXUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:20:55 -0400
Date: Fri, 6 Oct 2006 16:20:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Dickson <SteveD@redhat.com>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
Message-Id: <20061006162032.9192ae1b.akpm@osdl.org>
In-Reply-To: <4526E229.2020707@RedHat.com>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	<4526CF6F.9040006@RedHat.com>
	<1160172990.12253.14.camel@lade.trondhjem.org>
	<1160173167.12253.17.camel@lade.trondhjem.org>
	<20061006154058.4190075f.akpm@osdl.org>
	<4526E229.2020707@RedHat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 19:09:29 -0400
Steve Dickson <SteveD@redhat.com> wrote:

> > Well, it wasn't attached, but I can simulate it.
> > 
> > invalidate_complete_page() wants to be called from inside spinlocks by
> > drop_pagecache(), so if we wanted to pull the same trick there we'd need to
> > pass a new flag into invalidate_inode_pages().
> That seems abit broken (wrt performance) that drop_pagecache_sb() holds
> the fairly popular inode_lock while it invalidate pages...
> Nobody else seem to...

Yes, it was very rude of me.  But it's just a debugging thing, and is
privileged.

I removed a cond_resched() from in there in the process.  If we make the
invalidate_inode_pages() caller pass in a must_be_atomic flag then the
cond_resched() can be resuscitated.

