Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSFCX7X>; Mon, 3 Jun 2002 19:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSFCX7W>; Mon, 3 Jun 2002 19:59:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1288 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315919AbSFCX7U>; Mon, 3 Jun 2002 19:59:20 -0400
Date: Tue, 4 Jun 2002 01:59:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre9aa2
Message-ID: <20020603235924.GB1105@dualathlon.random>
In-Reply-To: <20020603121505.GA13261@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 08:15:05AM -0400, rwhron@earthlink.net wrote:
> More benchmarks on quad Xeon at:
> http://home.earthlink.net/~rwhron/kernel/bigbox.html

very cool work as usual :). Many thanks.

Just a note, watch the "File & VM system latencies in microseconds"
lmbench results, the creat become significantly slower, I'm wondering if
that's due the removal of the negative dcache after unlink. I think it's
still a global optimization (infact I think some of the dbench records
are also thanks to maximzing the useful cache information by dropping
immediatly negative dentries after unlink), but I wonder if the
benchmark is done in a way that generate false positives. To avoid false
positives and to really benchmark the whole "creat" path (that includes
in its non-cached form also a lookup in the lowlevel fs) lmbench should
rmdir; mkdir the directory where it wants to make the later creats
(rmdir/mkdir cycle will drop negative dentries in all 2.[245] kernels
too).  Otherwise at the moment I'm unsure what made creat slower between
pre8aa3 and pre9aa2, could it be a fake result of the benchmark? Maybe
you could give it a second spin just in case. The pipe bandwith reported
by lmbench in pre9aa2 is also very impressive, that's Mike's patch and I
think it's also a very worthwhile optimizations since many tasks really
uses pipes to passthrough big loads of data.

Andrea
