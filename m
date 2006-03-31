Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWCaTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWCaTqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWCaTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:46:23 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:10631 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932248AbWCaTqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:46:22 -0500
To: trond.myklebust@fys.uio.no
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <1143834022.8116.1.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 31 Mar 2006 14:40:22 -0500)
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
	 <1143829641.8085.7.camel@lade.trondhjem.org>
	 <E1FPPFC-0005mL-00@dorka.pomaz.szeredi.hu> <1143834022.8116.1.camel@lade.trondhjem.org>
Message-Id: <E1FPPZK-0005qJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 21:46:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the first case no new locks are needed.  In the second, no locks
> > are modified prior to the check.
> 
> Consider something like
> 
> fcntl(SETLK, 0, 100)
> fcntl(SETLK, 0, 100)
> fcntl(SETLK, 0, 100)

Huh?  What is the type of lock in each case.

But anyway your example is no good.  If the new lock completely covers
the previous one, then the old lock will simply be adjusted and no new
lock is inserted.

Miklos
