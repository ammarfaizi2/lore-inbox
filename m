Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUK2Xm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUK2Xm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUK2Xm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:42:58 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:56068 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261845AbUK2Xm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:42:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Concurrent access to /dev/urandom
Date: Mon, 29 Nov 2004 23:42:12 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cogc4k$klj$1@abraham.cs.berkeley.edu>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <35fb2e5904112914476df48518@mail.gmail.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1101771732 21171 128.32.168.222 (29 Nov 2004 23:42:12 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 29 Nov 2004 23:42:12 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters  wrote:
>On Sat, 27 Nov 2004 15:45:49 -0500, Bernard Normier <bernard@zeroc.com> wrote:
>> I use /dev/urandom to generate UUIDs by reading 16 random bytes from
>> /dev/urandom (very much like e2fsprogs' libuuid).
>
>Why not use /dev/random for such data instead?

Because /dev/urandom is the right thing to use, and /dev/random is not.

>/dev/urandom suffers from a poor level of entropy if you keep reading
>from it over and over again whereas the alternative can block until it
>has more randomness available.

That's not accurate.  Once it has been properly seeded, /dev/urandom
should be fine for this purpose (assuming no root compromise).  Because
/dev/urandom uses a cryptographically secure PRNG, once it has been securely
seeded with (say) 128 bits of secure entropy, you can generate as much
pseudorandom output as you like without worries (unless someone breaks
the crypto, which is usually considered unlikely).  If the crypto is secure
and /dev/urandom is properly seeded, then its pseudorandom output is
indistinguishable from true random bits; this is true even if you extract
millions of pseudorandom bits.  "Entropy" is often a misleading notion,
when you are dealing with cryptographic PRNGs and computationally bounded
adversaries.
