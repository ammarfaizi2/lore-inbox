Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUJIEVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUJIEVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 00:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUJIEVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 00:21:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:20125 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266465AbUJIEVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 00:21:45 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041007105230.GA17411@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
Content-Type: text/plain
Message-Id: <1097295399.1442.124.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 00:16:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
> i've released the -T3 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> 

Wow, this is a really bad one - 5576 usecs in shmem_truncate!  I think
this was triggered by Mozilla deleting a large video file from /tmp
which is a tmpfs mount.

(mozilla-bin/16141): new 5576 us maximum-latency critical section.
 => started at: <shmem_truncate+0x67/0x630>
 => ended at:   <shmem_truncate+0x3bc/0x630>
 [<c013d96a>] check_preempt_timing+0x14a/0x1e0
 [<c013d2f5>] __mcount+0x15/0x20
 [<c02dd08a>] preempt_schedule+0xa/0x70
 [<c013dbba>] sub_preempt_count+0x5a/0x90
 [<c016b39c>] shmem_truncate+0x3bc/0x630
 [<c016b39c>] shmem_truncate+0x3bc/0x630
 [<c016b964>] shmem_delete_inode+0x134/0x340
 [<c016b830>] shmem_delete_inode+0x0/0x340
 [<c01991ee>] generic_delete_inode+0xde/0x300
 [<c0189615>] sys_unlink+0xf5/0x150
 [<c0106b47>] syscall_call+0x7/0xb

Full trace:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc3-mm3-VP-T3#/var/www/2.6.9-rc3-mm3-VP-T3/shmem-truncate-latency-trace.txt

Lee

