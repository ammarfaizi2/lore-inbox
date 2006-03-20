Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWCTMwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWCTMwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWCTMwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:52:55 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:56714 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932269AbWCTMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:52:54 -0500
To: matthew@wil.cx
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20060320123950.GF8980@parisc-linux.org> (message from Matthew
	Wilcox on Mon, 20 Mar 2006 05:39:50 -0700)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org>
Message-Id: <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Mar 2006 13:52:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right.  Um.  I took it out back in March 2003 after enough people
> convinced me it wasn't worth trying to account for all the memory
> processes use, and the userbeans project would take care of it anyway.
> Haha.
> 
> It's hard to fix the accounting.  You have to deal with one thread
> allocating the lock, and then a different thread freeing it.  We never
> actually accounted for posix locks (which are the ones we really needed
> to!) and on occasion had current->locks go negative, with all kinds of
> associated badness.

Things look fairly straightforward if the accounting is done in
files_struct instead of task_struct.  At least for POSIX locks.  I
haven't looked at flocks or leases yet.

steal_locks() might cause problems, but that function should be gotten
rid of anyway.

Miklos
