Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268893AbRG0Rrj>; Fri, 27 Jul 2001 13:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268912AbRG0Rr3>; Fri, 27 Jul 2001 13:47:29 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:46086 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268893AbRG0RrZ>; Fri, 27 Jul 2001 13:47:25 -0400
Message-ID: <3B61A8A3.72EC132F@namesys.com>
Date: Fri, 27 Jul 2001 21:45:07 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>,
        "Gryaznova E." <grev@namesys.botik.ru>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>,
						<Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <3B619956.6AA072F9@zip.com.au> <3B619D63.9989F9F@namesys.com> <3B61A4A5.41E7B891@zip.com.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrew Morton wrote:
> 
> Hans Reiser wrote:
> >
> > Andrew, can you do this such that there is no disruption of our
> > disk format, and make a mount option
> > out of it, and probably we should use this patch....
> 
> I'll defer to Chris :)

Yes, I'll let him think carefully through the details of how it affects ordering of the writes.


> 
> There's no disruption to disk format - it just simulates
> the user typing `sync' at the right time.  I think the
> concept is sound, and I'm sure Chris can find a more efficient
> way...

Oops, sorry, you changed the in-ram not the on-disk sb....

> 
> > After you make a mount option out of it, grev will benchmark
> > it for us using the usual suite of benchmarks.
> >
> 
> Ordered-data is a funny thing.  Under heavy loads it tends
> to make a significant throughput difference - on ext3 it
> almost halves throughput wrt writeback mode.
> 
> But this by no means indicates that writes are half as slow;
> what happens is that metadata-intensive workloads fill the
> journal up quickly, so the `sync' happens more frequently.
> Under normal workloads, or less metadata-intense workloads
> the difference is very small.
> 
> During testing of that little patch I noted that the
> disk went crunch every thirty seconds or so, which is good.
> Presumably the reiserfs journal is larger, or more space-efficient.
> 
> -

Thanks Andrew
