Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263917AbTDVX14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTDVX1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:27:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14280 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263917AbTDVX1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:27:55 -0400
Message-Id: <200304222338.h3MNcHI01727@owlet.beaverton.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: several messages 
In-reply-to: Your message of "Tue, 22 Apr 2003 18:16:29 EDT."
             <Pine.LNX.3.96.1030422180002.31749C-100000@gatekeeper.tmr.com> 
Date: Tue, 22 Apr 2003 16:38:15 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Have you done any tests with a threaded process running on a single CPU in
    the siblings? If they are sharing data and locks in the same cache it's
    not obvious (to me at least) that it would be faster in two CPUs having to
    do updates. That's a question, not an implication that it is significantly
    better in just one, a threaded program with only two threads is not as
    likely to be doing the same thing in both, perhaps.

True.  I have a hunch (and it's only a hunch -- no hard data!) that
two threads that are sharing the same data will do better if they can
be located on a physical/sibling processor group.  For workloads where
you really do have two distinct processes, or even threads but which are
operating on wholly different portions of data or code, moving them to
separate physical processors may be warranted.  The key is whether the
work of one sibling is destroying the cache of another.

Rick
