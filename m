Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274625AbRITUB1>; Thu, 20 Sep 2001 16:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274624AbRITUBR>; Thu, 20 Sep 2001 16:01:17 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:26632 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274626AbRITUBD>; Thu, 20 Sep 2001 16:01:03 -0400
Date: Thu, 20 Sep 2001 22:01:21 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Message-ID: <20010920220121.A18683@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1000939458.3853.17.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000939458.3853.17.camel@phantasy>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should the patch work with SMP systems ?
Here is what I get:

Worst 20 latency times of 1322 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
988940   reacqBKL        0  1375/sched.c         c0117ba1   772/sched.c
988940  spin_lock        0   129/file_table.c    c013f500   135/page_alloc.c
988940  spin_lock        0   103/page_alloc.c    c0136fd9   251/timer.c
988940  spin_lock        0   129/file_table.c    c013f500   135/page_alloc.c
988940  spin_lock        0    63/fork.c          c0117efc   135/page_alloc.c
988940  spin_lock        0   129/file_table.c    c013f500   135/page_alloc.c
988940  spin_lock        0   129/file_table.c    c013f500   135/page_alloc.c
988940  spin_lock        0   592/af_unix.c       c02ddd88   594/af_unix.c
988940  spin_lock        0    43/fork.c          c0117ddc   829/inode.c
988940  spin_lock        0   547/sched.c         c0115bf5   606/signal.c
988940  spin_lock        0   770/sched.c         c011641c    80/dcache.c
988940  spin_lock        0    36/dec_and_lock.c  c0319573   280/time.c
988940  spin_lock        0    36/dec_and_lock.c  c0319573   280/time.c
988940        BKL        0   714/ll_rw_blk.c     c01eaec1    80/dcache.c
988939  spin_lock        0   592/af_unix.c       c02ddd88   594/af_unix.c
988939  spin_lock        0   714/ll_rw_blk.c     c01eaec1    80/dcache.c
988939    unknown        0    76/softirq.c       c011f410   782/sched.c
988939  spin_lock        0   592/af_unix.c       c02ddd88  1380/sched.c
988939  spin_lock        0   176/fork.c          c0118608   696/namei.c
988939  spin_lock        0  1684/af_unix.c       c02e0de6   734/dcache.c

And another one about 2 seconds after the last flush:

Worst 20 latency times of 579 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
988939  spin_lock        0   592/af_unix.c       c02ddd88   133/file_table.c
988930  spin_lock        0   770/sched.c         c011641c   697/sched.c
988930  spin_lock        0   547/sched.c         c0115bf5   133/file_table.c
988930  spin_lock        0  1512/es1371.c        c02408e0   133/file_table.c
  6613  spin_lock        1   547/sched.c         c0115bf5   697/sched.c
  6401  spin_lock        0   547/sched.c         c0115bf5   647/irq.c
  2557  spin_lock        0   547/sched.c         c0115bf5   647/signal.c
   833  spin_lock        0   547/sched.c         c0115bf5   133/file_table.c
   364        BKL        6   710/tty_io.c        c01d1eed   712/tty_io.c
   283        BKL        4   710/tty_io.c        c01d1eed   280/time.c
   243        BKL        0    59/ioctl.c         c014fbe5   685/socket.c
   231        BKL        4   710/tty_io.c        c01d1eed   697/sched.c
   218  spin_lock        0   798/vmscan.c        c01366a5   857/vmscan.c
   210  spin_lock        0  3169/tcp_input.c     c02b5331   697/sched.c
   191  spin_lock        2   468/netfilter.c     c0285351   119/softirq.c
   183  spin_lock        0   468/netfilter.c     c0285351   280/time.c
   176  spin_lock        0   468/netfilter.c     c0285351   697/sched.c
   168        BKL        0    26/readdir.c       c014ff8c    28/readdir.c
   134       ide0        0   585/irq.c           c0108eb1   647/irq.c
   134        BKL        0   980/inode.c         c01691a3   997/inode.c

-- 
Tobias								PGP: 0x9AC7E0BC
Hannover Fantreffen ML: mailto:fantreffen-request@mantrha.de?subject=subscribe
Manga & Anime Treff Hannover: http://www.mantrha.de/
