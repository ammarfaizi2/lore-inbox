Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284751AbRLEWOI>; Wed, 5 Dec 2001 17:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284533AbRLEWN7>; Wed, 5 Dec 2001 17:13:59 -0500
Received: from mangalore.zip.com.au ([203.12.97.48]:45580 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284745AbRLEWNo>; Wed, 5 Dec 2001 17:13:44 -0500
Message-ID: <3C0E9BFD.BC189E17@zip.com.au>
Date: Wed, 05 Dec 2001 14:13:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0
In-Reply-To: <Pine.LNX.4.33.0111271543410.16419-100000@localhost.localdomain>,
		<Pine.LNX.4.33.0111271543410.16419-100000@localhost.localdomain> <20011206082949.400dffd5.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> PS.  Also would be nice to #define del_timer del_timer_sync, and have a
>      del_timer_async for those (very few) cases who really want this.

That could cause very subtle deadlocks.   I'd prefer to do:

#define del_timer_async	del_timer

and to then put out the word that del_timer is a deprecated
interface and code should use either del_timer_sync or
del_timer_async.

That way, we can grep through the tree and see which code
has not yet been reviewed/fixed.

-
