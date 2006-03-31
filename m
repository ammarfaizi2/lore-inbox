Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWCaTZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWCaTZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCaTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:25:49 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:5033 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751436AbWCaTZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:25:48 -0500
To: trond.myklebust@fys.uio.no
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <1143829641.8085.7.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 31 Mar 2006 13:27:21 -0500)
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu> <1143829641.8085.7.camel@lade.trondhjem.org>
Message-Id: <E1FPPFC-0005mL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 21:25:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NACK.
> 
> This changes the behaviour of F_UNLCK. Currently, if the allocation
> fails, the inode locking state remains unchanged. With your change, an
> unlock request may end up unlocking part of the inode, but not the rest.

No, look more closer.  There are two cases:

  - some locks are partially or completely removed

  - the unlock splits an existing lock in two.

In the first case no new locks are needed.  In the second, no locks
are modified prior to the check.

Miklos
