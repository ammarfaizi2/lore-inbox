Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTAUXSC>; Tue, 21 Jan 2003 18:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTAUXSC>; Tue, 21 Jan 2003 18:18:02 -0500
Received: from ns.suse.de ([213.95.15.193]:3590 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267265AbTAUXSB>;
	Tue, 21 Jan 2003 18:18:01 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Jan 2003 00:27:07 +0100
In-Reply-To: john stultz's message of "22 Jan 2003 00:08:23 +0100"
Message-ID: <p731y36m6d0.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:

> All,
> 	This patch addresses the following problem: Linux cannot properly
> handle the case where interrupts are disabled for longer then two ticks.

Comments:

Basic idea is good. The x86-64 2.4 tree has a similar solution for the
same problem. Especially with HZ=1000 this is really needed, because
now lost ticks are far more common than with the HZ=100 in 2.4.
I would consider some form of this patch as requirement for 2.6 release.

what happens when 1000000 does not evenly divide HZ? 
I think some ports use HZ=1024

Why is the condition > and not >= ? Eactly two ticks offset is already
one lost. In fact even >= 1.5*HZ would be dubious.

I would like to have some statistics counter somewhere in /proc for lost 
ticks, so that it can be checked for after bug reports. Perhaps even
printk for the first 5 or so.

Could you please add spaces after /* and before */

-Andi

