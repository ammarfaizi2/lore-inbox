Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWHWHwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWHWHwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 03:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHWHwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 03:52:12 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53663 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751450AbWHWHwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 03:52:11 -0400
Date: Wed, 23 Aug 2006 11:50:56 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Jari Sundell <sundell.software@gmail.com>,
       David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823075056.GA18029@2ka.mipt.ru>
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com> <20060822231129.GA18296@ms2.inr.ac.ru> <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com> <20060822.173200.126578369.davem@davemloft.net> <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com> <20060823065659.GC24787@2ka.mipt.ru> <20060823000758.5ebed7dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060823000758.5ebed7dd.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 11:51:00 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 12:07:58AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> On Wed, 23 Aug 2006 10:56:59 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > On Wed, Aug 23, 2006 at 02:43:50AM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> > > Actually, I didn't miss that, it is an orthogonal issue. A timespec
> > > timeout parameter for the syscall does not imply the use of timespec
> > > in any timer event, etc. Nor is there any timespec timer in kqueue's
> > > struct kevent, which is the only (interface related) thing that will
> > > be exposed.
> > 
> > void * in structure exported to userspace is forbidden.
> > long in syscall requires wrapper in per-arch code (although that
> > workaround _is_ there, it does not mean that broken interface should 
> > be used).
> > poll uses millisecods - it is perfectly ok.
> 
> I wonder whether designing-in a millisecond granularity is the right thing
> to do.  If in a few years the kernel is running tickless with high-res clock
> interrupt sources, that might look a bit lumpy.
> 
> Switching it to a __u64 nanosecond counter would be basically free on
> 64-bit machines, and not very expensive on 32-bit, no?

I can put nanoseconds as timer interval too (with aligned_u64 as David
mentioned), and put it for timeout value too - 64 bit nanosecods ends up
with 58 years, probably enough.
Structures with u64 a really not so good idea.

-- 
	Evgeniy Polyakov
