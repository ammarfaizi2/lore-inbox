Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVJFRtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVJFRtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJFRtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:49:12 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:16647 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751264AbVJFRtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:49:11 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128620196.16534.20.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Thu, 06 Oct 2005 13:36:36 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <1128618447.8396.39.camel@lade.trondhjem.org>
	 <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu> <1128620196.16534.20.camel@lade.trondhjem.org>
Message-Id: <E1ENZqC-0003Rd-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 19:47:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > No, but what value does an extra function call add then when you already
> > > have lookup intents?
> > 
> > Just to provide a proper interface, and not have to extend open
> > intents further.
> 
> Why do you consider an extra function call to be a more "proper
> interface"?
> 
> Does it fix more races? Does it allow you to do new things more
> elegantly? Does it offer a better abstraction?

Extending the open intent with 'struct file *' in itself is pretty
lame.  How do you initilaize intent.open.file from within ->lookup and
->create?  Do you call dentry_open(), that doesn't cut it with the
reorganized filp_open() thing.  And anyway it would be rather ugly
that it would recurse into the filesystems ->open() method.

See the problems I have with the intent.open.file thing?

> Just trying to understand why you are trying to dump an interface that
> has been agreed upon for several years and replace it with one that was
> rejected.
> 
> > Earlier you said, that intents are meant to be optional, so this
> > atomicity requirement is getting further from the "intent" concept.
> 
> No it is not. It is bang right in the middle of the intent concept.
> 
> Intents are there in order to allow the filesystem to determine which
> operation is calling lookup so that it can optimise for that particular
> operation.
> If your filesystem is able to do lookup+create+open more efficiently
> than the VFS can, then that is what it is designed to allow you to do.

Yes, the problem is trying to fit too many things into this intent
thing.

But if you post a patch, that implements an equivalent (or wider)
interface to the open_create() method, only with intents, and it
doesn't get too convoluted, it's OK by me.

I tried to do that, but the ->open_create() interface just seemed
cleaner.

Miklos
