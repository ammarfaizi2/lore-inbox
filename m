Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWADOmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWADOmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWADOmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:42:13 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28300 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932557AbWADOmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:42:12 -0500
Date: Wed, 4 Jan 2006 15:41:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060104144151.GA27646@elte.hu>
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


this is version 14 of the generic mutex subsystem, against v2.6.15.

The patch-queue consists of 21 patches, which can also be downloaded 
from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

Changes since -V13:

 13 files changed, 113 insertions(+), 85 deletions(-)

 - VFS: converted sb->s_lock to a mutex too. This improves the
   create+unlink benchmark on ext3.

 - further simplification of __mutex_lock_common(): no more gotos, and
   only one atomic_xchg() is done. Code size is now extremely small on 
   both UP and SMP:

   text    data     bss     dec     hex filename
    398       0       0     398     18e mutex.o.UP

   text    data     bss     dec     hex filename
    463       0       0     463     1cf mutex.o.SMP

 - synchro-test updates: max # of threads of 64, fairness stats,
   better defaults if =y, cleanups. (David Howells, me)

 - FASTCALL -> fastcall in mutex.h (suggested by David Howells)

 - documentation updates

	Ingo
