Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTIJJOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTIJJOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:14:38 -0400
Received: from mid-1.inet.it ([213.92.5.18]:8643 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S264848AbTIJJOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:14:33 -0400
Message-ID: <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: <alexander.riesen@synopsys.COM>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 11:18:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I mean for benchmarks. You compared your implementation to a very old
> linux' one. There were big changes in these areas.

The overhead implied by a memcpy() is the same, in the oder of magnitude,
***whatever*** kernel version you can develop.

If you have to send, lt's say, 3 memory pages from A to B,
using pipes you have to ***physically copy***
2 * 3 * PAGE_SIZE bytes
(firt time, sending; then receiving them. So two times).
Which evals to 8192 * 3.

Using capability, the only thing you have to do
is copying an amount of bytes that are linearly dependent
by the number of pages: so, proportional to 3.

I you want the (quite) exact amount, it is
3 * sizeof(unsigned long) + sizeof(capability)
which evals to  12 + 16 = 28.
X is not present in the equation.

I compared pipes and SYS V IPC on Linux 2.2.4 with the new mechanism
also developed over kernel 2.2.4!
The same inefficiency of the kernel support you are talking about
affet all the primitives being examined in the article. Mine, too.

So the relative results will be quite the same.

> you surely know, that it is just an implementation. The mechanisms have
> always been there, evolved from UNIX.
> That is mainly the reason for them to exists: support the applications
> which use them.
>
> Will it be possible to base existing facilities on your approach?
> SVR5 messages (msg{get,snd,rcv}), for example?
> (I have to ask, because I cannot understand the article, sorry)

Ah, ok. So let's continue to do ineffient things
only because it has always been so!

Compatibility is not a problem. Simply rewrite the write() and read() for
pipes
in order to make them do the same thing done by zc_send() and zc_receive().
Or, if you are not referring to pipes, rewrite the support level of you
anchient IPC primitives
in order to make them do the same thing done by zc_send() and zc_receive().

Bye,
Luca.

