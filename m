Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbRGQAIN>; Mon, 16 Jul 2001 20:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267742AbRGQAID>; Mon, 16 Jul 2001 20:08:03 -0400
Received: from joat.prv.ri.meganet.net ([209.213.80.2]:48347 "EHLO
	joat.prv.ri.meganet.net") by vger.kernel.org with ESMTP
	id <S267741AbRGQAH6>; Mon, 16 Jul 2001 20:07:58 -0400
Message-ID: <3B538235.538D800E@ueidaq.com>
Date: Mon, 16 Jul 2001 20:09:25 -0400
From: Alex Ivchenko <aivchenko@ueidaq.com>
Organization: UEI, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Porting char driving from 2.2 to 2.4 : changes in API to know
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I'm porting dataq driver from 2.2 to 2.4 and found a problem with using
interruptible_sleep_on_timeout() and wake_up_interruptible().

Knowing that wait queue was reorganized in 2.4 I declared queue head as:

static DECLARE_WAIT_QUEUE_HEAD(wqhead);

and then in ioctl routine

..
// put request on hold
interruptible_sleep_on_timeout(&wqhead, jiffies);
...

and

..
// release process
wake_up_interruptible(&wqhead);

interruptible_sleep_on_timeout() works correctly and releases process when timeout
expires. However wake_up_interruptible() doesn't work.

Questions:
1. Is "interruptible" functions still recommended for use under 2.4?
2. What other changes made can potentially affect this mechanism?
3. Should I use some special options/flags to compile modules under 2.4
(beyond discussed in lkml FAQ)?


-- 
Regards,
Alex

--
Alex Ivchenko, Ph.D.
United Electronic Industries, Inc.
"The High-Performance Alternative (tm)"
--
10 Dexter Avenue
Watertown, Massachusetts 02472
Tel: (617) 924-1155 x 222 Fax: (617) 924-1441
http://www.ueidaq.com
