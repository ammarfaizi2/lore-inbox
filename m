Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRAOVCB>; Mon, 15 Jan 2001 16:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131422AbRAOVBv>; Mon, 15 Jan 2001 16:01:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28689 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131308AbRAOVBm>; Mon, 15 Jan 2001 16:01:42 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Is sendfile all that sexy?
Date: 15 Jan 2001 13:00:41 -0800
Organization: Transmeta Corporation
Message-ID: <93vodp$bvf$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0101152035090.5713-100000@elte.hu> <200101152033.f0FKXpv250839@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101152033.f0FKXpv250839@saturn.cs.uml.edu>,
Albert D. Cahalan <acahalan@cs.uml.edu> wrote:
>Ingo Molnar writes:
>> On Mon, 15 Jan 2001, Jonathan Thackray wrote:
>
>>> It's a very useful system call and makes file serving much more
>>> scalable, and I'm glad that most Un*xes now have support for it
>>> (Linux, FreeBSD, HP-UX, AIX, Tru64). The next cool feature to add to
>>> Linux is sendpath(), which does the open() before the sendfile() all
>>> combined into one system call.
>
>Ingo Molnar's data in a nice table:
>
>open/close  7.5756 microseconds
>stat        5.4864 microseconds
>write       0.9614 microseconds
>read        1.1420 microseconds
>syscall     0.6349 microseconds
>
>Rather than combining open() with sendfile(), it could be combined
>with stat().

Note that "fstat()" is fairly low-overhead (unlike "stat()" it obviously
doesn't have to parse the name again), so "open+fstat" is quite fine
as-is. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
