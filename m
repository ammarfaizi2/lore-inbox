Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbTGPBbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270014AbTGPBbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:31:34 -0400
Received: from mail.webmaster.com ([216.152.64.131]:33722 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S270013AbTGPBbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:31:32 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "James Antill" <james@and.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
Date: Tue, 15 Jul 2003 18:46:20 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEFBEGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <m3y8yz3583.fsf@code.and.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:

> > 	This is really just due to bad coding in 'poll', or more
> > precisely very bad
> > for this case. For example, why is it allocating a wait queue
> > buffer if the
> > odds that it will need to wait are basically zero? Why is it adding file
> > descriptors to the wait queue before it has determined that it needs to
> > wait?

> Because this is much easier to do in userspace, it's just not very
> well documented that you should almost always call poll() with a zero
> timeout first.

	It's neither easier to do nor harder, it's basically the same code in
either place. However, doing it in kernel space saves the extra user/kernel
transition, poll set allocations, and copies across the u/k boundary in the
case where we do actually need to wait.

> However it's been there for years, and things have used
> it[1].

	The thing is, for some reason it (it being the cost of calling poll with a
constant timeout for 1,024 file descriptors) is exceptionally bad on Linux.
Worse than every other OS I've tested.

> There are still optimizations that could have been done to poll() to
> speed it up but Linus has generally refused to add them.

	Yep, so we invent new APIs to fix the deficiencies in the most common API's
implementation. Whatever.

	DS


