Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVEXW7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVEXW7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVEXW7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:59:25 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:57566 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S262099AbVEXW7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:59:17 -0400
Subject: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
Reply-To: bhavesh@avaya.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Avaya, Inc.
Date: Tue, 24 May 2005 16:59:15 -0600
Message-Id: <1116975555.2050.10.camel@cof110earth.dr.avaya.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setitimer for 20ms was firing at 21ms, so I wrote a simple debug module
for 2.6.11.10 kernel on i386 to do something like this:

struct timeval tv;
unsigned long jif;

tv.tv_usec = 20000;
tv.tv_sec = 0;

jif = timeval_to_jiffies(&tv);
printk("%lu usec = %lu jiffies\n", tv.tv_usec, jif);

This yields:

20000 usec = 21 jiffies

Egad!

I looked at the timeval_to_jiffies() inline function in
include/linux/jiffies.h, and after pulling my hair for a few minutes
(okay almost an hour), I decided to ask much smarter people than myself
on why it is behaving this way, and what it would take to fix it so that
"20000 usec = 20 jiffies".

I got as far as this in figuring it out for i386:

HZ=1000
SEC_CONVERSION=4194941632
USEC_CONVERSION=2199357558
USEC_ROUND=2199023255551
USEC_JIFFIE_SC=41
SEC_JIFFIE_SC=22

Thanks in advance for saving me from going bald!

- Bhavesh

-- 
Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
