Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVLVPiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVLVPiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVLVPiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:38:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21189 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751150AbVLVPiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:38:06 -0500
Date: Thu, 22 Dec 2005 16:37:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/10] mutex subsystem, -V5
Message-ID: <20051222153717.GA6090@elte.hu>
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

this is verion -V5 of the generic mutex subsystem. It consists of the 
following patches:

  add-atomic-xchg.patch
  add-atomic-call-func-i386.patch
  add-atomic-call-func-x86_64.patch
  add-atomic-call-wrappers-rest.patch
  mutex-core.patch
  mutex-docs.patch
  mutex-switch-arm-to-xchg.patch
  mutex-debug.patch
  mutex-debug-more.patch
  xfs-mutex-namespace-collision-fix.patch

the patches are against Linus' latest GIT tree, and they should work 
fine on every Linux architecture.

Changes since -V4:

 26 files changed, 255 insertions(+), 104 deletions(-)

- added Documentation/mutex-design.txt, suggested by Andrew Morton.

- removed __ARCH_WANT_XCHG_BASED_ATOMICS and implemented
  CONFIG_MUTEX_XCHG_ALGORITHM instead, based on comments from
  Christoph Hellwig.

- updated ARM to use CONFIG_MUTEX_XCHG_ALGORITHM.

- added mutex_destroy(), suggested by Christoph Hellwig.

- added queue-secondary-waiters-as-LIFO, suggested by Nick Piggin.

- mutex.h: include file ordering fix (Christoph Hellwig).

- mutex.h: comment fix (Christoph Hellwig).

- mutex.c: smaller cleanups

	Ingo
