Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968236AbWLEEDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968236AbWLEEDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968270AbWLEEDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:03:07 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:47798 "EHLO
	ms-smtp-03.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968268AbWLEEDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:03:05 -0500
Message-Id: <200612050402.kB542no9004124@ms-smtp-03.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Mon, 4 Dec 2006 22:02:48 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AccXta4N0od24X+lSR6fbQnGxGZ37AAaSYXA
In-Reply-To: <457438E9.1010503@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nick Piggin [mailto:nickpiggin@yahoo.com.au]
> I'd be interested to know how OOM and page reclaim behaves after these
> patches
> (or with a newer kernel).

We didn't get far today. The various suggestions everyone has for solving
this problem spurred several new discussions inside the office and raised
more questions. At the heart of the problem Andrew is right, heavy handed
tactics to force limits on page cache don't solve anything and may just
squeeze the problem to new areas. Modifying tar is really a band aid and not
a solution, there is still a fundamental problem with memory management in
this setup.

Nick suggested the possibility of a patching the kernel or upgrading to a
new kernel. Linus made the suggestion of dialing the value of
min_free_kbytes down to match something more in line with what might be
expected in a system with 400MB memory as a way to possibly make VM or at
least a portion of VM simulate a restricted amount of memory. And, I have
seen a couple suggestions about creating a new proc vm file to do things
like tweak max_buffer_heads dynamically.

So here's a silly (crazy) question (or two).

If I'm going to go through all the trouble to change the kernel and maybe
create a new proc file how much code would I have to touch to create a proc
file to set something like, let's say, effective memory and have all the vm
calculations use effective memory as the basis for swap and cache
calculations? And can I stop at the vm engine or does the sprawl farther
out? To the untrained mind it seems like this might be the best of both
worlds. It sounds like it would allow an embedded system like ours to set
aside a chunk of ram for a special purpose and designate a sandbox for the
OS. I am, of course, making the *bold* assumption here that a majority of
the vm algorithms are based off something remotely similar to a value which
represents physical memory.

Thoughts? Stones?


