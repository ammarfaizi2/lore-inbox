Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSINSvo>; Sat, 14 Sep 2002 14:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSINSvo>; Sat, 14 Sep 2002 14:51:44 -0400
Received: from h00010256f583.ne.client2.attbi.com ([66.30.243.14]:33731 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S317463AbSINSvo>; Sat, 14 Sep 2002 14:51:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Lev Makhlis <mlev@despammed.com>
To: ricklind@us.ibm.com
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
Date: Sat, 14 Sep 2002 14:57:54 -0400
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209141457.54905.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define MSEC(x) ((x) * 1000 / HZ)

Perhaps it would be better to report the times in ticks using 
jiffies_to_clock_t(), and let the userland do further conversions?
The macro above has an overflow problem, it creates a counter
that wraps at 2^32 / HZ (instead of 2^32), and theoretically, the
userland doesn't even know what the internal HZ is.  The overflow
can be avoided with something like
#define MSEC(x) (((x) / HZ) * 1000 + ((x) % HZ) * 1000 / HZ)
but I think it would be cleaner just to change the units to ticks,
especially if we're moving it to a different file and procps will
need to be changed anyway.
