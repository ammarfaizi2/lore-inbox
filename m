Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSA3COp>; Tue, 29 Jan 2002 21:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSA3COf>; Tue, 29 Jan 2002 21:14:35 -0500
Received: from zero.tech9.net ([209.61.188.187]:11018 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287979AbSA3COW>;
	Tue, 29 Jan 2002 21:14:22 -0500
Subject: Re: [PATCH] 2.5: push BKL out of llseek
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C574BD1.E5343312@zip.com.au>
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>,
	<Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
	<1012351309.813.56.camel@phantasy>  <3C574BD1.E5343312@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 21:20:10 -0500
Message-Id: <1012357211.817.67.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 20:26, Andrew Morton wrote:

> Just a little word of caution here.  Remember the
> apache-flock-synchronisation fiasco, where removal
> of the BKL halved Apache throughput on 8-way x86.
> 
> This was because the BKL removal turned serialisation
> on a quick codepath from a spinlock into a schedule().

I feared this too, but eventually I decided it was worth it and
benchmarks backed that up.  If nothing else this is yet-another-excuse
for locks that can spin-then-sleep.

I posted dbench results, which show a positive gain even on 2-way for
multiple client loads.

	Robert Love

