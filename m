Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbRCPU5b>; Fri, 16 Mar 2001 15:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCPU5V>; Fri, 16 Mar 2001 15:57:21 -0500
Received: from nrg.org ([216.101.165.106]:20838 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131315AbRCPU5J>;
	Fri, 16 Mar 2001 15:57:09 -0500
Date: Fri, 16 Mar 2001 12:56:26 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Locking question (was: [CHECKER] 9 potential copy_*_user bugs in
 2.4.1)
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.05.10103161233570.6616-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Dawson Engler wrote:
> 	2.  And, unrelated:  given the current locking discipline, is
> 	it bad to hold any type of lock (not just a spin lock) when you
> 	call a potentially blocking function?  (It at least seems bad
> 	for performance, since you'll hold the lock for milliseconds.)

In general, yes.  The lock may be held for much longer than milliseconds
if the potentially blocking function is waiting for I/O from a network,
or a terminal, potentially causing all threads to block on the lock
until someone presses a key, in this extreme example.  If the lock is a
spinlock, then complete deadlock can occur.

You're probably aware that semaphores are used both as blocking mutex
locks, where the down (lock) and up (unlock) calls are made by the same
thread to protect critical data, and as a synchronization mechanism,
where the down and up calls are made by different threads.   The former
use is a "lock", while the latter down() use is a "potentially blocking
function" in terms of your question.  I don't know how easy it would be
for your analysis tools to distinguish between them.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

