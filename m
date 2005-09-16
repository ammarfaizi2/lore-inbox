Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030586AbVIPEz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbVIPEz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 00:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbVIPEz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 00:55:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54195
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030586AbVIPEz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 00:55:28 -0400
Date: Thu, 15 Sep 2005 21:55:27 -0700 (PDT)
Message-Id: <20050915.215527.42819293.davem@davemloft.net>
To: rdunlap@xenotime.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: soft lockup disease (2.6.14-rc1, x86_64)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509151441430.1800@shark.he.net>
References: <Pine.LNX.4.58.0509151441430.1800@shark.he.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Randy.Dunlap" <rdunlap@xenotime.net>
Date: Thu, 15 Sep 2005 15:20:03 -0700 (PDT)

> (somewhat like http://bugzilla.kernel.org/show_bug.cgi?id=5159 )
> but not IO/Storage related AFAICT, and not xseries.
> 
> It always includes ext3 in the backtrace (from what I have noticed).
> [The serial console output appears a bit garbled.]
> 
> Are there patches for this or is it an outstanding issue?

I've seen similar triggers on sparc64 from a reporter, but
it was NFSD and slab poisioning in the backtrace in that case.

I think the common denominator is the presence of very busy kernel
daemons unable to schedule out to let other tasks (and in particular
the per-cpu softlockup daemon) onto the cpu.

Looking at KNFSD specifically, I don't see anywhere that it tries to
yield the cpu if it's been working for too long.

I guess that's exactly what the softlockup thing was meant to catch
:-)
