Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSA3Ccf>; Tue, 29 Jan 2002 21:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSA3Cc0>; Tue, 29 Jan 2002 21:32:26 -0500
Received: from zero.tech9.net ([209.61.188.187]:26634 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288083AbSA3CcK>;
	Tue, 29 Jan 2002 21:32:10 -0500
Subject: Re: [PATCH] 2.5: push BKL out of llseek
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20020130032138.H16379@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>,
	<Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
	<1012351309.813.56.camel@phantasy> <3C574BD1.E5343312@zip.com.au>
	<1012357211.817.67.camel@phantasy>  <20020130032138.H16379@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 21:37:57 -0500
Message-Id: <1012358278.817.83.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 21:21, Dave Jones wrote:

>  did you benchmark with anything other than dbench ?

No, and I really don't want to hear how dbench is a terrible benchmark. 
I didn't craft the patch around dbench and I think, here at least,
dbench is an OK benchmark.  I ran it numerous times over multiple client
loads.

I think its clear there won't be a negative impact, because:

- acquiring the inode semaphore isn't any heavier (in the acquire
  case) than the BKL

- the lock contention on each inode semaphore is relatively
  zero

- besides just scaling badly with the using a global lock against
  all inodes, we use the BKL which in such workloads is already
  highly contested.

That said, I did do some lock profiling and latency tests.  Contention
was near-zero, but I only did 2-way testing.  Under the preemptible
kernel, while running dbench, scheduling latency improved 8.9%.

	Robert Love

