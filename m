Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTNdA>; Tue, 20 Feb 2001 08:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbRBTNcv>; Tue, 20 Feb 2001 08:32:51 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:20300 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129107AbRBTNcm>; Tue, 20 Feb 2001 08:32:42 -0500
Date: Mon, 19 Feb 2001 19:10:11 +0000
From: Stephen Tweedie <sct@redhat.com>
To: Fireball Freddy <fireballfreddy@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Comparing buffer cache algorithms on 2.2.17.  Suggestions?
Message-ID: <20010219191011.A1190@redhat.com>
In-Reply-To: <20010217221540.23972.qmail@web2104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217221540.23972.qmail@web2104.mail.yahoo.com>; from fireballfreddy@yahoo.com on Sat, Feb 17, 2001 at 02:15:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Feb 17, 2001 at 02:15:40PM -0800, Fireball Freddy wrote:
> 
>   o Eliminate BUF_CLEAN, BUF_DIRTY, and BUF_LOCKED
> lists in favor of a single BUF_LRU list.  This because
> I don't see the point of maintaining three lists...
> the only time I need to find all the dirty blocks is
> on a sync of some sort.  I don't mind if the sync
> takes a while longer if the normal operating condition
> is faster.

What if you have a gig of buffer cache in the system?  You still need
to maintain the single LRU, so you're not going to be saving that much
on the main codepaths, and walking a gig of unnecessary buffer_heads
every kupdate() flush is not going to be cheap.

>   It looks like the ext2 fs is going to complicate
> this somewhat, as it sets blocks dirty and/or writes
> them itself sometimes.  Not sure how I'm going to get
> around this... will probably ignore it for now.

Yep, this behaviour on the superblock and group descriptors has hurt
people in the past.

Cheers,
 Stephen
