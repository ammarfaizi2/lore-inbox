Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288691AbSANLdT>; Mon, 14 Jan 2002 06:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289204AbSANLdI>; Mon, 14 Jan 2002 06:33:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32788 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288691AbSANLcz>; Mon, 14 Jan 2002 06:32:55 -0500
Date: Mon, 14 Jan 2002 12:32:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: jogi@planetzork.ping.de, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114123206.A10227@athlon.random>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020113161823.B1439@planetzork.spacenet> <1010945482.11848.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1010945482.11848.2.camel@phantasy>; from rml@tech9.net on Sun, Jan 13, 2002 at 01:11:21PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 01:11:21PM -0500, Robert Love wrote:
> On Sun, 2002-01-13 at 10:18, jogi@planetzork.ping.de wrote:
> 
> > No, I use a script which is run in single user mode after a reboot. So
> > there are only a few processes running when I start the script (see
> > attachment) and the jobs should start from the same environment.
> > 
> > > What happens when you do the same test, compiling one kernel under multiple
> > > different kernels?
> > 
> > That is exactly what I am doing. I even try to my best to have the exact
> > same starting environment ...
> 
> So there you go, his testing is accurate.  Now we have results that
> preempt works and is best and it is still refuted.  Everyone is running
> around with these "ll is best" or "preempt sucks throughput" and that is

assuming the report can be trusted this is not the test where we can
measure a throughput regression, this is a VM intensive test and nothing
else.  Swap load.

In short, run top and check you've 100% system load and cpus are never
idle or in userspace, and _then_ it will most certainly get an interesting
benchmark for -preempt throughput.

Furthmore the whole comparison is flawed, just -O(1) is as broken as
mainline w.r.t. the scheduling point, and -aa has the right scheduling
point but not the -O(1) scheduler, so there's no way to compare those
numbers at all. If you want to make any real comparison you should apply
-preempt on top of -aa.

Assuming it is really -preempt that makes the numbers more repetable
(not the fact -O(1) alone has the broken rescheduling points), this
still doesn't proof anything yet, the lower numbers are most certainly
because those tasks getting the page faults get rescheduled faster, -aa
didn't do more cpu work, it just had the cpus more idle than -preempt
apparently, this may be the indication of an important scheduling point
missing somewhere, if somebody could run a lowlatency measurement during
a swap intensive load and send me the offending IP that could probably
be addressed with a one liner.

Andrea
