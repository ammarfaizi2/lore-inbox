Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVETJTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVETJTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVETJTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:19:44 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:8456 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261392AbVETJTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:19:41 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: akpm@osdl.org, linuxram@us.ibm.com, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050520091129.GL29811@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Fri, 20 May 2005 10:11:29 +0100)
Subject: Re: [PATCH] namespace.c: fix race in mark_mounts_for_expiry()
References: <E1DZ34O-0003RL-00@dorka.pomaz.szeredi.hu> <20050520091129.GL29811@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DZ3ec-0003Uq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 11:18:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch fixes a race found by Ram in mark_mounts_for_expiry() in
> > The solution is to make the atomic_read() and the get_namespace() into
> > a single atomic operation.  The patch does this in a fairly ugly way
> > (see comment above fix), which should be safe regardless.
> 
> That it certainly is.  What's more, there is a trivial way to deal with
> that crap - have put_namespace() do atomic_dec_and_lock() instead of
> atomic_dec_and_test().  And use the same spinlock (vfsmount_lock would be
> an obvious choice) to protect the atomicity here.  End of story.

Right.

Question is, why did nobody think of that before :)

Thanks,
Miklos
