Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289085AbSA3KhH>; Wed, 30 Jan 2002 05:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289082AbSA3Kg5>; Wed, 30 Jan 2002 05:36:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59909 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289093AbSA3Kgs>; Wed, 30 Jan 2002 05:36:48 -0500
Date: Wed, 30 Jan 2002 10:36:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
Message-ID: <20020130103640.D16937@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>, <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com> <1012351309.813.56.camel@phantasy> <3C574BD1.E5343312@zip.com.au> <1012357211.817.67.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012357211.817.67.camel@phantasy>; from rml@tech9.net on Tue, Jan 29, 2002 at 09:20:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 09:20:10PM -0500, Robert Love wrote:
> On Tue, 2002-01-29 at 20:26, Andrew Morton wrote:
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

Luckily, apache on its own doesn't seem to use lseek() when sending the
file - it seems to be an open, mmap, write.  (apache 1.3.22)

However, php with apache does do an lseek on the target script.  Now
remember the /. effect...  You'll be accessing the same file from
several apache or php processes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
