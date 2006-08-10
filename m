Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWHJGtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWHJGtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHJGtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:49:00 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51170 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751187AbWHJGs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:48:59 -0400
Date: Thu, 10 Aug 2006 10:48:39 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060810064839.GA11845@2ka.mipt.ru>
References: <11551105602734@2ka.mipt.ru> <20060809152127.481fb346.akpm@osdl.org> <20060810061433.GA4689@2ka.mipt.ru> <20060809.234235.71555079.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060809.234235.71555079.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 10 Aug 2006 10:48:40 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:42:35PM -0700, David Miller (davem@davemloft.net) wrote:
> > > > +	k->kevent_entry.next = LIST_POISON1;
> > > > +	k->storage_entry.prev = LIST_POISON2;
> > > > +	k->ready_entry.next = LIST_POISON1;
> > > 
> > > Nope ;)
> > 
> > I use pointer checks to determine if entry is in the list or not, why it
> > is frowned upon here?
> 
> As Andrew mentioned in another posting, these poison macros
> are likely to simply go away some day, so you should not use
> them.

They exist for ages and sudently can go away?..
 
> If you want pointer encoded tags you use internally, define your own.

I think if I will add code like this
list_del(&k->entry);
k->entry.prev = KEVENT_POISON1;
k->entry.next = KEVENT_POISON2;

I will be suggested to make myself a lobotomy.

I have enough space in flags in each kevent, so I will use some bits there.

-- 
	Evgeniy Polyakov
