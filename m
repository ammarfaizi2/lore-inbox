Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSLBG5n>; Mon, 2 Dec 2002 01:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSLBG5n>; Mon, 2 Dec 2002 01:57:43 -0500
Received: from web14610.mail.yahoo.com ([216.136.224.242]:32405 "HELO
	web14610.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265249AbSLBG5e>; Mon, 2 Dec 2002 01:57:34 -0500
Message-ID: <20021202070501.27876.qmail@web14610.mail.yahoo.com>
Date: Sun, 1 Dec 2002 23:05:01 -0800 (PST)
From: Santhosh Kumar <linuxkern@yahoo.com>
Subject: Interrupting __free_pages_OK results in OOPS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My device driver has an interrupt handler which
handles interrupts at a very high priority. Sometimes
the interrupt handler OOPS in __free_pages_OK. Any 
idea why it happens. (The process that was executing
at that time is Python).

System is Redhat 8.0, kernel 2.4.18-4

OOPS happens as follows. 

The interrupt handler pushes "gs" segment register,
while entering and pops "gs" while leaving. Always, it
OOPS at "pop %gs". The value that is popped to "gs" is
0007. The "lar" instruction (load access rights, with
parameter 0007) gives a value 0x0010ec00, which shows
it is a system segment. The code given by the General
Protection Fault is 0004.

Thanks
Santhosh

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
