Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270382AbTGMT5C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270397AbTGMT5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:57:02 -0400
Received: from mail.webmaster.com ([216.152.64.131]:44508 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270382AbTGMT47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:56:59 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Black" <mblack@csi-inc.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Pthread performance
Date: Sun, 13 Jul 2003 13:11:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEEOEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <022401c3479e$2b1cd2e0$c8de11cc@black>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I found a benchmark program for threads and found a major
> difference between a single CPU and dual CPU system.
> Here's the code:
> http://www-124.ibm.com/pipermail/pthreads-users/2002-April/000176.html
> Is this showing context switches going between CPUs??

	No.

> Wouldn't one expect the dual CPU to run twice as fast instead of
> ten times slower?

	Not necessarily. The code doesn't do much other than modified shared data
without a lock. Not only does this invoke undefined behavior, but it
penalizes SMP machines because only they are subject to cache ping-ponging.

> As you can see from the timing user time increases by a factor of
> 4 and system time by a factor of 10.
> I seem to remember something about gettimeofday() possibly being
> a problem but couldn't find a reference to it.
> Anybody have an explanation/fix for this?

	The program doesn't seem to measure anything useful and invokes undefined
behavior.

	If you would like a fix, try this:

#define sched_yield() while(false)

	DS


