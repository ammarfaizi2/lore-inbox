Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbTIGIfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 04:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTIGIfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 04:35:13 -0400
Received: from law10-oe38.law10.hotmail.com ([64.4.14.95]:64517 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262875AbTIGIfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 04:35:10 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: <linux-kernel@vger.kernel.org>
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5ABE90.2040003@cyberone.com.au> <Law10-OE296cRyiOYbp00008b23@hotmail.com> <3F5AE7ED.7010501@cyberone.com.au>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sun, 7 Sep 2003 04:35:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <LAW10-OE38NfztQ7LS000009f64@hotmail.com>
X-OriginalArrivalTime: 07 Sep 2003 08:35:09.0205 (UTC) FILETIME=[F2596450:01C3751A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Even if context switches don't cost anything, you still want to have
> priorities so cpu hogs can be preempted by other tasks in order to
> quickly respond to IO events. You want interactive tasks to be able
> to sometimes get more cpu than cpu hogs, etc. Scheduling latency is
> only a part of it.
>

Of course priorities are still necessary =)  However assuming that
interactive tasks will always finish much much earlier than hogs, it's not
really worth it to give interactive tasks any special treatment when you
have very fine timeslices.

For example you have x that will use 100 ms and y that will use 5 ms, both
of the same priority.  Assuming that x entered into the queue first and y
immediately after, at 20 ms timeslice, it will be 25 ms before y finishes.
However, at 1 ms timeslice, y finishes in 10 ms.


John Yau
