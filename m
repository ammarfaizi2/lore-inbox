Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSGRAmn>; Wed, 17 Jul 2002 20:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSGRAmn>; Wed, 17 Jul 2002 20:42:43 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:50952 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S317078AbSGRAmm>; Wed, 17 Jul 2002 20:42:42 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: BKL removal
Date: 18 Jul 2002 00:30:47 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ah527n$brv$1@abraham.cs.berkeley.edu>
References: <20020709201703.GC27999@kroah.com> <3D2AF10A.1020603@us.ibm.com> <1026250151.1623.1185.camel@sinai> <3D2AF6EA.1030008@us.ibm.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1026952247 12159 128.32.153.211 (18 Jul 2002 00:30:47 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 18 Jul 2002 00:30:47 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen  wrote:
>The Stanford Checker or something resembling it would be invaluable 
>here.  It would be a hell of a lot better than my litle patch!

Hmm.  There's a chance we might be able to help.  Our group is building
a tool called MOPS that is similar in spirit to the Stanford Checker.
MOPS is work-in-progress and will be open source.  I haven't tried it
yet on the Linux kernel, but this seems like a reasonable thing to try.

What would you want to check?  Track lock_kernel() and unlock_kernel()
and make sure that the BKL is never held when you return from a function?
Something else?

MOPS can handle nested and recursive functions nicely.  However, it has
some important limitations:
 * Useability hasn't been a focus yet; the input language is
   not terribly elegant, and the output language is not exceptionally
   friendly.  (yet)
 * It currently ignores function pointers.  (yet)
 * #ifdefs are trouble; we only analyzed pre-processed C code.
 * It can't reason about data, variables, or values on the heap.
We're working hard on useability.  We may fix the second limitation
in future months.  However, the latter two are unlikely to go away in
the foreseeable future.  Would it still be worth investigating MOPS,
despite these limitations?

The MOPS web page is at
 http://www.cs.berkeley.edu/~daw/mops/
There is an initial release there, though it has some known problems.
We're working hard to making it more usable, and I hope to be able to
report more progress in upcoming months.
