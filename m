Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265651AbUEZQdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUEZQdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUEZQdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:33:53 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:33030 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S265651AbUEZQdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:33:50 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 09:33:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEAEMEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
In-Reply-To: <40B47546.5050602@minimum.se>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 26 May 2004 09:11:42 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 26 May 2004 09:11:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree with Anthony Disante, maybe not all users want swapping. I have
> myself felt very annoying with swapping lately but I've not yet tried to
> disable it.

	You're probably really just annoyed with physical memory that's too small
to hold your working set. Believe it or not, having swap delays the onset of
this problem.

> In school I've studied the swapping concept from a theoretical point
> of view, and I fully understand the fact that swapping, if used
> properly, can both increase performance and provide a safe way to get
> out of a bad situation when the box runs out of memory. The problem is
> that in reality this does not work, not on Linux nor on Windows 2000
> which I use at home. Unfortunately I cannot provide a specific reason
> why it does not work, I'm very much a end-user/desktop-user, I'm not a
> kernel hacker (yet). But I see two things that needs improvement atm:

	I don't think you really do understand it from a theoretical point of view,
because you say:

> A) when I do large data processing operations the computer is always
> very very slow afterwards

	Of course, this is because the working set has changed. However, with swap,
the least used pages can be evicted from physical memory. Without it, there
may be no place to put the least used pages and more frequently used pages
have to be evicted.

> B) if I have X Mb of RAM then there should not be imho a single swap
> read/write until the whole of my X Mb RAM is completely stuffed, is this
> so today?

	It depends what you mean by "stuffed". On a modern operating system like
Linux, pretty much all of your physical memory is in use all the time.
Without swap, dirty pages cannot be evicted from physical memory, even if
they haven't been used for days. If your physical memory exceeds your
working set size, you win no matter what. But without swap, every dirty page
is part of your working set, even if it hasn't been read/written for days.

> Also, imagine that I disable swap today and start a large data
> processing operation. During this operation I try to start a new
> process, here ideally the program should not OOM but instead the memory
> allocated for the data processing operation should be decreased. Is this
> possible using today's technology? Can be divide memory into two sorts,
> one for processes (here to stay memory) and another sort for batch
> operations (where the amount of memory does not really matter but less
> memory means less performance). I see the problem with "taking memory
> back" though, I guess its impossible.

	No, it's not difficult. The OS takes physical memory back all the time by
swapping.

	You seem to be missing a fundamental concept. Physical memory will always
get full because the OS will always keep copies of file data in memory just
in case it needs them again. Because new pages are always being read in and
processes are always allocating new memory, the OS will have to make a
decision of what pages to evict from physical memory. If a page is dirty, it
can only be evicted if there's swap. So if you have dirty pages that are
very rarely used, swap allows you to keep more hot, clean pages in memory.

	A lot of people feel subjectively that swap makes a system slow. There's
anecdotal evidence that swap does horrible things or "must be badly broken
because the machine gets slow" on almost every operating system that
supports swapping. In most cases, it's just a case where the real working
set has exceeded physical memory, and in that case, swap is just doing what
it's supposed to be doing.

	DS


