Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSCYSf2>; Mon, 25 Mar 2002 13:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312490AbSCYSfT>; Mon, 25 Mar 2002 13:35:19 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:11527 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S312491AbSCYSfA>; Mon, 25 Mar 2002 13:35:00 -0500
Date: Mon, 25 Mar 2002 13:33:02 -0500 (EST)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Andrew Morton <akpm@zip.com.au>
cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Paul Clements <Paul.Clements@steeleye.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt errors, fix
 resync  counter errors
In-Reply-To: <3C9E6014.BB3DE865@zip.com.au>
Message-ID: <Pine.LNX.4.10.10203251324570.5915-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Andrew Morton wrote:

> However a bare spin_unlock_irq() in a function means that
> callers which wish to keep interrupts disabled are subtly
> subverted.   We've had bugs from this before.

Yes, that was precisely what was happening in raid1. There were
"nested" spin_lock_irq() calls.

> So the irqrestore functions are much more robust.  I believe
> that they should be the default choice.  The non-restore
> versions should be viewed as a micro-optimised version,
> to be used with caution.  The additional expense of the save/restore
> is quite tiny - 20-30 cycles, perhaps.

I was wondering about the performance of these. I was reluctant 
to change all occurrences of spin_lock_irq() to the save/restore 
versions, even though that seemed like the safest thing to do, so 
I had to analyze every code path where spin_locks were involved 
to see which ones absolutely needed to change...very tedious. 

Thanks for the explanations.

--
Paul

