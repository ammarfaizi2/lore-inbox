Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268602AbUIXJ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbUIXJ0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUIXJ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 05:26:13 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:2707 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268602AbUIXJ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 05:26:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Fri, 24 Sep 2004 11:27:38 +0200
User-Agent: KMail/1.6.2
Cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
       Andrew Walrond <andrew@walrond.org>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409240931.42356.andrew@walrond.org> <Pine.LNX.4.58.0409241856120.16011@fb07-calculator.math.uni-giessen.de>
In-Reply-To: <Pine.LNX.4.58.0409241856120.16011@fb07-calculator.math.uni-giessen.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409241127.38529.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 of September 2004 10:57, Sergei Haller wrote:
> On Fri, 24 Sep 2004, Andrew Walrond (AW) wrote:
> 
> AW> On Friday 24 Sep 2004 09:23, Sergei Haller wrote:
> AW> > It's the same for me if I use the non-SMP version of the kernel.
> AW> > but the SMP one seems to be panicking for some reason.
> AW> >
> AW> 
> AW> Just a thought; How are the memory modules arranged on the board?
> AW> I have 2 x 1Gb modules in each cpu-specific bank, rather than all four 
in 
> AW> cpu1's bank. How are yours arranged?
> 
> my board has only four banks, each of them has a 1GB module sitting.
> (page 26 of ftp://ftp.tyan.com/manuals/m_s2875_102.pdf)

Which is what makes the difference, I think.  IMO, the problem is that _both_ 
CPUs use the same memory bank that is physically attached to only one of them 
which leads to conflicts, apparently (the CPU with memory has also 
PCI/AGP/whatever attached to it via HyperTransport so I can imagine there may 
be issues with overlapping address spaces etc.).  I'd bet that there's 
something wrong either with the BIOS or with the board design itself and I 
don't think there's anything that the kernel can do about it (usual 
disclaimer applies).

Out of couriosity: have you tried to run the kernel with K8 NUMA enabled?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
