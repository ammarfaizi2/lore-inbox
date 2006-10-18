Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945900AbWJRWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945900AbWJRWlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945901AbWJRWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:41:49 -0400
Received: from twin.jikos.cz ([213.151.79.26]:54476 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1945900AbWJRWls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:41:48 -0400
Date: Thu, 19 Oct 2006 00:41:40 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
In-Reply-To: <20061018152947.bb404481.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610190031260.29022@twin.jikos.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org> <453675A6.9080001@googlemail.com>
 <Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz> <20061018152947.bb404481.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Andrew Morton wrote:

> > The inode->i_mutex should be held every time when calling 
> > i_size_write(), and the function contains WARN_ON() for that 
> > condition. page_symlink(), however, does not lock i_mutex. It is 
> > perfectly OK, as the i_mutex for the directory is held at the time 
> > page_symlink() is running, so noone is able to change i_size during 
> > race condition. However, i_size_write() spits out the warning without 
> > this patch.
> I suspect it isn't necessary because the symlink's inode hasn't been wired
> up into the directory tree yet and no other thread can find it and do
> things to it.

I completely agree (see my comments to the patch in previous mail). 
However, the warning emitted by i_size_write() should really go away. I 
can see the following possibilities:

- lock the i_mutex, even though it's for sure not necessary. Not nice.
- remove the warning from i_size_write(). Not nice either, we want to be 
warned about other calls that are not correct
- make the warning in i_size_write() conditional on inode->i_dentry not 
being NULL (?)

Thanks,

-- 
Jiri Kosina
