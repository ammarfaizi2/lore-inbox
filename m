Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRCUMNp>; Wed, 21 Mar 2001 07:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCUMNf>; Wed, 21 Mar 2001 07:13:35 -0500
Received: from chiara.elte.hu ([157.181.150.200]:3859 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131346AbRCUMNV>;
	Wed, 21 Mar 2001 07:13:21 -0500
Date: Wed, 21 Mar 2001 13:11:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] pagecache SMP-scalability patch [was: spinlock usage]
In-Reply-To: <20010321180607.A11941@linuxcare.com>
Message-ID: <Pine.LNX.4.30.0103211301530.5270-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton,

if you are doing SMP-intensive dbench runs, then check out the SMP
pagecache-scalability patch (against 2.4.2-ac20):

  http://people.redhat.com/~mingo/smp-pagecache-patches/pagecache-2.4.2-H1

this patch splits up the main scalability offender in non-RAM-limited
dbench runs, which is pagecache_lock. The patch was designed and written
by David Miller, and is being forward ported / maintained by me. (The new
pagecache lock design is similar to TCP's hashed spinlocks, which proved
to scale excellently.)

(about lstat(): IMO lstat() should not call into the lowlevel FS code.)

	Ingo

