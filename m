Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUEODQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUEODQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 23:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUEODQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 23:16:37 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:59060 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262547AbUEODQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 23:16:36 -0400
Message-Id: <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 15 May 2004 13:15:47 +1000
To: Andy Isaacson <adi@bitmover.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s
  && s->tree' failed: The saga continues.)
Cc: Steven Cole <elenstev@mesatop.com>, Steven Cole <scole@lanl.gov>,
       support@bitmover.com, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040514165311.GC6908@bitmover.com>
References: <200405132232.01484.elenstev@mesatop.com>
 <20040514144617.GE20197@work.bitmover.com>
 <200405131723.15752.elenstev@mesatop.com>
 <200405122234.06902.elenstev@mesatop.com>
 <15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov>
 <20040513183316.GE17965@bitmover.com>
 <200405131723.15752.elenstev@mesatop.com>
 <6616858C-A5AF-11D8-A7EA-000A95CC3A8A@lanl.gov>
 <20040514144617.GE20197@work.bitmover.com>
 <200405122234.06902.elenstev@mesatop.com>
 <15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov>
 <20040513183316.GE17965@bitmover.com>
 <200405131723.15752.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:53 AM 15/05/2004, Andy Isaacson wrote:
>That corruption size really does make me think of network packets, so
>I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
>link?  "ifconfig ppp0" or something like that.

1352 bytes coule be remarkably close to the TCP MSS . . .
perhaps there is some interaction with ppp where there is an overrun / lost 
packet and the TCP window is mistakenly advanced?

i.e.
  - 1500 byte MTU
  - less 28 bytes for PPP header (1472 bytes)
  - less 20 bytes for IP header (1452 bytes)
  - less 20 bytes for TCP header (1432 bytes)

if, however, the MRU is actually negotiated to be 1420 rather than 1500 . . .


when you issue the "bk pull", it may be interesting to see the output from:
         tcpdump -i ppp0 -n | grep mss


cheers,

lincoln.

