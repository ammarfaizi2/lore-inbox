Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTAPLlO>; Thu, 16 Jan 2003 06:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbTAPLlO>; Thu, 16 Jan 2003 06:41:14 -0500
Received: from nowaydude.rearden.com ([64.160.169.126]:29899 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S267043AbTAPLlN>; Thu, 16 Jan 2003 06:41:13 -0500
Date: Thu, 16 Jan 2003 03:51:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
Message-Id: <20030116035109.64d1ef97.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301151712350.23847-100000@ping.us.dell.com>
References: <20030115143313.76953b63.akpm@digeo.com>
	<Pine.LNX.4.44.0301151712350.23847-100000@ping.us.dell.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2003 11:50:04.0794 (UTC) FILETIME=[68CD25A0:01C2BD55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Macaulay <robert_macaulay@dell.com> wrote:
>
> On Wed, 15 Jan 2003, Andrew Morton wrote:
> > if you could please test that with CONFIG_PREEMPT=y
> 
> Reverting that brings the speed back up

OK.  How irritating.

Presumably there's a fairness problem - once a CPU goes in there to start
spinning on the lock, the length of the loop is such that it's easy for
non-holders to zoom in and claim it first.  Or something.

Unless another way of solving the problem which that patch solves presents
itself we may need to revert it.

Or not.  Should a CONFIG_PREEMPT SMP kernel compromise its latency because of
overused locking??


I'd appreciate it if you could take a closer look at the mysterious
self-reverting .config, please.  See if you can work out what is causing it,
tell me how you're rebooting (reboot -f?  -fn?  Big Red Button?) and whether
the offending file is on the root filesystem, etc.


Thanks.
