Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUIUINX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUIUINX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUIUINW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:13:22 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56592 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267391AbUIUINP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:13:15 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: help with next generation bkbits please
Date: Tue, 21 Sep 2004 11:13:05 +0300
User-Agent: KMail/1.5.4
References: <20040921012208.GA16008@work.bitmover.com>
In-Reply-To: <20040921012208.GA16008@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211113.05614.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 04:22, Larry McVoy wrote:
> Hi,
> 
> we're trying to upgrade bkbits.net for your pushing&pulling pleasure
> and we're having some problems.
> 
> We wanted to throw lots of memory at the problem so we went with an
> ASUS SK8V motherboard, opteron 148, 4 x 1GB registered / ECC dimms.
> We thought we would be careful so we bought dimms that ASUS claims works.
> 
> We can't get the system to stabilize and we're looking for either 
>     a) information on how to do that or
>     b) a suggestion for a machine which will support 4GB or more
> 
> What we are currently seeing looks like a cache writeback problem.
> I have a simple memory scrubber, see below, which just cycles through a
> series of patterns, verifying the previous one and writing a new one,
> switch pattern, repeat until pattern list is exhausted, then loop.
> We cycle through the offset into the array, 0xdeadbeef, 0x50505050,
> 0x0a0a0a0a, 0x55555555, 0xaaaaaaaa, 0, 0xffffffff.
> 
> What we see is that for 16x4 bytes in a row we will get errors where
> what we get is the previous value.  In other words, we just went through

Show the output of scrubber. Does it happen on random addresses?
Same address? With which sizes (L1/L2/main RAM) does it happen? etc...

> a loop that verified that all the data is 0xdeadbeef and then set it
> to 0x50505050, and then in the next loop 16 values will be 0xdeadbeef.
> In other words, it looks like the cache writeback didn't work, it's as
> if the dirty bits were cleared for some reason.

64 bytes is a cacheline size for Opteron. You may have a faulty CPU.
--
vda

