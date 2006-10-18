Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945894AbWJRWaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945894AbWJRWaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423102AbWJRWaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:30:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423100AbWJRW35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:29:57 -0400
Date: Wed, 18 Oct 2006 15:29:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018152947.bb404481.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<453675A6.9080001@googlemail.com>
	<Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 23:44:03 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> [PATCH] VFS: fix i_mutex locking in page_symlink()
> 
> The inode->i_mutex should be held every time when calling i_size_write(), 
> and the function contains WARN_ON() for that condition. 
> page_symlink(), however, does not lock i_mutex. It is perfectly OK, as the 
> i_mutex for the directory is held at the time page_symlink() is running, 
> so noone is able to change i_size during race condition. However, 
> i_size_write() spits out the warning without this patch.
> 

I suspect it isn't necessary because the symlink's inode hasn't been wired
up into the directory tree yet and no other thread can find it and do
things to it.

