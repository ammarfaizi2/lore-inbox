Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTIJFmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbTIJFmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:42:16 -0400
Received: from law10-oe41.law10.hotmail.com ([64.4.14.98]:39694 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264812AbTIJFmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:42:15 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: <linux-kernel@vger.kernel.org>
References: <Law10-OE471DczmBlrP0000b07a@hotmail.com> <3F5E8CF7.5020603@cyberone.com.au>
Subject: Re: Priority Inversion in Scheduling
Date: Wed, 10 Sep 2003 01:41:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <OE41az7EjQxzmWecm9t0003cc0d@hotmail.com>
X-OriginalArrivalTime: 10 Sep 2003 05:41:42.0014 (UTC) FILETIME=[366B51E0:01C3775E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Well I haven't read the paper, but I'm guessing this is semaphore
> priority inheritance.
>

Yip...it outlines the basic idea of the priority inheritance where semphores
are the locking mechanism.  However, though it buys you better prioritized
scheduling in certain situation, things can get rather hairy when you have
lots of semaphores nested inside each other.  If you have a cyclic
dependency somewhere in those nested semaphores, you're headed for deadlock
or worse livelock.  The Mars Rover had a classic case of priority inversion
in it's software that was later solved through this approach via an update
after it landed on Mars a while back.

>
> I _think_ communication with X will mostly be done with waitqueues.
> Someone has a priority inheritance futex patch around. I'm not sure
> that it is such an open and shut case as you think though. Even if you
> could use futexes in communication with X.
>

It's not an open and shut case...actually it'd be quite an undertaking I
suspect.  Because a poorly designed and/or poorly implemented scheme can
easily lead to deadlocks and what not, any implementation would need massive
peer review.
