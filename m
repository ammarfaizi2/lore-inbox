Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVL2VDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVL2VDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVL2VDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:03:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41609 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750975AbVL2VDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:03:42 -0500
Date: Thu, 29 Dec 2005 22:03:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/13] mutex subsystem, -V9
Message-ID: <20051229210308.GA665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is version -V9 of the generic mutex subsystem. It consists of the 
following 13 patches:

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
  xfs-use-mutexes.patch
  vfs-i-sem-to-mutex.patch
  vfs-use-more-mutexes.patch

the patches are against Linus' latest GIT tree, and they should work 
fine on every Linux architecture.

i have tested all 5 mutex implementation variants under MUTEX_DEBUG_FULL 
on x86: native, -dec, -xchg, -null and debug.

Changes since -V8:

 93 files changed, 502 insertions(+), 500 deletions(-)

- ARMv6: __mutex_fastpath_trylock micro-optimization (Nicolas Pitre)

- asm-generic/mutex-xchg.h: better __mutex_fastpath_trylock 
  implementation (Nicolas Pitre)

- XFS: use mutexes directly (Jes Sorensen)

- experimental conversion of VFS: change i_sem to i_mutex (Jes Sorensen)

	Ingo
