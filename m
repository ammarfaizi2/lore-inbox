Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265716AbUF2LPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbUF2LPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUF2LPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:15:35 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:50088 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265716AbUF2LPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:15:13 -0400
Message-ID: <40E14F28.6030408@kolivas.org>
Date: Tue, 29 Jun 2004 21:14:48 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <200406070139.38433.kernel@kolivas.org> <20040629111017.GB15414@elf.ucw.cz>
In-Reply-To: <20040629111017.GB15414@elf.ucw.cz>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
| Hi!
|
|
|>This is an update of the scheduler policy mechanism rewrite using the
|>infrastructure of the current O(1) scheduler. Slight changes from the
|>original design require a detailed description. The change to the
original
|>design has enabled all known corner cases to be abolished and cpu
|>distribution to be much better maintained. It has proven to be stable
in my
|>testing and is ready for more widespread public testing now.
|>
|>
|>Aims:
|> - Interactive by design rather than have interactivity bolted on.
|> - Good scalability.
|> - Simple predictable design.
|> - Maintain appropriate cpu distribution and fairness.
|> - Low scheduling latency for normal policy tasks.
|> - Low overhead.
|> - Making renicing processes actually matter for CPU distribution
(nice 0 gets
|>20 times what nice +20 gets)
|> - Resistant to priority inversion
|
|
| How do you solve priority inversion?

I don't solve it. It is relatively resistant to priority inversion by
tasks traversing all the priorities lower than itself rather than
sitting at one priority. It does this more strictly when interactive is
disabled which I recommend for server and multiuser setups.

| Can you do "true idle threads" now? (I.e. nice +infinity?)

Not safely, no. I have a batch(idle) implementation that is relatively
safe but can be abused (it's in my -ck patchset only). At some stage if
the codebase settles down enough I'll try and introduce semaphore
tracking for batch processes that will elevate them to normal scheduling
~ to prevent DoSing.

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4U8oZUg7+tp6mRURAircAKCSvuZ4D6rM7AsfAbHKhQoCw1C7NACaA44C
UyUJAByRIE894CchzlN2OiU=
=9xVI
-----END PGP SIGNATURE-----
