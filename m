Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTHVE3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 00:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTHVE3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 00:29:32 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:53000 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S263016AbTHVE3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 00:29:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Fri, 22 Aug 2003 04:28:39 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bi465n$2f1$1@abraham.cs.berkeley.edu>
References: <20030818004313.T3708@schatzie.adilger.int> <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1061526519 2529 128.32.153.211 (22 Aug 2003 04:28:39 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 22 Aug 2003 04:28:39 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang  wrote:
>On Mon, 18 Aug 2003, Andreas Dilger wrote:
>> It wasn't even vanishingly small...  We had a problem in our code where
>> two readers got the same 64-bit value calling get_random_bytes(), and
>> we were depending on this 64-bit value being unique.  This problem was
>> fixed by putting a spinlock around the call to get_random_bytes().
>
>if the number is truely random then there should be a (small but finite)
>chance that any two reads will return the same data. counting on a random
>number to be unique is not a good idea.

Have you ever worked out how small a number 2^-64 is?
You might be surprised.  For most practical purposes, 2^-64 is
effectively zero.

If you see a 64-bit values repeat twice in a row when querying a
cryptographic pseudorandom generator, the crypto-PRNG is almost surely
broken.
