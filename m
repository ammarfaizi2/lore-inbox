Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSJQJW1>; Thu, 17 Oct 2002 05:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbSJQJW1>; Thu, 17 Oct 2002 05:22:27 -0400
Received: from oldmoon.mt.lv ([159.148.172.198]:64521 "EHLO oldmoon.mt.lv")
	by vger.kernel.org with ESMTP id <S261165AbSJQJW0>;
	Thu, 17 Oct 2002 05:22:26 -0400
Date: Thu, 17 Oct 2002 12:32:00 +0300
From: Karlis Peisenieks <karlis@mt.lv>
To: linux-kernel@vger.kernel.org
Subject: poll problem?
Message-ID: <20021017123200.A5837@karlis.dev.mt.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

While using poll with rather large timeouts I came across a "problem" with 
maximum timeout value that can be passed to poll. By reading manpage 
people can expect that maximum timeout they can specify is 2^31 ms or ~596 
hours (here and on I assume i386). In reality maximum timeout is HZ 
dependent and value larger than max is treated the same as negative 
timeout ("infinite" as per manpage, MAX_SCHEDULE_TIMEOUT in HZ units in 
reality). With HZ == 100 this value is ~6 hours (MAX_SCHEDULE_TIMEOUT / 
100). With HZ == 1000 this value is only ~35min!

And now questions:
- is this how it is supposed to be (then manpage should be fixed)?
- perhaps current approach of timeout calc should be changed so that for 
large (> MAX_SCHEDULE_TIMEOUT / HZ) timeout values some other method (not 
that precise, e.g. : timeout = (timeout / 1000) * HZ) should be used?


Karlis
