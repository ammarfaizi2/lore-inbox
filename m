Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133120AbRDZG5S>; Thu, 26 Apr 2001 02:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbRDZG5I>; Thu, 26 Apr 2001 02:57:08 -0400
Received: from eising.k-net.dtu.dk ([130.225.71.229]:12780 "EHLO
	eising.k-net.dk") by vger.kernel.org with ESMTP id <S133120AbRDZG5B>;
	Thu, 26 Apr 2001 02:57:01 -0400
From: "Allan Frank" <allan@ostenfeld.dk>
To: <linux-kernel@vger.kernel.org>
Subject: alpha stack problem: resource.h
Date: Thu, 26 Apr 2001 08:59:12 +0200
Message-ID: <IIEKLBDNKAPNMMEJLDAGEECPCGAA.allan@ostenfeld.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Yesterday I installed 2.2.19 one of out alpha servers and I found that it
still has the same bug that we patched 2.2.14 to get rid of. In the 2.4 line
it seems to be fixed.
The bug has the affect that a unprev. user cannot increase the stack limit
even if he/she is allowed to.

This mailing list item fom Jun 12 2000 describes the problem:

http://www.uwsg.iu.edu/hypermail/linux/alpha/0006.1/0003.html

<snippit from page>

It is because wrong value in the
/usr/src/linux/include/asm-alpha/resource.h

The INIT_RLIMITS defined the RLIMIT_STACK as

{_STK_LIM, _STK_LIM}


The latter defines hard limit of the stack.
When I pointed the problem, only Intel and PPC people corrected it.
You should change the value as

{_STK_LIM, LONG_MAX}

and recompile your kernel.
It will resolve your problem.

</snippit from page>

I can report that is does resolve the problem here. Is this a bug or is the
kernel supposed to work that way?


/Allan
Outlook stinks.

