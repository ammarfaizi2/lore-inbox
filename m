Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268904AbRG0RgT>; Fri, 27 Jul 2001 13:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRG0RgL>; Fri, 27 Jul 2001 13:36:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60723 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268904AbRG0Rfx>; Fri, 27 Jul 2001 13:35:53 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: bvermeul@devel.blackstar.nl, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271653210.12396-100000@devel.blackstar.nl>
	<3B618AE4.983439DC@namesys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Jul 2001 11:29:45 -0600
In-Reply-To: <3B618AE4.983439DC@namesys.com>
Message-ID: <m1d76me0vq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hans Reiser <reiser@namesys.com> writes:

> This "feature" of not guaranteeing that a write that is in progress when the
> machine crashes will
> 
> not write garbage, has been present in most Unix filesystems for about 25 years
> of Unix history.  

A write in progress causing garabage when the power is lost is a
driver, and drive thing.

stock unix behavior is that it delays writes for up to 30 seconds,
which in case of a crash could mean you have old data on disk.   Not
wrong data.  This is helped because in stock unix filesystems blocks
are rarely reallocated or moved.  In reiserfs with the btree at least
some kinds of data are moved all over the disk.

I want to suspect a btree problem on the block jumping around (it's
a good canidate).  But unless you have messed up metadata journalling
btree writes are journaled.  The reason I am suspecting the btree is
that most source code files are small so probably don't have complete
filesystem blocks of their own.

> It
> 
> is not that we are deviant on this, it is that a tradeoff is made, and for most
> but not all users it
> 
> is a good one to make.

If you can give me an explanation of what would cause the described
behavior of small files swapping their contents I would believe I
would feel more secure than just a reflex ``we don't garantee all of the
data written before power failure''.

Eric

 
