Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261285AbSIWSxz>; Mon, 23 Sep 2002 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSIWSxR>; Mon, 23 Sep 2002 14:53:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55563 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261285AbSIWStm>; Mon, 23 Sep 2002 14:49:42 -0400
Date: Mon, 23 Sep 2002 11:57:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nanosecond resolution for stat(2)
In-Reply-To: <20020923184705.GA8195@averell>
Message-ID: <Pine.LNX.4.33.0209231154520.3512-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Andi Kleen wrote:
> 
> Some drivers (like mouse drivers or tty) do dubious inode [mac] time 
> accesses of the on disk inode and without even marking it dirty. This is 
> likely a bug.

No, it is intentional. At least some versions of "w" (maybe all) will use
the tty access times to judge how long the tty has been idle. The point is
that this is all information that is interesting (and useful), but not
worth sending to disk - it is useful only as long as the inode remains
locked in-core for other reasons, ie being in use.

(It's not only "not worth it" to send to disk, but it would be positively 
wrong to even _try_ updating the disk with the access times, since we want 
these things to work even with a read-only /dev).

		Linus

