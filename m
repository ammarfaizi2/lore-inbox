Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271025AbTHKE7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271032AbTHKE7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:59:12 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:45069 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S271025AbTHKE7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:59:11 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Mon, 11 Aug 2003 04:58:33 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bh77pp$rhq$1@abraham.cs.berkeley.edu>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1060577913 28218 128.32.153.211 (11 Aug 2003 04:58:33 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 11 Aug 2003 04:58:33 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier  wrote:
>If you return xy, you are returning a strong digest of the pool state.
>Even with the backtrack-prevention, if the attacker reads 20 bytes
>from /dev/random and sees a _recognised_ pattern, they immediately
>know the entire state of the secondary pool.

Irrelevant.  I think you missed something.

If you pick a pattern in advance, the chance that your pattern appears
at the output of SHA1 is about 2^-160 (assuming SHA1 is secure).  If you
pick 2^50 patterns (that takes an awfully big RAID array to store them
all!), then the chance that your pattent appears at the output of SHA1
is 2^-110.  If you pick 2^50 patterns and poll /dev/urandom 2^50 times
to get 2^50 outputs, the chance that one of your patterns appears as one
of the /dev/urandom outputs is only 2^-60.  In other words, your attack
has a success probability that is truly negligible.

You might as well argue that "if a cosmic ray hits memory and turns off
/dev/urandom, then things will fail".  This is such an unlikely event
that we all ignore it.  Likewise, the risk of special patterns appearing
at the output of SHA1 is also so unlikely that it can also be ignored.
