Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267868AbTBKOkc>; Tue, 11 Feb 2003 09:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267866AbTBKOkb>; Tue, 11 Feb 2003 09:40:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267886AbTBKOje>;
	Tue, 11 Feb 2003 09:39:34 -0500
Date: Tue, 11 Feb 2003 15:49:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <ckolivas@yahoo.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.60-cfq with contest
Message-ID: <20030211144912.GS930@suse.de>
References: <200302112155.17048.ckolivas@yahoo.com.au> <20030211105944.GB930@suse.de> <20030211133709.GO930@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211133709.GO930@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11 2003, Jens Axboe wrote:
> On Tue, Feb 11 2003, Jens Axboe wrote:
> > > Write based loads hurt. No breakages, but needs tuning. 
> > 
> > That's not even as bad as I had feared. I'll try to do some tuning with
> > contest locally.
> 
> Here are my results, for 2.5.60 vanilla, 2.5.60 + cfq with default
> quantum of 16 (what you tested, too), and 2.5.60 + cfq without quantum
> setting. The latter should be the fairest, only moves one request from
> the pending queues.

Did runs with quantum values of 2,4,8 as well to see how it looks. Often
the dbench runs got screwed, perhaps the signalling changes from 2.5.60
is interfering?

dbench_load.c:72: SYSTEM ERROR: No such process : could not kill pid 4842

Anyways, here are the results:

no_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     31      177.4   0       0.0     1.00
2.5.60-cfq0       2     31      174.2   0       0.0     1.00
2.5.60-cfq16      2     31      177.4   0       0.0     1.00
2.5.60-cfq4       1     32      171.9   0       0.0     1.00
2.5.60-cfq8       2     31      174.2   0       0.0     1.00
cacherun:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     29      182.8   0       0.0     0.94
2.5.60-cfq0       2     28      192.9   0       0.0     0.90
2.5.60-cfq16      2     29      182.8   0       0.0     0.94
2.5.60-cfq4       1     29      186.2   0       0.0     0.91
2.5.60-cfq8       2     29      182.8   0       0.0     0.94
process_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     38      142.1   12      47.4    1.23
2.5.60-cfq0       2     41      129.3   16      61.0    1.32
2.5.60-cfq16      2     37      145.9   12      43.2    1.19
2.5.60-cfq4       1     36      150.0   11      44.4    1.12
2.5.60-cfq8       2     38      142.1   13      47.4    1.23
ctar_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     38      147.4   0       0.0     1.23
2.5.60-cfq0       2     36      155.6   0       0.0     1.16
2.5.60-cfq16      2     36      155.6   0       0.0     1.16
2.5.60-cfq4       1     36      155.6   0       0.0     1.12
2.5.60-cfq8       2     37      151.4   0       0.0     1.19
xtar_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     40      140.0   0       2.5     1.29
2.5.60-cfq0       2     37      148.6   0       2.7     1.19
2.5.60-cfq16      2     40      137.5   0       2.5     1.29
2.5.60-cfq4       1     37      148.6   0       2.7     1.16
2.5.60-cfq8       2     38      147.4   0       2.6     1.23
io_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     93      61.3    2       14.0    3.00
2.5.60-cfq0       4     103     54.4    2       12.6    3.32
2.5.60-cfq16      2     264     21.6    12      19.9    8.52
2.5.60-cfq4       1     97      57.7    3       15.5    3.03
2.5.60-cfq8       2     135     42.2    5       16.3    4.35
read_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     40      140.0   0       5.0     1.29
2.5.60-cfq0       2     39      143.6   0       5.1     1.26
2.5.60-cfq16      2     40      140.0   0       5.0     1.29
2.5.60-cfq4       1     39      143.6   0       5.1     1.22
2.5.60-cfq8       2     40      140.0   0       5.0     1.29
list_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     35      157.1   0       8.6     1.13
2.5.60-cfq0       2     35      160.0   0       8.6     1.13
2.5.60-cfq16      2     35      160.0   0       14.3    1.13
2.5.60-cfq4       1     36      155.6   0       8.3     1.12
2.5.60-cfq8       2     35      160.0   0       11.4    1.13
mem_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     50      116.0   75      10.0    1.61
2.5.60-cfq0       2     57      101.8   78      8.8     1.84
2.5.60-cfq16      2     60      96.7    80      8.2     1.94
2.5.60-cfq4       1     52      111.5   76      9.4     1.62
2.5.60-cfq8       2     50      114.0   75      9.8     1.61
dbench_load:
Kernel       [runs]     Time    CPU%    Loads   LCPU%   Ratio
2.5.60            2     36      155.6   12693   27.8    1.16
2.5.60-cfq0       1     35      157.1   12013   28.6    1.13
2.5.60-cfq16      2     37      151.4   14356   32.4    1.19
2.5.60-cfq8       1     35      157.1   12174   31.4    1.13

As I initialy expected, without having data to back it up, a non-zero
quantum value helps. 16 was too much though, 4 looks a good choice. At
least here.

-- 
Jens Axboe

