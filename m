Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSFDMqu>; Tue, 4 Jun 2002 08:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSFDMqr>; Tue, 4 Jun 2002 08:46:47 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:58061 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316610AbSFDMp7>; Tue, 4 Jun 2002 08:45:59 -0400
Date: Tue, 4 Jun 2002 08:44:01 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre9aa2
Message-ID: <20020604124401.GA13540@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> More benchmarks on quad Xeon at:
>> http://home.earthlink.net/~rwhron/kernel/bigbox.html

> Just a note, watch the "File & VM system latencies in microseconds"
> lmbench results, the creat become significantly slower, I'm wondering if
> that's due the removal of the negative dcache after unlink. I think it's
> still a global optimization (infact I think some of the dbench records
> are also thanks to maximzing the useful cache information by dropping
> immediatly negative dentries after unlink), but I wonder if the
> benchmark is done in a way that generate false positives. To avoid false
> positives and to really benchmark the whole "creat" path (that includes
> in its non-cached form also a lookup in the lowlevel fs) lmbench should
> rmdir; mkdir the directory where it wants to make the later creats
> (rmdir/mkdir cycle will drop negative dentries in all 2.[245] kernels
> too).  Otherwise at the moment I'm unsure what made creat slower between
> pre8aa3 and pre9aa2, could it be a fake result of the benchmark? 

I'll send you the 25 samples each of pre9aa2 and pre8aa3 off list.
All of the non-averaged lmbench results are currently at:
http://home.earthlink.net/~rwhron/kernel/lmball.txt

Some lmbench tests vary a lot.  The 0k and 10k creat tests were
pretty consistent for these two kernels.

Other consistent tests that showed notable improvement were context
switching at 8p/16K, 8p/64K, and 16p/16K.  The 16p/64K context switch
latency became inconsistent and higher on pre9aa2.

fork latency was consistent and improved by 10%.

> The pipe bandwith reported
> by lmbench in pre9aa2 is also very impressive, that's Mike's patch and I
> think it's also a very worthwhile optimizations since many tasks really
> uses pipes to passthrough big loads of data.

Yeah, that is impressive.

Glancing through the original lmbench logfiles, there are some results
that aren't in any report.  creat 1k and 4k, and select on various 
numbers of regular and tcp file descripters.  


-- 
Randy Hron

