Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTIGRbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTIGRbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:31:55 -0400
Received: from law10-oe54.law10.hotmail.com ([64.4.14.47]:51211 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263387AbTIGRbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:31:06 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: <linux-kernel@vger.kernel.org>
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5ABE90.2040003@cyberone.com.au> <Law10-OE296cRyiOYbp00008b23@hotmail.com> <3F5AE7ED.7010501@cyberone.com.au> <LAW10-OE38NfztQ7LS000009f64@hotmail.com> <3F5AF9D9.3070206@cyberone.com.au>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sun, 7 Sep 2003 13:30:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Law10-OE54gbLYluLCT0003a61e@hotmail.com>
X-OriginalArrivalTime: 07 Sep 2003 17:31:05.0729 (UTC) FILETIME=[D1218F10:01C37565]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Its actually more important when you have smaller timeslices, because
> the interactive task is more likely to use all of its timeslice in a
> burst of activity, then getting stuck behind all the cpu hogs.
>

Well, I didn't claim it'd be optimal, I just said that it's not worth the
extra effort.  The interactive task will still finish in O((interactive_time
/ timeslice) * #hogs + interative_time) ms.  As long as the cpu time
interactive tasks require are very short, they still should finish within a
reasonable amount of time.

> >
>
> Yes. Also, say 5 hogs running, an interactive task needs to do something
> taking 2ms. At a 2ms timeslice, it will take 2ms. At a 1ms timeslice it
> will take 6ms.
>

That's assuming that the interactive task gets scheduled first.  In the
worst case scenario where it gets scheduled last, at 2 ms, it takes 12 ms
and at 1 ms it also takes 12 ms.  Not much difference there.

