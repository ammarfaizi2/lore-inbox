Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbTIJJAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTIJJAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:00:15 -0400
Received: from hal-5.inet.it ([213.92.5.24]:39596 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S264767AbTIJJAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:00:10 -0400
Message-ID: <014a01c3777a$8a2b12e0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <1063142262.30981.17.camel@dhcp23.swansea.linux.org.uk> <014201c3771d$4e95c160$36af7450@wssupremo> <1063149117.31269.24.camel@dhcp23.swansea.linux.org.uk>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 11:04:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The question (for smaller messages) is whether this is a win or not.
> While the data fits in L1 cache the copy is close to free compared
> with context switching and TLB overhead

I can answer for messages of 512 bytes (that I consider small).
This is the smallest case considered in the work.

Completion times in this case are reported in graphs:
you have the time of write() on pipe,
of SYS V shmget() and of new primitives.
It's easy to compare numbers and to say if it is "a win or not".

Surely, transferring bytes from a cache line to another is at zero cost
(that is, a single clock cycle of the cache unit).
But here, how can you matematically grant that,
using traditional IPC mechanism,
you'll find the info you want directly in cache?
This is quite far from being realistic.

In real world, what happens is that copying a page memory
raises many cache faults... at least, more that copying a capability
structure
(16 bytes long, as reported in the article).

Of course, if you want to send a single int,
probably you don't have any reason to use capability.
That's sure.

> Ok - from you rexample I couldnt tell if B then touches each byte of
> data as well as having it appear in its address space.

It is irrilevant. The time reported in the work are the time needed
to complete the IPC primitives.
After a send or a receive over the channel,
the two processes may do everything they want.
It is not interesting for us.

Bye,
Luca

