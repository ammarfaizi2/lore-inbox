Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRDIGZQ>; Mon, 9 Apr 2001 02:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132696AbRDIGZG>; Mon, 9 Apr 2001 02:25:06 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:19725 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S131949AbRDIGYw>;
	Mon, 9 Apr 2001 02:24:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Sources of entropy - /dev/random problem for network servers
Date: 9 Apr 2001 06:17:12 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9ark58$133$1@abraham.cs.berkeley.edu>
In-Reply-To: <1457842476.986773581@[195.224.237.69]>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 986797032 1123 128.32.45.153 (9 Apr 2001 06:17:12 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 9 Apr 2001 06:17:12 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel  wrote:
>In debugging why my (unloaded) IMAP server takes many seconds
>to open folders, I discovered what looks like a problem
>in 2.4's feeding of entropy into /dev/random. When there
>is insufficient entropy in the random number generator,
>reading from /dev/random blocks for several seconds. /dev/random
>is used (correctly) for crytographic key verification.

Use /dev/urandom, or buy a hardware RNG.

>However, only 3 drivers in drivers/net actually set
>SA_SAMPLE_RANDOM when calling request_irq(). I believe
>all of them should. And indeed this fixed the problem for
>me using an eepro100().

This is unsafe.  The time that packets arrive is not secret:
anyone who can run a sniffer on your network can potentially
recover this information.  Thus, such timings are unsuitable
for introduction into the entropy pool.

(More precisely, there's no harm in adding them to the entropy
pool if they are added in a way so that the /dev/random pool
doesn't increment its estimate of how much entropy it has
collected.  The real harm comes when you bump up the randomness
counter based on them, and if I understand your proposed change,
this is what it's doing.)
