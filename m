Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbTCKXiG>; Tue, 11 Mar 2003 18:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbTCKXiF>; Tue, 11 Mar 2003 18:38:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21265 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261757AbTCKXiD>; Tue, 11 Mar 2003 18:38:03 -0500
Date: Tue, 11 Mar 2003 15:46:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: george@mvista.com, <felipe_alfaro@linuxmail.org>, <cobra@compuserve.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
In-Reply-To: <20030311150913.20ddb760.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303111544050.2411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Andrew Morton wrote:
> 
> 2.95.3 and 3.2.1 seem to do it right?

Well, they do, but your test case is wrong:

> long a;
> long b;
> long long c;
> 
> void foo(void)
> {
> 	c = a * b;

This is just a 32*32->32 multiply, with a final sign extension to 64 bits.

You need to do

	c = (long long) a * b;

to get a 32*32->64 multiply. And yes, gcc gets that case right.

		Linus

