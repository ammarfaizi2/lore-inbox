Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSIWUAk>; Mon, 23 Sep 2002 16:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSIWUAj>; Mon, 23 Sep 2002 16:00:39 -0400
Received: from colin.muc.de ([193.149.48.1]:39440 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S261352AbSIWUAa>;
	Mon, 23 Sep 2002 16:00:30 -0400
Message-ID: <20020923220532.38086@colin.muc.de>
Date: Mon, 23 Sep 2002 22:05:32 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nanosecond resolution for stat(2)
References: <20020923184705.GA8195@averell> <Pine.LNX.4.33.0209231154520.3512-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.33.0209231154520.3512-100000@penguin.transmeta.com>; from Linus Torvalds on Mon, Sep 23, 2002 at 08:57:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:57:32PM +0200, Linus Torvalds wrote:
> 
> On Mon, 23 Sep 2002, Andi Kleen wrote:
> > 
> > Some drivers (like mouse drivers or tty) do dubious inode [mac] time 
> > accesses of the on disk inode and without even marking it dirty. This is 
> > likely a bug.
> 
> No, it is intentional. At least some versions of "w" (maybe all) will use
> the tty access times to judge how long the tty has been idle. The point is
> that this is all information that is interesting (and useful), but not
> worth sending to disk - it is useful only as long as the inode remains
> locked in-core for other reasons, ie being in use.
> 
> (It's not only "not worth it" to send to disk, but it would be positively 
> wrong to even _try_ updating the disk with the access times, since we want 
> these things to work even with a read-only /dev).

Ok. But it is surely not needed for mouse drivers, isn't it ? 
(I removed a few updates in them) 

I didn't change tty in this regard anyways.

Would you consider to merge the patch ? 

-Andi
