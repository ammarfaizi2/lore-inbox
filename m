Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVLUSHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVLUSHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVLUSHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:07:54 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:44258 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751155AbVLUSHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:07:52 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
References: <20051221155411.GA7243@elte.hu>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 21 Dec 2005 13:07:48 -0500
In-Reply-To: <20051221155411.GA7243@elte.hu>
Message-ID: <yq0irtiuxvv.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> this is the latest version of the mutex subsystem
Ingo> patch-queue. It consists of the following patches:

[snip]

Ingo> the patches are against Linus' latest tree, and were tested on
Ingo> i386, x86_64 and ia64. [the tests were also done in
Ingo> DEBUG_MUTEX_FULL mode, to make sure the code works
Ingo> fine. MUTEX_FULL support is not included in this patchqueue].

Hi,

I have been working with Ingo on porting this to ehe ia64 and run a
bunch of benchmarks using the DEBUG_MUTEX_FULL settings to see how it
behaves on various sized systems (8, 24 and 60 CPUs). In general I am
seeing speedups of roughly a factor 4 on XFS and 2.4 on TMPFS.

Below you will find the results. It's basically the same kernel
version with and without the mutex patch running in DEBUG_MUTEX_FULL
mode without debugging enabled. No other config options were changed.

I won't rule out any pilot errors, but at least it gives an idea about
the change in performance for a specific workload on different sized
boxes.

Cheers,
Jes


All tests on 2.6.15-rc6 with and without the mutex patch, using the
same test app used by Ingo. MUTEX refers to the mutex kernel and the
'no mutex' numbers are for the regular kernel.

I have run the tests on the following systems:

8-way system  (1.3GHz ia64)
24-way system (1.3GHz ia64)
60-way system (1.5GHz ia64)
===========================

Tests on XFS               MUTEX              NO MUTEX

8 CPUs, running 16 parallel test-tasks.
avg ops/sec:               173589             43136
average cost per op:       80.97 usecs        327.03 usecs
average cost per lock:     79.69 usecs        325.20 usecs
average cost per unlock:    1.28 usecs          1.83 usecs
average deviance per op:   65.75 usecs        191.65 usecs


24 CPUs, running 48 parallel test-tasks.
avg ops/sec:               156312             38976
average cost per op:       277.80 usecs       1087.65 usecs
average cost per lock:     276.06 usecs       1085.43 usecs
average cost per unlock:     1.74 usecs          2.22 usecs
average deviance per op:   229.80 usecs        613.78 usecs


60 CPUs, running 120 parallel test-tasks.
avg ops/sec:               188204             41794
average cost per op:       678.86 usecs	      2538.53 usecs
average cost per lock:     675.56 usecs	      2536.53 usecs
average cost per unlock:     3.29 usecs	         1.99 usecs
average deviance per op:   565.65 usecs	      1584.21 usecs

60 CPUs, running 540 parallel test-tasks.
avg ops/sec:               181230             44757
average cost per op:       3131.09 usecs      10711.06 usecs
average cost per lock:     3128.05 usecs      10709.21 usecs
average cost per unlock:      3.04 usecs          1.86 usecs
average deviance per op:   2525.36 usecs       6787.48 usecs


Tests on TMPFS             MUTEX              NO MUTEX
8 CPUs, running 16 parallel test-tasks.
avg ops/sec:               139621             57817
average cost per op:       100.70 usecs	      243.71 usecs
average cost per lock:      98.54 usecs	      242.28 usecs
average cost per unlock:     2.16 usecs	        1.43 usecs
average deviance per op:    76.03 usecs	      156.32 usecs
