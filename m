Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRHPXps>; Thu, 16 Aug 2001 19:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHPXpj>; Thu, 16 Aug 2001 19:45:39 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:53515 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S269158AbRHPXpV>;
	Thu, 16 Aug 2001 19:45:21 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108162345.f7GNjUw02993@oboe.it.uc3m.es>
Subject: scheduling with io_lock held in 2.4.6
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Fri, 17 Aug 2001 01:45:30 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been plagued for a month by smp lockups in my block driver
that I eventually deduced were due to somebody else scheduling while
holding the io_request_lock spinlock.

There's nothing so impressive as a direct test, so I put a test for
the spinlock being held at the front of schedule(), and sure enough, it
fires every 20s or so when I'm doing nothing in particular on the
machine:

  Aug 17 01:36:42 xilofon kernel: Scheduling with io lock held in process 0

doing a dd to /dev/null from the ide disk seems to trigger it, but from
differnt contexts ...

  Aug 17 01:40:58 xilofon kernel: Scheduling with io lock held in process 0
  Aug 17 01:41:00 xilofon last message repeated 150 times
  Aug 17 01:41:00 xilofon kernel: Scheduling with io lock held in process 1139
  Aug 17 01:41:00 xilofon kernel: Scheduling with io lock held in process 0
  Aug 17 01:41:01 xilofon last message repeated 87 times
  Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 1141
  Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 0


Surprise, 1139 and 1141 are klogd and syslogd respectively.

Any suggestions as to how to track this further?

Peter
