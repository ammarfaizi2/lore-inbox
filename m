Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWBPJnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWBPJnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWBPJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 04:43:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:45519 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750777AbWBPJnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 04:43:13 -0500
Date: Thu, 16 Feb 2006 10:41:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060216094130.GA29716@elte.hu>
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

This is release -V3 of the "lightweight robust futexes" patchset. The 
patchset can also be downloaded from:

  http://redhat.com/~mingo/lightweight-robust-futexes/

Changes since -V2:

Ulrich Drepper ran the code through more glibc testcases, which 
unearthed a couple of bugs:

 - fixed bug in the i386 and x86_64 assembly code (Ulrich Drepper)

 - fixed bug in the list walking futex-wakeups (found by Ulrich Drepper)

 - race fix: do not bail out in the list walk when the list_op_pending 
   pointer cannot be followed by the kernel - another userspace thread 
   may have already destroyed the mutex (and unmapped it), before this 
   thread had a chance to clear the field.

 - cleanup: renamed list_add_pending to list_op_pending. (the field is 
   used for list removals too)

	Ingo
