Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUF1VQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUF1VQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUF1VQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:16:10 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:13786 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265225AbUF1VPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:15:30 -0400
Message-ID: <40E08A5B.7040808@kolivas.org>
Date: Tue, 29 Jun 2004 07:15:07 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E03C2D.5000809@techsource.com> <40E0449F.5050104@nortelnetworks.com> <200406281824.01836.mbuesch@freenet.de>
In-Reply-To: <200406281824.01836.mbuesch@freenet.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Buesch wrote:
| Quoting Chris Friesen <cfriesen@nortelnetworks.com>:
|
|>>Timothy Miller wrote:
|>>
|>>>
|>>>Con Kolivas wrote:
|>>>
|>>> >
|>>> > It definitely should _not_ starve. That is the unixy way of doing
|>>> > things. Everything must go forward. Around 5% cpu for nice 19 sounds
|>>> > just right. If you want scheduling only when there's spare cpu cycles
|>>> > you need a sched batch(idle) implementation.
|>>> >
|>>> >
|>>>
|>>>Well, since I can't rewrite the app, I can't make it sched batch.  Nice
|>>>values are an easy thing to get at for anything that's running.
|>>
|>>Sure you can.  You can set the scheduler policy on any process in the
system,
|>>while its running.
|>>
|>>int sched_setscheduler(pid_t pid, int policy, const struct
sched_param *p);
|>>
|>>Takes about two minutes to write an equivalent to "nice" to set
scheduler
|>>policies and priorities.
|
|
| Sounds cool. I was searching this syscall for a long time, now. :)
| But batch scheduling is available in -ck only, so this works only
| with -ck kernels. Correct?

Easy to do with the wrapper too:
schedtool -B $pid

or if it's not running yet:
schedtool -B -e $application

schedtool is here:
http://freshmeat.net/projects/schedtool/?topic_id=136

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4IpbZUg7+tp6mRURAkx/AJ9fRpPkp5itK9cgPjiG9dArVe0emwCfe8KV
144Ax1BFUBYy7OskVVNU7Ys=
=Hm9h
-----END PGP SIGNATURE-----
