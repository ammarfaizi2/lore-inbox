Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136672AbREARdT>; Tue, 1 May 2001 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136678AbREARdK>; Tue, 1 May 2001 13:33:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33842 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136672AbREARcx>; Tue, 1 May 2001 13:32:53 -0400
Date: Tue, 1 May 2001 19:32:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, ralf@nyren.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
Message-ID: <20010501193225.D31373@athlon.random>
In-Reply-To: <20010501190942.B31373@athlon.random> <200105011725.VAA00484@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105011725.VAA00484@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, May 01, 2001 at 09:25:43PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 09:25:43PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > zero and we are running in such slow path, it is obvious the send_head
> > _was_ NULL when we entered the critical section, so it's perfectly fine
> 
> It is not only not obvious, it is not true almost always.
> On normally working tcp send_head is almost never NULL,
> it is NULL only when application is so slow that is not able
> to saturate pipe. If you do not believe my word, add printk checking this. 8)

Note: I said: ".. if send_head points to skb and skb->len is
		  ^^^^^^^^^^^^^^^^^^^^^^^^^^
zero and we are running in such slow path ..".

If send_head doesn't point to skb then it is before it (and it cannot
advance under us of course because we hold the sock lock) and so in such
case we didn't clobbered the send_head at all in skb_entail, and so we
don't need to touch send_head in order to undo (we only need to unlink).

See?

Andrea
