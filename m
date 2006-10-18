Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423113AbWJRWqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423113AbWJRWqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423110AbWJRWqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:46:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3293 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423113AbWJRWqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:46:49 -0400
Date: Wed, 18 Oct 2006 15:46:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018154636.2317059a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610190031260.29022@twin.jikos.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<453675A6.9080001@googlemail.com>
	<Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz>
	<20061018152947.bb404481.akpm@osdl.org>
	<Pine.LNX.4.64.0610190031260.29022@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 00:41:40 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> On Wed, 18 Oct 2006, Andrew Morton wrote:
> 
> > > The inode->i_mutex should be held every time when calling 
> > > i_size_write(), and the function contains WARN_ON() for that 
> > > condition. page_symlink(), however, does not lock i_mutex. It is 
> > > perfectly OK, as the i_mutex for the directory is held at the time 
> > > page_symlink() is running, so noone is able to change i_size during 
> > > race condition. However, i_size_write() spits out the warning without 
> > > this patch.
> > I suspect it isn't necessary because the symlink's inode hasn't been wired
> > up into the directory tree yet and no other thread can find it and do
> > things to it.
> 
> I completely agree (see my comments to the patch in previous mail). 
> However, the warning emitted by i_size_write() should really go away. I 
> can see the following possibilities:
> 
> - lock the i_mutex, even though it's for sure not necessary. Not nice.
> - remove the warning from i_size_write(). Not nice either, we want to be 
> warned about other calls that are not correct
> - make the warning in i_size_write() conditional on inode->i_dentry not 
> being NULL (?)
> 

I simply dropped the debugging patch.  Which is pretty sad, because it _is_ a
really nasty and subtle-to-show bug.  So I'd be OK with adding sufficient
patches to -mm to make the false positives go away so we can re-add the
check.

