Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTESUny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTESUny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:43:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262547AbTESUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:43:53 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Exception trace for i386
Date: 19 May 2003 20:56:48 GMT
Organization: Transmeta Corp
Message-ID: <1053377808.588720@palladium.transmeta.com>
References: <20030519192814.GA975@averell>
X-Trace: palladium.transmeta.com 1053377808 19728 127.0.0.1 (19 May 2003 20:56:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 19 May 2003 20:56:48 GMT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: torvalds@penguin.transmeta.com (Linus Torvalds)
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030519192814.GA975@averell>, Andi Kleen  <ak@muc.de> wrote:
>
>x86-64 had printks for user level faults for a long time. This
>proved to be very useful to trace otherwise hidden faults, e.g.
>on a normal kernel there is no way to see a segfault in a process
>that runs in a write protected directory, even when core dumps
>are enabled. Also it's useful as an early warning that something
>is wrong with your system.
>
>There was a request to port this to i386. Done with this patch.

Please don't do it this way. For one thing, there are valid uses where
you want to enable tracing for just one process. For another, there are
actually cases where you may want to trace all page faults, even the
ones that don't cause signals - kind of like normal system calls. After
all, from a behavioural standpoint, that is what they are: implied
system calls.

So I think you want to make it per-process, and expose it as a ptrace
thing (imaging seeing all the page faults a process is taking with
"strace". Potentially quite useful for performance tuning).

I don't think it's ever really valid to expose it as a global option, as
some programs use page faults (even the signalling kind) to do their own
memory management, and making it a global option just makes it hard to
work with such programs.

		Linus
