Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUF1MLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUF1MLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUF1MLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:11:54 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:25750 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264920AbUF1ML3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:11:29 -0400
Message-ID: <40E00AEA.4050709@kolivas.org>
Date: Mon, 28 Jun 2004 22:11:22 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de>	 <200406261929.35950.mbuesch@freenet.de>	 <1088363821.1698.1.camel@teapot.felipe-alfaro.com>	 <200406272128.57367.mbuesch@freenet.de>	 <1088373352.1691.1.camel@teapot.felipe-alfaro.com>	 <Pine.LNX.4.58.0406281013590.11399@kolivas.org>	 <1088412045.1694.3.camel@teapot.felipe-alfaro.com>	 <40DFDBB2.7010800@yahoo.com.au> <1088423626.1699.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1088423626.1699.0.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Felipe Alfaro Solana wrote:
| On Mon, 2004-06-28 at 18:49 +1000, Nick Piggin wrote:
|
|>Felipe Alfaro Solana wrote:
|>
|>
|>>I have tested 2.6.7-bk10 plus from_2.6.7_to_staircase_7.7 patch and,
|>>while it's definitively better than previous versions, it still feels a
|>>little jerky when moving windows in X11 wrt to -mm3. Renicing makes it a
|>>little bit smoother, but not as much as -mm3 without renicing.
|>>
|>
|>You know, if renicing X makes it smoother, then that is a good thing
|>IMO. X needs large amounts of CPU and low latency in order to get
|>good interactivity, which is something the scheduler shouldn't give
|>to a process unless it is told to.
|
|
| But the problem here is that -ck3 with X reniced to -10 is not as smooth
| as -mm3 with no renicing. That's what worries me.

The design of staircase would make renicing normal interactive things
- -ve values bad for the latency of other nice 0 tasks s is not
recommended for X or games etc. Initial scheduling latency is very
dependent on nice value in staircase. If you set a cpu hog to nice -5 it
will hurt audio at nice 0 and so on. Nicing latency unimportant things
with +ve values is more useful with this design. If you run X and
evolution at the same nice value they will get equal cpu share for
example so moving windows means redrawing evolution and X moving get
equal cpu. Nicing evolution +ve will make X smoother compared to
evolution redrawing and so on...

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4ArqZUg7+tp6mRURAn2BAJ4hkK871JXO/R3AvwR0CzKoLg6f6wCeNBP/
Y1aOfCWLR5QtVZvq8wdpToI=
=xit3
-----END PGP SIGNATURE-----
