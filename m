Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSFLUTI>; Wed, 12 Jun 2002 16:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFLUTH>; Wed, 12 Jun 2002 16:19:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312681AbSFLUTH>; Wed, 12 Jun 2002 16:19:07 -0400
Date: Wed, 12 Jun 2002 13:16:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>, <frankeh@watson.ibm.com>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.44.0206121459110.30179-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0206121310260.9852-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jun 2002, Oliver Xymoron wrote:
> 
> That doesn't rule out approaches like storing a cookie alongside the lock
> once it's acquired (or in a parallel space). Which can easily be done with
> a wrapper around lock acquisition. And stale lock detection needn't be
> done in kernel space either.

Oh, agreed, you can do debugging locks in user-space, but it won't be the
kernel that does anything, it will instead have to depend on something
like "if I time out on the lock, I can explicitly test if the previous
holder (who saved his thread ID in memory after getting the lock) is still
alive and try to clean up after him".

This is what a lot of the filesystem locking code does for the things in
/var/lock/xxx, of course.

No kernel necessarily involved. 

But it's going to have to depend on the politeness of all threads that 
partake in the locking.

		Linus

