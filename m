Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUEOFkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUEOFkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 01:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbUEOFkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 01:40:22 -0400
Received: from taco.zianet.com ([216.234.192.159]:53008 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S263807AbUEOFkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 01:40:09 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Fri, 14 May 2004 23:39:37 -0600
User-Agent: KMail/1.6.1
Cc: Lincoln Dale <ltd@cisco.com>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org>
In-Reply-To: <20040514204153.0d747933.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405142339.38059.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 09:41 pm, Andrew Morton wrote:
> Lincoln Dale <ltd@cisco.com> wrote:
> >
> > At 02:53 AM 15/05/2004, Andy Isaacson wrote:
> > >That corruption size really does make me think of network packets, so
> > >I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
> > >link?  "ifconfig ppp0" or something like that.
> > 
> > 1352 bytes coule be remarkably close to the TCP MSS . . .
> > perhaps there is some interaction with ppp where there is an overrun / lost 
> > packet and the TCP window is mistakenly advanced?
> 
> Steve, if it's a memory stomp then perhaps CONFIG_DEBUG_PAGEALLOC and
> CONFIG_DEBUG_SLAB might pick it up.
> 
> It seems awfully deterministic though.
> 
> 
Andy asked me to do the following without ppp, which I did.
The explanation of the odd key is in his previous mail.

#!/bin/sh
x=0
while true; do
        bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
        (cd foo; bk pull -q)
        rm -rf foo
        x=`expr $x + 1`
        echo -n "$x "
done

The above caused a failure after the 7th iteration or so.  This time, the
RESYNC/SCCS/s.ChangeSet file didn't have any nulls, but three other
files did, namely s.Makefile, s.CREDITS, s.MAINTAINERS.  Not knowing
whether this was normal or not, I've sent those files to bitkeeper for
analysis.

Since I only began seeing these "Assertion `s && s->tree' failed" problems
with bk in the past month or so, and I generally run a current kernel
on this machine, I booted an older kernel, 2.6.3.  I'm going to run
Andy's test overnight and see if 2.6.3 acts any differently.

In the meantime, I'll have the machine building a 2.6.6-plus kernel
with CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_SLAB if its
use seems indicated in the morning.

Steven
