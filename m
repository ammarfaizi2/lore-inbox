Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSJWVy6>; Wed, 23 Oct 2002 17:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSJWVy6>; Wed, 23 Oct 2002 17:54:58 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:58783 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265222AbSJWVy5>; Wed, 23 Oct 2002 17:54:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 15:10:05 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
In-Reply-To: <20021023215112.GA12488@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210231505310.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, bert hubert wrote:

> On Wed, Oct 23, 2002 at 02:51:21PM -0700, Davide Libenzi wrote:
>
> > Why would you want to have a single fd simultaneously handled by two
> > different threads with all the locking issues that would arise ? I can
> > understand loving threads but this seems to be too much :)
>
> We in fact tried to do this and for good reason. Our nameserver sofware gets
> great benefit when two processes listen to the same socket on an SMP system.
> In some cases, this means 70% more packets/second, which is close to the
> theoretical maximum beneft.
>
> We would heavily prefer to have two *threads* listening to the same socket
> instead of to processes. The two processes do not share caching information
> now because that expects to live in the same memory.
>
> Right now, we can't do that because of very weird locking behaviour, which
> is documented here: http://www.mysql.com/doc/en/Linux.html and leads to
> 250.000 context switches/second and dysmal peformance.
>
> I expect NPTL to fix this situation and I would just love to be able to call
> select() or poll() or recvfrom() on the same fd(s) from different threads.

I feel this topic is going somewhere else ;) ... but if you need your
processes to share memory, and hence you would like them to be threads,
you're very likely going to have some form of syncronization mechanism to
access the shared area, don't you? So, isn't it better to have two
separate tasks, that can freely access the memory w/out locks instead of N
threads?



- Davide



