Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSA3C1z>; Tue, 29 Jan 2002 21:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288083AbSA3C1t>; Tue, 29 Jan 2002 21:27:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288050AbSA3C1f>;
	Tue, 29 Jan 2002 21:27:35 -0500
Message-ID: <3C57586B.7B145D16@zip.com.au>
Date: Tue, 29 Jan 2002 18:20:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <3C574BD1.E5343312@zip.com.au>,
		<Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>,
		<Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
		<1012351309.813.56.camel@phantasy>  <3C574BD1.E5343312@zip.com.au> <1012357211.817.67.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Tue, 2002-01-29 at 20:26, Andrew Morton wrote:
> 
> > Just a little word of caution here.  Remember the
> > apache-flock-synchronisation fiasco, where removal
> > of the BKL halved Apache throughput on 8-way x86.
> >
> > This was because the BKL removal turned serialisation
> > on a quick codepath from a spinlock into a schedule().
> 
> I feared this too, but eventually I decided it was worth it and
> benchmarks backed that up.  If nothing else this is yet-another-excuse
> for locks that can spin-then-sleep.
> 
> I posted dbench results, which show a positive gain even on 2-way for
> multiple client loads.
> 

But dbench does lots of seeking against *different* files,
so removal of a shared lock will help there.

But an application where multiple CPUs lseek and write
the *same* file could take a hit....

(And where's the locking for (non-atomic) i_size in sys_stat())


-
