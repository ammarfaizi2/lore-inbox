Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030566AbVLWQRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbVLWQRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVLWQRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:17:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42146 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932492AbVLWQRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:17:54 -0500
Date: Fri, 23 Dec 2005 17:16:49 +0100
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
Subject: [patch 00/11] mutex subsystem, -V7
Message-ID: <20051223161649.GA26830@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is version -V7 of the generic mutex subsystem. It consists of the 
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

Changes since -V6:

 33 files changed, 515 insertions(+), 360 deletions(-)

- added asm-arm/mutex.h ARM mutex fastpath implementation,
  by Nicolas Pitre.

- as per Linus' suggestion, split up the mutex debugging code and 
  prototypes into 4 separate files: kernel/mutex.c, kernel/mutex.h, 
  kernel/mutex-debug.c and kernel/mutex-debug.h, and made the debugging 
  code build as kernel/mutex-debug.o. As a result mutex.c got smaller 
  and easier to read. This also eliminated an #ifdef.

- added a new "NULL mutex fastpath implementation" via
  asm-generic/mutex-null.h, which is now used by the debugging code.  
  This got rid of two ugly #ifdef's in mutex.c, and removed code as 
  well.

- comment cleanups by Nicolas Pitre.

- more doc/comment additions and updates.

- lots of code and style cleanups in various mutex headers.

	Ingo
