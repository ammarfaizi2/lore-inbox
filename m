Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272043AbRHVQdf>; Wed, 22 Aug 2001 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272047AbRHVQdQ>; Wed, 22 Aug 2001 12:33:16 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:61335 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272043AbRHVQdH>; Wed, 22 Aug 2001 12:33:07 -0400
Date: Wed, 22 Aug 2001 12:33:21 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Brad Chapman <kakadu_croc@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: brlock_is_locked()?
In-Reply-To: <20010822130428.77456.qmail@web10901.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0108221231260.19638-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Brad Chapman wrote:

> restart:
> 	if (brlock_is_locked(BR_NETPROTO_LOCK)) {
> 		CRITICAL_SECTION
> 		br_write_unlock_bh(BR_NETPROTO_LOCK);
> 	}
> 	else {
> 		/* Let's get dizzy */
> 		br_write_lock_bh(BR_NETPROTO_LOCK);
> 		goto restart;
> 	}

That code can never work.  None of the linux spinlocks track ownership, so
checking if a lock is locked tells you if your process or another has
ownership of the lock.  The above pseudo code is going to result in lots
of mangled data.

		-ben

