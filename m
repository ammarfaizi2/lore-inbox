Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbRGKOW1>; Wed, 11 Jul 2001 10:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbRGKOWR>; Wed, 11 Jul 2001 10:22:17 -0400
Received: from pat.uio.no ([129.240.130.16]:7296 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267317AbRGKOWO>;
	Wed, 11 Jul 2001 10:22:14 -0400
MIME-Version: 1.0
Message-ID: <15180.24844.687421.239488@charged.uio.no>
Date: Wed, 11 Jul 2001 16:22:04 +0200
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <3B4C56F1.3085D698@uow.edu.au>
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here>
	<shslmlv62us.fsf@charged.uio.no>
	<3B4C56F1.3085D698@uow.edu.au>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <andrewm@uow.edu.au> writes:

     > Trond Myklebust wrote:
    >>
    >> ...  I have the same problem on my setup. To me, it looks like
    >> the loop in spawn_ksoftirqd() is suffering from some sort of
    >> atomicity problem.

     > Does a `set_current_state(TASK_RUNNING);' in spawn_ksoftirqd()
     > fix it?  If so we have a rogue initcall...

Nope. The same thing happens as before.

A couple of debugging statements show that ksoftirqd_CPU0 gets created
fine, and that ksoftirqd_task(0) is indeed getting set correctly
before we loop in spawn_ksoftirqd().
After this the second call to kernel_thread() succeeds, but
ksoftirqd() itself never gets called before the hang occurs.

Cheers,
   Trond
