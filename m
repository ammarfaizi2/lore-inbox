Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbTBLRRo>; Wed, 12 Feb 2003 12:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBLRRo>; Wed, 12 Feb 2003 12:17:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62215 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267142AbTBLRRn>; Wed, 12 Feb 2003 12:17:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Wed, 12 Feb 2003 17:24:08 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b2dvvo$7n5$1@penguin.transmeta.com>
References: <629040000.1045013743@flay> <20030212041848.GA9273@bjl1.jlokier.co.uk> <b2cnit$7e6$1@penguin.transmeta.com> <20030212101831.GB10422@bjl1.jlokier.co.uk>
X-Trace: palladium.transmeta.com 1045070837 25979 127.0.0.1 (12 Feb 2003 17:27:17 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Feb 2003 17:27:17 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030212101831.GB10422@bjl1.jlokier.co.uk>,
Jamie Lokier  <jamie@shareable.org> wrote:
>
>I meant: the trampoline _stack_ lives in the TSS.
>
>There is no trampoline _code_.

Ahh, ok. That sounds quite doable, and all my complaints go away.

It still leaves the debug exception and NMI issue.

The debug exception case is easy to trigger: use gdb to single-step
through the user-lebel fast system call code, and you _will_ get a debug
exception on the very first kernel instruction (which is also the one
that doesn't have a valid stack). 

So anybody want to actually try to implement this?

		Linus
