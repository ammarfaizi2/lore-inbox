Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSGQJJS>; Wed, 17 Jul 2002 05:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318251AbSGQJJR>; Wed, 17 Jul 2002 05:09:17 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:11430 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318249AbSGQJJQ>; Wed, 17 Jul 2002 05:09:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Jesse Barnes <jbarnes@sgi.com>, Daniel Phillips <phillips@arcor.de>
Subject: Re: spinlock assertion macros
Date: Wed, 17 Jul 2002 13:09:08 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17T4Qj-0002fN-00@starship> <20020717022213.GA734386@sgi.com>
In-Reply-To: <20020717022213.GA734386@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207171309.08455.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 04:22, Jesse Barnes wrote:
> files?  Anyway, I've got spinlock and rwlock versions of them below,
> maybe they're useful enough to go in as a start?  I only coded the
> ia64 version of rwlock_is_*_locked since it was easy--the i386
> versions were a little intimidating...
>
> I thought Oliver's suggestion for tracking the order of spinlock
> acquisition was good, hopefully someone will take a stab at it along
> with Dave's FUNCTION_SLEEPS() implementation.

I suppose you can simplify your interface when the code tracking the lock 
holder (i.e. the address of the lock call) is there: 

#define MUST_HOLD(lock)		BUG_ON(!(lock)->holder)

is independent of whether lock is a spinlock or an rw_lock, so you
don't need MUST_HOLD_READ anymore. I'd even go as far as dropping 
MUST_HOLD_WRITE as well, since it helps only in the corner case
where the lock is held but only for reading.

	Arnd <><
