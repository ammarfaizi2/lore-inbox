Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUF1PZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUF1PZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUF1PZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:25:20 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:47778 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265033AbUF1PZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:25:04 -0400
Message-ID: <40E03844.1080000@kolivas.org>
Date: Tue, 29 Jun 2004 01:24:52 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E035CE.1020401@techsource.com> <40E03376.20705@kolivas.org> <40E03C2D.5000809@techsource.com>
In-Reply-To: <40E03C2D.5000809@techsource.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy Miller wrote:
|
|
| Con Kolivas wrote:
|
|>
|> It definitely should _not_ starve. That is the unixy way of doing
|> things. Everything must go forward. Around 5% cpu for nice 19 sounds
|> just right. If you want scheduling only when there's spare cpu cycles
|> you need a sched batch(idle) implementation.
|>
|>
|
| Well, since I can't rewrite the app, I can't make it sched batch.  Nice
| values are an easy thing to get at for anything that's running.
|
| Besides, comparing nice 0 to nice 19, I'd expect something more like a
| 100:1 ratio or worse.  (That is, I don't expect nice to be linear.)
|
| Maybe this is just me, but when I set a process to the worst possible
| priority (nice 19), I expect it only to run when nothing else needs the
| CPU.


Sched batch is a kernel modification, and a simple wrapper will allow
you  to run _any_ program as sched batch without modifying it's source.

The design has had that ratio of 20:1 for a very long time so now is not
the time to suddenly decide it should be different. However if you want
to make it 100:1 for your machine feel free to edit kernel/sched.c
and change
#define MIN_TIMESLICE		( 10 * HZ / 1000)
to
#define MIN_TIMESLICE		( 1 * HZ / 1000)

That will give you more what you're looking for.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4DhDZUg7+tp6mRURAi0uAJ9vQ6b7XMGoiHP9lZxgj7yvQNwAsgCfX0u9
SZqOk5k2bm8yRBQKLY2jXsw=
=sqg0
-----END PGP SIGNATURE-----
