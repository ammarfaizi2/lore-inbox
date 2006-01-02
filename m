Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWABQdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWABQdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWABQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:33:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64467 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750810AbWABQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:33:43 -0500
Date: Mon, 2 Jan 2006 17:33:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/19] mutex subsystem, -V10
Message-ID: <20060102163324.GA31501@elte.hu>
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

this is version -V10 of the generic mutex subsystem. It consists of the 
following 19 patches:

  add-atomic-xchg.patch
  add-function-typecheck.patch

  mutex-generic-asm-implementations.patch
  mutex-asm-mutex.h-i386.patch
  mutex-asm-mutex.h-x86_64.patch
  mutex-asm-mutex.h-arm.patch
  mutex-arch-mutex-h.patch
  mutex-core.patch

  mutex-docs.patch
  mutex-debug.patch
  mutex-debug-more.patch

  sem2mutex-xfs.patch
  sem2mutex-vfs-i-sem.patch
  sem2mutex-vfs-i-sem-more.patch
  sem2mutex-simple-ones.patch

  sem2completion-sx8.patch
  sem2completion-cpu5wdt.patch
  sem2completion-ide-gendev.patch
  sem2completion-loop.patch

the patches are against 2.6.15-rc7, and they should work fine on every 
Linux architecture. They can also be downloaded from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

i have tested all 5 mutex implementation variants under MUTEX_DEBUG_FULL 
on x86: native, -dec, -xchg, -null and debug. I have also boot-tested 
x86_64 native mutexes.

Changes since -V9:

  136 files changed, 1172 insertions(+), 1041 deletions(-)

- function-typechecking cleanup (Chuck Ebbert)

- added "From:" attribution lines. (the S-o-b lines were OK.)

- added Arjan's mass conversion which converts simple semaphore users to 
  mutexes: all the use is within a single .c file, the semaphore was 
  declared static, and all down()+up() uses are within a single 
  function. These conditions were reviewed manually, and conversion was 
  generated automatically via a script.

- semaphore to completion: CPU3WDT (Steven Rostedt)
- semaphore to completion: SX8 (Steven Rostedt)
- semaphore to completion: IDE ->gendev_rel_sem (Aleksey Makarov)
- semaphore to completion: drivers/block/loop.c

- updates to Documentation/mutex-design.txt

- added __mutex_fastpath_lock_retval to asm-x86_64/mutex.h

- converted ipc/mqueue.c and security/inode.c to ->i_mutex

- more header file cleanups

	Ingo
