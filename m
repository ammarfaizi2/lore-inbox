Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSHHSs5>; Thu, 8 Aug 2002 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHHSs5>; Thu, 8 Aug 2002 14:48:57 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:46098 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S317814AbSHHSs4>; Thu, 8 Aug 2002 14:48:56 -0400
X-mailer: xrn 9.02
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, pmenage@ensim.com
X-Newsgroups: 
In-reply-to: <0C01A29FBAE24448A792F5C68F5EA47D2D4437@nasdaq.ms.ensim.com>
Message-Id: <E17csOL-0008L7-00@pmenage-dt.ensim.com>
Date: Thu, 08 Aug 2002 11:52:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D2D4437@nasdaq.ms.ensim.com>,
 you write:
>
>> Agreed.  I'll post another patch that doesn't mess with the scsi
>> stuff.  Maybe later I can put together a useful
>> 'lock-not-held-on-this-cpu' macro.
>
>You don't need to put this in a macro.  This test is valid
>for ALL spinlocks in the kernel and can be done from inside
>the spin_lock() macro itself, when spinlock debugging is on.
>

There are some cases where this might not be true - e.g. in the
migration code in at least one version of the O(1) scheduler (included
in RedHat's 2.4.18-4) the migration_lock is taken on one CPU and
released on another (following an IPI being sent from the CPU that took
the lock).

So at the very least you'd need a separate set of spinlock primitives
that don't perform this test, which would have to be used by anyone
taking/releasing such a lock.

Paul
