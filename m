Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTARDmO>; Fri, 17 Jan 2003 22:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbTARDmO>; Fri, 17 Jan 2003 22:42:14 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:27870
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262384AbTARDmN>; Fri, 17 Jan 2003 22:42:13 -0500
Message-ID: <3E28CF26.6020202@redhat.com>
Date: Sat, 18 Jan 2003 03:51:02 +0000
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question about threads and signals
References: <20030118032450.GA18282@bjl1.asuk.net>
In-Reply-To: <20030118032450.GA18282@bjl1.asuk.net>
X-Enigmail-Version: 0.72.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> 1. If a signal is delivered to a thread, is it masked for the duration of
>    the handler in (a) just that thread or (b) all threads?

(a)

>    In other words, if I have 3 threads and SIGIO is not blocked in any
>    of them, is it possible for my SIGIO handler to be called up to 3
>    times concurrently?  Or is the blocked mask somehow shared?

Masks are never shared.


>    Is the same thing true of SIGCHLD?  SIGSEGV?

Yes.  Up to the point where a fatal signal isn't caught and the process
is killed.  At that point all threads except the one responsible for the
termination is stopped and then terminated.


> 2. Is this true of POSIX threads in general, or just Linux?

Well, the above is what POSIX requires and what I think we've
implemented.  These requirements are essential for programs which do
much of their work in signal handlers.  Creating more threads which
mainly just sit around but can react to signals is a valid programming
model.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+KM8m2ijCOnn/RHQRAlcEAJ0W27Ju6gq4xhT7A0PGr2IJCGfp0ACfa2NY
2mmvlgXLC2Xm8UYnU+rD6cE=
=7eDw
-----END PGP SIGNATURE-----

