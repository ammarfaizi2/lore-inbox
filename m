Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752147AbWJNKwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbWJNKwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWJNKwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:52:36 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:60296 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1752148AbWJNKwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:52:35 -0400
Message-Id: <4530CF770200007800024388@emea5-mh.id5.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Sat, 14 Oct 2006 12:52:20 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <mingo@elte.hu>, <akinobu.mita@gmail.com>, <akpm@osdl.org>
Cc: <dwm@meer.net>, <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/7] fault-injection capabilities (v5)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't feel much slowness with STACKTRACE & FRAME_POINTER and
>> enabling stacktrace filter. But with enabling STACK_UNWIND I feel
>> big latency on X. (There are two type of implementation of stacktrace
>> filter in it [1] using STACKTRACE with FRAME_POINTER, and [2] STACK_UNWIND)
>> 
>> I don't know why there is quite difference between simple STACKTRACE and
>> STACK_UNWIND. I'm about to try to use rb tree rather than linked list in
>> unwind.
>
>umm, we've hit this before, recently - iirc it was making lockdep run
>really slowly.
>
>The new unwinding code is apparently really inefficient in some situations.
>It wasn't expected that it would be called at a high frequency, except people
>_do_ want to do that.
>
>I forget the details, but I can cc people who have better memory.

The problem is that there's currently nothing to allow a binary search through
the unwind descriptors. The easy path to add these is closed as binutils don't
work here due to two independent limitations. Hence I'm going to add a two-
phase initializations, the second part of which will allocate and initialize a
helper table equivalent to a linker generated .eh_frame_hdr section. I'm not
certain at this point whether we'll need this for modules too.

Jan
