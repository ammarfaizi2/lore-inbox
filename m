Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWJQNn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWJQNn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWJQNn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:43:26 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:45189 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1750959AbWJQNnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:43:25 -0400
To: ncmike@ncultra.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20061017125350.GA22327@silverwood.ncultra.org> (message from
	Mike Day on Tue, 17 Oct 2006 08:53:50 -0400)
Subject: Re: fuse: fix hang on SMP
References: <20061016162709.369579000@szeredi.hu> <20061016162729.176738000@szeredi.hu> <20061016165125.4605824b.akpm@osdl.org> <20061017125350.GA22327@silverwood.ncultra.org>
Message-Id: <E1GZpDl-000134-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Oct 2006 15:43:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 16/10/06 16:51 -0700, Andrew Morton wrote:
> >On Mon, 16 Oct 2006 18:27:10 +0200
> >Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> >> Fuse didn't always call i_size_write() with i_mutex held which caused
> >> rare hangs on SMP/32bit.
> >
> >Yes, that is a bit of a trap.  I'll maintain a patch in -mm which spits a
> >warning if i_size_write() is called without i_mutex held.
> >
> 
> >+void i_size_write(struct inode *inode, loff_t i_size)
> >+{
> >+	WARN_ON_ONCE(!mutex_is_locked(&inode->i_mutex));
> 
> 
> Miklos' patch would generate this warning because he uses the spinlock
> inside struct fuse_conn to synchronize the write:

Yes, this will cause a false alarm for FUSE, but it may still be
useful to find similar bugs in other filesystems.

Miklos
