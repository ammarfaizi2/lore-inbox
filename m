Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbUKJNDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUKJNDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUKJNDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:03:13 -0500
Received: from bay22-f22.bay22.hotmail.com ([64.4.16.72]:10933 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261788AbUKJNDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:03:09 -0500
X-Originating-IP: [24.91.61.77]
X-Originating-Email: [jwseigh_055@hotmail.com]
From: "Joseph Seigh" <jwseigh_055@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Futex wake behavior question
Date: Wed, 10 Nov 2004 08:02:56 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY22-F224OPXok84FT00006346@hotmail.com>
X-OriginalArrivalTime: 10 Nov 2004 13:03:02.0757 (UTC) FILETIME=[9C8F4950:01C4C725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2nd try at posting this.  from different email acct this time)

I have a question about futex wake behavior.  On a uniprocessor is
it supposed to preempt the caller and dispatch the woken thread if
all threads in question have equal priority?

I was playing around with an experimental lock-free implementation
of condvars (no internal lock) and I got a 30% performance improvement
over NPTL's implementation which I didn't expect since the mutex the
condvar is bound to tends to be the gating factor.  I did getrusage()
to get some stats and noticed the context switching was proportional
to the condvar signaling, the difference between the NPTL and lock-free
versions being one context switch which I attribute to NPTL's internal
mutex.

As a side note, since wait morphing doesn't appear to be currently
implemented in NPTL, you get a performance boost from signaling while
not holding the mutex since the first thing the woken thread does is
try to get the lock.  Even with this technique, the lock-free condvar
does better.

This behavior would also cause problems for semaphores and tend to turn
semaphore calls into expensive coroutine calls.

So the question is, is this a feature or a bug?  I'm on Suse 9.2 on
a uniprocessor.  The kernel is 2.6.8-24 and NPTL is 2.3.3.


Joe Seigh

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

