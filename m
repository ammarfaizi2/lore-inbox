Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbTCLBwU>; Tue, 11 Mar 2003 20:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbTCLBwU>; Tue, 11 Mar 2003 20:52:20 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:23936 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S261654AbTCLBwT>; Tue, 11 Mar 2003 20:52:19 -0500
Date: Wed, 12 Mar 2003 01:55:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, george@mvista.com,
       felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-ID: <20030312015538.GA17149@bjl1.jlokier.co.uk>
References: <20030311144448.4d9ee416.akpm@digeo.com> <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com> <20030311150913.20ddb760.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311150913.20ddb760.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > However, gcc is unable to do-the-right-thing and generate 32x32->64 
> > multiplies, or 32x64->64 multiplies, even though those are both a _lot_ 
> > faster than the full 64x64->64 case.
> 
> 2.95.3 and 3.2.1 seem to do it right?
> 
> long a;
> long b;
> long long c;
> 
> void foo(void)
> {
> 	c = a * b;
> }

Your code is wrong for this test.  It does a 32x32->32 multiply, and
then sign extends the result to 64 bits.

The correct test has "c = (long long) a * b;".

-- Jamie

