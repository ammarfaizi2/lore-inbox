Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVEOSnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEOSnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 14:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEOSnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 14:43:04 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:55559 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261191AbVEOSm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 14:42:59 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Hyper-Threading Vulnerability
Date: Sun, 15 May 2005 11:42:49 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEADDNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <20050515094352.GB68736@muc.de>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 15 May 2005 11:41:43 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 15 May 2005 11:41:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:

> And what you're doing is to ask all the non crypto guys to give
> up an useful optimization just to fix a problem in the crypto guy's
> code. The cache line information leak is just a information leak
> bug in the crypto code, not a general problem.

	Portable code shouldn't even have to know that there is such a thing as a
cache line. It should be able to rely on the operating system not to let
other tasks with a different security context spy on the details of its
operation.

> There is much more non crypto code than crypto code around - you
> are proposing to screw the majority of codes to solve a relatively
> obscure problem of only a few functions, which seems like the totally
> wrong approach to me.

	That I do agree with.

> BTW the crypto guys are always free to check for hyperthreading
> themselves and use different functions.  However there is a catch
> there - the modern dual core processors which actually have
> separated L1 and L2 caches set these too to stay compatible
> with old code and license managers.

	This is just a recipe for making it impossible to write correct code. If
you don't believe the operating system or the hardware is at all at fault
for this problem, then it would follow that they could repeat this same
problem with some new mechanism and still not be at fault. So even if the
program checked for hyper-threading, it would still not be correct. It would
have to check for every possible future way this same type of problem could
arise and hide every type of trace that they could create, even if that
trace is in optimization mechanisms and potential channels over which the
programmer has no knowledge because they don't exist yet.

	Let's try a rudctio ad absurdum. Surely you would agree that something
other than than the crypto software is at fault if the operating system or
hardware allowed another process with a different security context to see
every instruction the code executed. The crypto authors shouldn't be
expected to make the instruction flows look identical. How different is
monitoring the memory accesses?

	Portable, POSIX-compliant C software shouldn't even have to know that there
is such a thing as a cache line.

	I'm not going to be unreasonable though. Hyper-threading is here, and now
that we know the potential problems, it's not unreasonable to ask developers
of crypto code to work around it. But it's not a bug in their code that they
need to fix. In fact, they can't even fix it yet because there is no
portable way to determine if you're on a machine that has hyper-threading or
not.

	DS


