Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274911AbRIXTet>; Mon, 24 Sep 2001 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274907AbRIXTei>; Mon, 24 Sep 2001 15:34:38 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:26606 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S274911AbRIXTeY>; Mon, 24 Sep 2001 15:34:24 -0400
Date: Mon, 24 Sep 2001 20:34:06 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gordon Oliver <gordo@pincoya.com>
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010924203406.B9688@kushida.jlokier.co.uk>
In-Reply-To: <3BAEB39B.DE7932CF@kegel.com> <m1g09c76aq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1g09c76aq.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Sep 24, 2001 at 01:11:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > As Davide points out in his reply, /dev/epoll is an exact clone of
> > the O_SETSIG/O_SETOWN/O_ASYNC realtime signal way of getting readiness
> > change events, but using a memory-mapped buffer instead of signal delivery
> > (and obeying an interest mask).  Unlike /dev/poll, it only provides
> > information about *changes* in readiness.
> 
> Right.  But it does one additional thing that the rtsig method doesn't
> it collapses multiple readiness *changes* into a single readiness change.
> This allows the kernel to keep a fixed size buffer so you never need
> to fallback to poll as you need to with the rtsig approach.

That could be added to rtsigs, with the same result: no need to fallback
to poll.  You could even keep the memory for the queued signal / event
inside the file structure.

-- Jamie
