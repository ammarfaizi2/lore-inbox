Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317969AbSGLBeB>; Thu, 11 Jul 2002 21:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317970AbSGLBeA>; Thu, 11 Jul 2002 21:34:00 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:18958 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S317969AbSGLBd7>; Thu, 11 Jul 2002 21:33:59 -0400
X-mailer: xrn 9.02
From: pmenage@ensim.com
Subject: Re: spinlock assertion macros
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, pmenage@ensim.com
In-reply-to: <0C01A29FBAE24448A792F5C68F5EA47D2B0FDD@nasdaq.ms.ensim.com>
Message-Id: <E17SpMA-0008OG-00@pmenage-dt.ensim.com>
Date: Thu, 11 Jul 2002 18:36:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <0C01A29FBAE24448A792F5C68F5EA47D2B0FDD@nasdaq.ms.ensim.com>,
 you write:
>
>MUST_NOT_HOLD is already in Jesse's patch he posted earlier today,
>though I imagine it would be used rarely if at all.
>

The spin_assert_unlocked() macro in Jesse's patch doesn't cope with
the fact that someone else might quite legitimately have the spinlock
locked. You'd need debugging spinlocks that track the owner of the
spinlock, and then check in MUST_NOT_HOLD() you'd check that
lock->owner != current. You'd also have to have some special
non-checking lock/unlock macros to handle situations where locks are
taken in non-process context or released by someone other than the
original locker (does the migration code still do that?).

Paul
