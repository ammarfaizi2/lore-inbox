Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269890AbUJMWrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269890AbUJMWrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269897AbUJMWrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:47:33 -0400
Received: from mail.inter-page.com ([12.5.23.93]:27148 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S269890AbUJMWrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:47:02 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Ankit Jain'" <ankitjain1580@yahoo.com>,
       "'linux'" <linux-kernel@vger.kernel.org>
Subject: RE: VM Vs Swap Space
Date: Wed, 13 Oct 2004 15:46:43 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdrZR1ip2x0S1aHNr193n7gEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041007091753.34564.qmail@web52903.mail.yahoo.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A long but basic explanation of the difference between "Virtual Memory" and "Swap
Space" follows:

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Ankit Jain
Sent: Thursday, October 07, 2004 2:18 AM
To: linux
Subject: VM Vs Swap Space

> (1)can I say that swap area created by linux is 
> nothing but virtual memory.

It is initially appealing to make this observation, but "swap space" is not "virtual
memory" in exactly the same sense that "disk space" is not "files".  When you create
(and mount) swap space you are reserving storage that the kernel *may* use to
temporarily store data it cannot afford to lose while managing memory operations.
But aside from being a big pile of potential, it isn't really anything...

> (2)is it correct to use the term(s) interchangeably

No.  These terms are often used interchangeably in Windows documentation. This is
largely an error that comes from the days when all operations in windows were part of
a singular memory map.  The confusion is carried forward today as a fossil.

The system (linux/windows/whatever) can have, need, and use virtual memory features
with no "swap space" whatsoever.  The only real feature of virtual memory is the idea
that "where something is really stored" is not the same thing as where something (a
program/process/whatever) appears to be stored.  This can happen usefully even when
it is all taking place in RAM (memory).

Imagine a computer with only five pages of memory.  Imagine a moment when pages 1 3
and 5 are in use, and the system needs to load a program that is two pages long.  In
the absence of virtual memory, that program couldn't be loaded because the two
available pages (2 and 4) are not "next to each other" so the program would be broken
in half.

In that same computer *with* virtual memory, the computer can create the "imaginary"
pages 6 and 7.  The "virtual memory management hardware" takes the imaginary page 6
and maps it over page 4, and the imaginary page 7 and maps it over page 2.  Those two
pages (6 and 7) are "next to each other" in virtual memory (even though the "real
pages" are not) and so could hold a two-page-long program.

Fundamentally, the best way to think about the term "virtual memory" is that a
virtual memory system insulates the way a task/program/programmer needs to see memory
from the way the hardware has memory actually arranged.

So the virtual memory system is playing a card game, where it is shuffling real
storage into place in various virtual/imaginary sets.

Now, in the same way that you, were you playing a game with hundreds of cards, would
like to be able to put some cards aside while sorting through things so that you can
handle the most important cards in play; the computer sometimes would like to put
aside pages of memory that are valid, but that nobody seems to need just now.

A swap file (which is also called a "paging file" in some systems) represents a place
where the system (linux/windows/whatever) can set aside (swap out) the data from a
page of real RAM memory, so that it can reuse that piece of real memory for another
purpose.

If the program that "owns" the original data tries to get to it a "page fault"
happens and the system finds a (usually different) page of real memory that isn't in
use (or that can be swapped out) and puts the data back (swaps) in this original data
page into the new place, and makes that new/other piece of RAM appear (to the
program) as if it had always been there and that it didn't move at all.

There are *LOTS* of other uses for Virtual Memory that have _nothing_ to do with the
swap file.  Things like "sharing code" so that if 20 people are using a program the
computer doesn't actually have to have 20 copies of it in 20 different places in
memory.  Things like being able to give the "screen memory" to a program to write to
directly, without having to "reserve a hole" for the screen memory in every program.
Things like copy-on-write where you share something until you want to change part of
it, and then the system "magically" makes a private copy of the page containing the
part you changed without it suddenly changing out from under (and crashing) another
program.

"Virtual Memory" is a short-hand name for either the task of making and maintaining
these logical maps/chunks, or the name for any one consistent logical chunk when seen
from inside.  If phrase is used without enough context it can get meaningless.  But
in no meaningful case is it "interchangeable" with the term "swap space".

