Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTERRdb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 13:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTERRdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 13:33:31 -0400
Received: from mail.webmaster.com ([216.152.64.131]:19379 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262143AbTERRda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 13:33:30 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Galbraith" <efault@gmx.de>
Cc: "Andrea Arcangeli" <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Scheduling problem with 2.4?
Date: Sun, 18 May 2003 10:46:24 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEPADAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there any down-side to not preempting quite as often?  It seems like
> there should be a bandwidth gain.
>
>          -Mike

	The theoretical down-side is that interactivity might suffer a bit because
a process isn't scheduled quite as quickly. Yes, the less-often you preempt
a process, the faster the system will go in the sense of work done per unit
time. But those pesky users want their characters to echo quickly and the
mouse pointer to track their physical motions.

	Obviously, we must preempt when a process with a higher static priority
becomes ready to run. However, preempting based on dynamic priorities has
permitted time slices to be even longer, permitting a reduction in context
switches without sacrificing interactivity.

	I still believe, however, that a process should be 'guaranteed' some slice
of time every time it's scheduled unless circumstances make it impossible to
allow the process to continue running. IMO, the pendulum has swung too far
in favor of interactivity. Obviously, if the process faults, blocks, or a
process with higher static priority becomes ready to run, then we must
terminate the process' time slice early.

	DS


