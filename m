Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVJFREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJFREp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVJFREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:04:45 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:35084 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751143AbVJFREp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:04:45 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128616864.8396.32.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Thu, 06 Oct 2005 12:41:04 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu> <1128616864.8396.32.camel@lade.trondhjem.org>
Message-Id: <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 19:02:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason why we do it as a lookup intent is because this has to be
> atomic lookup+create+open in order to be at all useful to NFS.
> 
> Just doing create+open atomically is worthless since it leaves you with
> a bunch of races where someone on the server can create, say, a symlink
> between the RPC call to lookup and the RPC call that creates the file.

That's easy to solve: filesystem returns -EAGAIN, namei_open() redoes
the lookup and continues with the resolving.  There would have to be
some safeguard counter to avoid infinite loops.

Filesystem could even populate the dentry with the symlink in
->open_create() to optimize away the relookup.

Do you see a problem with that?

Miklos
