Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289772AbSBEX4a>; Tue, 5 Feb 2002 18:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289871AbSBEX4U>; Tue, 5 Feb 2002 18:56:20 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3223 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289772AbSBEX4E>;
	Tue, 5 Feb 2002 18:56:04 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Feb 2002 00:56:01 +0100 (MET)
Message-Id: <UTC200202052356.g15Nu1w00794.aeb@apps.cwi.nl>
To: hpa@zytor.com
Subject: Re: How to check the kernel compile options ?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > I would be surprised if there is anyone on this list
    > who has not lost at some point either the .config, the
    > ksyms, or something similar associated with at least
    > one build they've made.

    Sure.  And people have lost their root filesystems due to "rm -rf /".
    That doesn't mean we build the entire (real) root filesystem into
    the kernel.

	-hpa

Peter, in my eyes this is an unreasonable answer.

For debugging and other purposes it is good to have some
information. One may wish to know about a certain kernel image
what Linux kernel version that was, with what patches, compiled
with what options, by which compiler. Or one may want to know
such things about the currently running kernel. Even user-space
programs (like mount) may want to know (what NFS version? do we
have CONFIG_JOLIET?).

Today we supply a little of this information.
For example, /proc/version supplies information on version
and compiler and date. Why? One might as well keep this compiler
info in a separate file. What a waste of unswappable kernel memory!

You see - this is not a matter of absolutes.
In the good old days, when an operating system had to fit in 4k
and a device driver in 128 words, putting a 100-char text like
the one found in /proc/version into the system would be ridiculous.
Today nobody worries about a hundred bytes paid for some useful info.

So, the question is: how useful is the information, and how expensive
is it to store it. Consider the config options. How much space do they
take? Typically 1-5 kB (compressed). If this is stored at the end of
a kernel image file, and not loaded into memory, then the kernel memory
cost is zero. If this is made part of the kernel itself, say accessible
via /proc, then the cost is 1-5 kB.

So, you should ponder whether it is worthwhile to pay this cost of zero,
and ponder whether it is worthwhile to pay this cost of 5 kB.

Andries
