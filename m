Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281478AbRLBRK5>; Sun, 2 Dec 2001 12:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRLBRKs>; Sun, 2 Dec 2001 12:10:48 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:6410 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S280012AbRLBRKg>; Sun, 2 Dec 2001 12:10:36 -0500
Message-Id: <200112021709.fB2H9ws14663@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=US-ASCII
From: space-00002@vortex.physik.uni-konstanz.de
Organization: Universitaet Konstanz/Germany
To: akpm@zip.com.au, riel@imladris.surriel.com
Subject: Re: buffer/memory strangeness in 2.4.16 / 2.4.17pre2
Date: Sun, 2 Dec 2001 18:08:16 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33L.0112021014330.4079-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0112021014330.4079-100000@imladris.surriel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I verified this by throwing in 1GB of swap. It does lose the buffers 
eventually, but it does so under great pains. However, since I do have 
*plenty* memory and slow disks, I prefer running without swap. These settings 
appear to be broken (2.4.13 worked!).

Without swap, I would have to reboot every day to make my simulation happy.- 
But it needs to allocate and use *only* about 300 of 768MB which *should* be 
available, only because the night before a cron job kicked off 'updatdb' 
filling the buffers.

Without swap, it really is *this* bad in 2.4.16 and the latest pre-releases. 
RAM is full of buffers that just won't disappear to make room for more 
important stuff. My simulation gets killed *every time* until I reboot to 
free 'buffers' or add swap. (This makes everything slower in total.)

:-(

	Jan

On Sunday 02 December 2001 13:17, Rik wrote:
> On Sat, 1 Dec 2001, Andrew Morton wrote:
> > You'll find that if you push the machine really hard - allocate
> > 1.5x physical memory and touch it all then the VM will, eventually,
> > with great reluctance and much swapping, relinquish the 30 megabytes
> > of buffercache memory.  But it's out of whack.
>
> This is an expected (and very bad) side effect of use-once.
>
> > If we put anon pages on the active list instead, then shrink_caches()
> > and refill_inactive() start to do something, and they move that stale
> > old buffercache memory onto the inactive list where it can be freed.
>
> This would fix the problem of not being able to evict stale
> active pages, but I have no idea if it would unbalance
> something else.
>
> > This is just a random hack.  I don't understand what's going on in
> > the VM, let alone what's *supposed* to be going on.  And given the
> > state of documentation available to us,  I never will.
>
> The balancing in Andrea's VM is just too subtle to understand
> without docs, that is, if there is any particular idea behind
> it and it isn't just experimentation.
>
> regards,
>
> Rik
