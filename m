Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUHNEpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUHNEpd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 00:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUHNEpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 00:45:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48532 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265211AbUHNEpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 00:45:31 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040813104817.GI8135@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe>  <20040813104817.GI8135@elte.hu>
Content-Type: text/plain
Message-Id: <1092458772.803.64.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 00:46:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 06:48, Ingo Molnar wrote:
> ok, it seems the lock-break of the outer loop was not enough - the up to
> 1024 iterations in the inner loop can generate quite high latencies too.
> 

In some of the traces, like this one:

http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7#/var/www/2.6.8-rc4-bk3-O7/mount_reiserfs_latency_trace.txt

there are calls to voluntary_resched.  How is this possible?  Does it
mean that we called voluntary_resched while holding a spinlock, where we
needed to call voluntary_preempt_lock(&foo_lock), and thus failed to
reschedule?

Lee

