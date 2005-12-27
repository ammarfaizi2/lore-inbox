Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVL0OP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVL0OP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVL0OP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:15:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:22974 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932320AbVL0OP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:15:57 -0500
Date: Tue, 27 Dec 2005 15:15:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/11] mutex subsystem, -V8
Message-ID: <20051227141506.GA6660@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is version -V8 of the generic mutex subsystem. It consists of the 
following 11 patches:

  add-atomic-xchg.patch
  mutex-generic-asm-implementations.patch
  mutex-asm-mutex.h-i386.patch
  mutex-asm-mutex.h-x86_64.patch
  mutex-asm-mutex.h-arm.patch
  mutex-arch-mutex-h.patch
  mutex-core.patch
  mutex-docs.patch
  mutex-debug.patch
  mutex-debug-more.patch
  xfs-mutex-namespace-collision-fix.patch

the patches are against Linus' latest GIT tree, and they should work 
fine on every Linux architecture.

i have tested all 5 mutex implementation variants under MUTEX_DEBUG_FULL 
on x86: native, -dec, -xchg, -null and debug.

Changes since -V7:

 11 files changed, 258 insertions(+), 122 deletions(-)

- added a __mutex_fastpath_trylock(count, fn) method for architectures 
  to define a trylock fastpath.

  While trylock has no 'slowpath' in the classic sense, but e.g. the 
  ARMv6 fastpath implementation can 'fail' to take the lock 
  speculatively, and has to call back into the generic code in that 
  case, to guarantee that the trylock is actually attempted. The debug 
  and xchg variant also makes use of the generic code, unconditionally.  

  The ARMv6 fastpath implementation is from Nicolas Pitre.

  this change gets rid of the final #ifdefs from the core kernel/mutex.c
  code, and makes it squeeky clean ;-)

- inline mutex_is_locked() (Nicolas Pitre)

- more cleanups (of assembly code in particular).

	Ingo
