Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTJPVFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTJPVFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:05:46 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:36871 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S263184AbTJPVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:05:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: Thu, 16 Oct 2003 21:03:31 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bmn133$513$1@abraham.cs.berkeley.edu>
References: <3F8E552B.3010507@users.sf.net> <20031016102020.A7000@schatzie.adilger.int> <3F8EC7D0.5000003@pobox.com> <20031016121825.D7000@schatzie.adilger.int>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1066338211 5155 128.32.153.211 (16 Oct 2003 21:03:31 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Thu, 16 Oct 2003 21:03:31 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger  wrote:
>Hmm, so every part of the kernel that doesn't need crypto-secure RNG data
>(i.e. fast and relatively unique) should implement its own hash/PRNG then?
>It isn't a matter of unbreakable crypto, but the fact that we want relatively
>unique values that will not be the same on a reboot.  Currently we do just
>as you propose for our "crappy PRNG", which is "grab 8 bytes via
>get_random_bytes and increment", but that is a little _too_ easy to guess
>(although good enough for the time being).

I guess I don't understand this objection.

I'm having a hard time understanding the requirements for your PRNG.
In one place you say you just want uniqueness, but then in another
place you talk about it being easy to guess.  If all we care about is
uniqueness, why should ease of guessing matter?  I'm confused.

If all we need is uniqueness, then I don't see what's wrong with grabbing
8 bytes from get_random_bytes() and incrementing.  In particular, you
don't need frandom in this case.

If we need both uniqueness and unpredictability, then grab 8 bytes
from get_random_bytes() each time you need a new value.  This will
satisfy both your requirements.  If you truly do need something hard
to guess, nothing less than a full-strength crypto PRNG will suffice.
In particular, frandom won't help you in this case.

What am I missing?
