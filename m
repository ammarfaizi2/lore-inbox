Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTETA0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTETA0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:26:48 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:65180 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263187AbTETA0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:26:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 19 May 2003 17:38:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Comparing the aio and epoll event frameworks.
In-Reply-To: <200305192333.QAA12018@pagarcia.nscp.aoltw.net>
Message-ID: <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com>
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, John Myers wrote:

> The following documents my understanding of the differences between
> the epoll and aio event frameworks.  These differences stem from the
> fact that epoll is designed for use by single threaded callers,
> whereas aio is designed for use by multithreaded, thread pool callers.
>
> I do not intend to criticise either design choice--each model (single
> threaded vs. thread pool) has its uses and each model has requirements
> of the event framework which conflict with the requirements of the
> other.

Hi John, you seem to have lost a few episodes of the epoll saga. You can
use epoll in both Edge Triggered or Level Triggered ways, and in LT mode
epoll is basically a super-poll. You can call it with blocking and non
blocking fds. You can call it from many threads and (with LT mode) you
don't even need to reach EAGAIN (actually even with ET you don't need to
reach EAGAIN but I'm not willing in starting again discussions already
happened 25 times on lkml). You can easily do thread pooling also. As
a matter of fact a pretty famous on line gaming company is using epoll
together with a thread pooling implementation and last time I've got
contacted by them they were easily handling more than 150K fds with that
model. John, do not cast API in only work in a single environment. Is
poll/select a single threading API ? A thread pooling one ? I'd say both,
since you can choose the model it better fits your need. Same thing for
epoll. About the single shot feature I has a discussion here with the
guy that wrote kqueue and I was telling him about my wish to keep epoll as
simple as possible since people worked with poll/select for many years and
they did not commit suicide because of the lack of extended features.
Adding a single shot feature to epoll takes about 5 lines of code,
comments included :) You know how many reuqests I had ? Zero, nada.



- Davide

