Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263443AbRFOKgJ>; Fri, 15 Jun 2001 06:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbRFOKf6>; Fri, 15 Jun 2001 06:35:58 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:9090 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263443AbRFOKfo>; Fri, 15 Jun 2001 06:35:44 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <root@chaos.analogic.com>, "Roger Larsson" <roger.larsson@norran.net>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: SMP spin-locks
Date: Fri, 15 Jun 2001 03:35:21 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKGEDMPOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.95.1010614223154.20486A-100000@chaos.analogic.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Spinlocks are machine dependent. A simple increment of a byte
> memory variable, spinning if it's not 1 will do fine. Decrementing
> this variable will release the lock. A `lock` prefix is not necessary
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> because  all Intel byte operations are atomic anyway. This assumes
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> that the lock was initialized to 0. It doesn't have to be. It
> could be initialized to 0xaa (anything) and spin if it's not
> 0xab (or anything + 1).

	If this is true, atomicity isn't enough to do it. Atomicity means that
there's a single instruction (and so it can't be interrupted mid-modify).
Atomicity (at least as the term is normally used) doesn't prevent the
cache-coherency logic from ping-ponging the memory location between two
processor's caches during the atomic operation.

	DS

