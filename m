Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754803AbWKIJcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbWKIJcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbWKIJcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:32:45 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:1739 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754803AbWKIJco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:32:44 -0500
Date: Thu, 9 Nov 2006 12:29:45 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take24 3/6] kevent: poll/select() notifications.
Message-ID: <20061109092945.GA11382@2ka.mipt.ru>
References: <11630606373650@2ka.mipt.ru> <200611091008.45227.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200611091008.45227.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 09 Nov 2006 12:29:49 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:08:44AM +0100, Eric Dumazet (dada1@cosmosbay.com) wrote:
> Here you test both KEVENT_SOCKET and KEVENT_PIPE
> 
> > +#if defined CONFIG_KEVENT_SOCKET || defined CONFIG_KEVENT_PIPE
> > +		kevent_storage_init(inode, &inode->st);
> > +#endif
> >  	}
> >  	return inode;
> >  }
> >
> >  void destroy_inode(struct inode *inode)
> >  {
> 
> but here you test only KEVENT_SOCKET
> 
> > +#if defined CONFIG_KEVENT_SOCKET
> > +	kevent_storage_fini(&inode->st);
> > +#endif

Indeed, it must be 
#if defined CONFIG_KEVENT_SOCKET || defined CONFIG_KEVENT_PIPE

> >  	BUG_ON(inode_has_buffers(inode));
> >  	security_inode_free(inode);
> >  	if (inode->i_sb->s_op->destroy_inode)
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 5baf3a1..c529723 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -276,6 +276,7 @@ #include <linux/prio_tree.h>
> >  #include <linux/init.h>
> >  #include <linux/sched.h>
> >  #include <linux/mutex.h>
> > +#include <linux/kevent_storage.h>
> >
> >  #include <asm/atomic.h>
> >  #include <asm/semaphore.h>
> > @@ -586,6 +587,10 @@ #ifdef CONFIG_INOTIFY
> >  	struct mutex		inotify_mutex;	/* protects the watches list */
> >  #endif
> >
> 
> Here you include a kevent_storage only if KEVENT_SOCKET
> 
> > +#ifdef CONFIG_KEVENT_SOCKET
> > +	struct kevent_storage	st;
> > +#endif
> > +

It must be 
#if defined CONFIG_KEVENT_SOCKET || defined CONFIG_KEVENT_PIPE

-- 
	Evgeniy Polyakov
