Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbSKUBIt>; Wed, 20 Nov 2002 20:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbSKUBIt>; Wed, 20 Nov 2002 20:08:49 -0500
Received: from netrealtor.ca ([216.209.85.42]:45322 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S266259AbSKUBIs>;
	Wed, 20 Nov 2002 20:08:48 -0500
Date: Wed, 20 Nov 2002 20:23:34 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021121012334.GG32715@mark.mielke.cc>
References: <20021120235135.GA32715@mark.mielke.cc> <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com> <20021121002816.GC12650@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121002816.GC12650@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:28:16AM +0000, Jamie Lokier wrote:
> Davide Libenzi wrote:
> > typedef union epoll_obj {
> > 	void *ptr;
> > 	__uint32_t u32[2];
> > 	__uint64_t u64;
> > } epoll_obj_t;
> > I'm open to suggestions though. The "ptr" enable me to avoid wierd casts
> > to avoid gcc screaming.
> That makes more sense to me, because it will be fine to use `ptr' even
> on 128-bit pointer machines when they arrive, yet preserves the
> property that 64<->32 bit conversion functions don't need to reformat
> the buffer when running 32-bit applications on a 64-bit CPU... even if
> the 32-bit application uses the `ptr' field.
> Did I just write that? :)

The problem with sizeof(void *) being >= sizeof(__uint64_t) is that the
data structure is the wrong length. Binary compatibility would not be
maintained.

Still... I believe that the days of 128-bit pointers are comfortably
far enough away that it does not cause any concerns at all for me. (I
suspect the kernel will need quite a few more changes than just this
to support 128-bit poitners...)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

