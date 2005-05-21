Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVEUNNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVEUNNe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 09:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVEUNNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 09:13:34 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:19462 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261736AbVEUNN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 09:13:28 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116670073.4397.77.camel@localhost> (message from Ram on Sat, 21
	May 2005 03:07:53 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu> <1116670073.4397.77.camel@localhost>
Message-Id: <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 15:12:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. look at the enclosed patch. Does it look any better? The special
> casing for detached mounts ate up some brain cells and made the code
> less simpler.

Yes, this isn't trivial stuff.

I realized one more thing: nd->mnt (the destination vfsmount) might be
detached while waiting for the semaphore.  So that needs to be
rechecked after taking the semaphores.

And the same for old_nd->mnt in case of rbind.  Though I'm
not sure what the semantics should be in this case:

  1) rbind always fails if the source is detached

  2) rbind always succeeds, and if the source is detached it just
     copies that single mount

I like 2) better.  Is there anything against it?

Miklos
