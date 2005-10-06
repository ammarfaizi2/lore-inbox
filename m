Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVJFRxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJFRxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVJFRxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:53:07 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:13072 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750716AbVJFRxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:53:05 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128620528.16534.26.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Thu, 06 Oct 2005 13:42:07 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu> <1128620528.16534.26.camel@lade.trondhjem.org>
Message-Id: <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 19:51:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Say you have NFS mount on /mnt and a bind mount over the regular file
> > /mnt/foo.  You do open("/mnt/foo", O_RDWR | O_CREAT, 0644).  How do
> > you solve the atomic open case.
> 
> > If you open in ->lookup("foo") you will be opening the wrong file,
> > unless you want to follow mounts inside ->lookup.
> 
> Firstly, if that is the case, then you will have dentries for both the
> covered and the covering copies of /mnt/foo. A simple test of
> have_submounts() on the dentry will suffice to tell the filesystem.
> whether or not it should open the file.

And if the bind is umounted after NFS determined not to open the file,
and at the same time it changes to a symlink on the server (not very
likely I agree, but possible nonetheless), then shit happens.

> Secondly, Linux doesn't actually allow bind mounts on top of regular
> files.

It does.  Try it.

Miklos

