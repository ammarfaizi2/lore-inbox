Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312391AbSCYKuw>; Mon, 25 Mar 2002 05:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSCYKun>; Mon, 25 Mar 2002 05:50:43 -0500
Received: from mail-gw.sonicblue.com ([209.10.223.218]:33173 "EHLO
	mail-gw.sonicblue.com") by vger.kernel.org with ESMTP
	id <S312391AbSCYKub>; Mon, 25 Mar 2002 05:50:31 -0500
Message-ID: <37D1208A1C9BD511855B00D0B772242C011C7F13@corpmail1.sc.sonicblue.com>
From: Peter Hartley <PDHartley@sonicblue.com>
To: "'H . J . Lu'" <hjl@lucon.org>, Andrew Morton <akpm@zip.com.au>
Cc: tytso@thunk.org, linux-mips@oss.sgi.com,
        linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: RE: Does e2fsprogs-1.26 work on mips?
Date: Mon, 25 Mar 2002 02:52:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H J Lu wrote:
> I look at the glibc code. It uses a constant RLIM_INFINITY for a given
> arch. The user always passes (~0UL) to glibc on x86. glibc will check
> if the kernel supports the new getrlimit at the run time. If it
> doesn't, glibc will adjust the RLIM_INFINITY for setrlimit. I 
> don't see
> how glibc 2.2.5 compiled under kernel 2.2 will fail under 2.4 due to
> this unless glibc is misconfigureed or miscompiled.

It's not a question of which kernel glibc is compiled under, it's a question
of which version of the kernel headers (/usr/include/{linux,asm}) glibc is
compiled against.

A glibc, even the newest glibc, *compiled against 2.2 headers* cannot know
about the new getrlimit, so the run-time test cannot be compiled and is not
used. Such a glibc subsequently breaks fsck if run under a 2.4 kernel.

Recompile your glibc against 2.4 headers and you should get a glibc and fsck
that work if run under either a 2.2 or 2.4 kernel.

The necessary kernel patch to fix this mess is in the latest -pre-ac (thanks
Alan).

	Peter
