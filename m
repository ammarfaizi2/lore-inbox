Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUDJK1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 06:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDJK1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 06:27:54 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:47657
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S261989AbUDJK1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 06:27:52 -0400
thread-index: AcQe5s+Vfp+wottuSYKsMoPi1RUdlQ==
X-Sieve: Server Sieve 2.2
Subject: Re: want to clarify powerpc assembly conventions in head.S andentry.S
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <Administrator@vger.kernel.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Message-ID: <000001c41ee6$cf977ee0$d100000a@sbs2003.local>
In-Reply-To: <4077A542.8030108@nortelnetworks.com>
References: <4077A542.8030108@nortelnetworks.com>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Apr 2004 11:30:14 +0100
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
Content-Class: urn:content-classes:message
X-me-spamlevel: not-spam
Importance: normal
X-me-spamrating: 6.105649
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 10 Apr 2004 10:30:14.0781 (UTC) FILETIME=[CF9EAAD0:01C41EE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2004-04-10 at 17:41, Chris Friesen wrote:
> I'm doing some work in head.S and entry.S, and I just wanted to make
> sure that I had the conventions down.
>
> According to the docs I read, r0 and r3-12 are caller-saves.  They seem
> to be saved in EXCEPTION_PROLOG_2 (head.S) and restored in
> ret_from_except() (entry.S).  Thus, if I add code in entry.S I should be
> able to use any of those registers, without having to worry about
> restoring them myself--correct?

Yes. For interrupts or faults that's right. Syscalls are a bit special
though.

> Also, I'm a bit confused about the three instances of the following line
> in entry.S:
>
> 	stwcx.	r0,0,r1			/* to clear the reservation */
>
> I don't see the corresponding lwarx instruction.  What reservation is it
> referring to?

This is to clear any possible pending reservation if any. The problem is
that the reservation mecanism only works accross multiple CPUs. A normal
store at an address covered by a reservation on the same CPU will not break
the reservation. Thus, to protect from that, any interrupt or exception
makes sure to return to the normal code flow with any pending reservation
cleared.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


