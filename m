Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJ2KVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTJ2KVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 05:21:20 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:14341 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262041AbTJ2KVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 05:21:18 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8/test9 repeatable lockups at high loads - please reproduce
Date: Wed, 29 Oct 2003 18:21:04 +0800
User-Agent: KMail/1.5.2
References: <200310280544.33247.mhf@linuxmail.org>
In-Reply-To: <200310280544.33247.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291821.04864.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And in case you ask...

15) Why is it done this way
---------------------------

Experience shows that randomness of activities and events over a broad spectrum
cause substantial stress in any system.

A simple example is the fact that an instable system often can perform one
function at a time (such as run an editor or a single compiler wo make), but
fails when several tasks are demanded such as building a kernel.

Another example is the 68000 based STD bus system which could run multiuser
turbodos perfectly but died with version 7 because the powersupply could not
handle the random fluctuations of power consumption and started oscillating
and going out of spec. The local unix guru at the time always said "you listen
it makes noise like doors on the enterprise" ;) and hooking up a storage scope
validated his opinion after some time and trial. Interestingly even some bad
grounding (loops) of the 10MB 8" drive made trouble specific to V7.

When developing tests for swsusp, criteria were applied as follows
- randomness was of first interest
- the desire to excercise a broad spectrum of system functions was next
- the desire to utilize mature functionality in order not to reinvent the wheel
- software must be available freely

The ancient unixbench suite meets these requirements and is complemented
by make, gcc for generic user level stress and dd for brute force IO loads.
A little bit of bash scripting completes the test suite.

It is noted that the CPU related unixbench functions such as dhrystone,
whetstone, etc are not used here as these have shown to do little more than burn
processor clocks on-die. A  bad (CPU) chip being used according to datasheet
is a tiny fraction of 1 in millions and we do not want to test for this anyway.

As to randomness, unixbench tests are timed, but by asynchronous events the
timing is not perfect, thus several of these tests gradually drift relative to
each other and greatly interfere looking from the system(call) perspective.

Opinion of the gut, and experience with failures is that the  spectrum of tests
excercises most system functions heavily.

The tests have however not been profiled as I have not yet learned how to use
profiling. There is always too much to do.

