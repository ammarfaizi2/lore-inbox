Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTEaRMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTEaRMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:12:15 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:40415 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264379AbTEaRMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:12:14 -0400
Date: Sat, 31 May 2003 13:26:29 -0400
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARKS] 2.5.70 for 4 filesystems
Message-ID: <20030531172629.GA9458@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's quite surprising that reiserfs is so slow at deletion. In my
> normal experience reiserfs rm -rf is much faster than anything else
> (e.g. with a big rm -rf on an ext2 you have a chance to ctrl-c still,
> on reiserfs no such chance; XFS is really slow at this). Perhaps this
> is some 2.5 regression? Do you have 2.4 comparison numbers?

Maybe the other filesystems are just catching up :)
My experience is reiserfs is amazingly fast at rm -rf.

Here is bonnie++ small file benchmark on reiserfs with more kernels.
A couple of notes.  You see the number of files was reduced recently.  
Also the reiserfs notail option was removed based on a suggestion from
Hans to benefit bigger file benchmarks.

                          --------------- Sequential ---------
                          ----- Create -----  ---- Delete ----
                   files   /sec  %CPU    Eff  /sec  %CPU   Eff
2.4.19-rmap13c    131072   3565  40.7   8766  2212  33.3  6635
2.4.20-jam2       131072   3702  43.3   8543  2148  31.3  6855
2.4.21-pre4-ac3   131072   3372  40.3   8360  2187  31.3  6980
2.4.21-pre4aa1    131072   3612  43.7   8273  2141  31.0  6905
2.5.68            131072   2935  37.3   7861  1787  25.7  6963
2.5.68-mm2        131072   3031  38.3   7906  1776  26.3  6743
2.5.68-mjb2        65536   7652  86.7   8830  4027  56.7  7105
2.5.69             65536   7884  90.3   8727  3244  45.7  7102
2.5.69-bk1         65536   7694  88.0   8743  3419  48.3  7073
2.5.69-mm5         65536   7585  87.0   8719  3538  50.3  7029
2.5.70             65536   7584  86.7   8751  2628  37.3  7038

2.5.69 was about 20% faster than 2.5.70 on sequential file deletes
on reiserfs.

I haven't benchmarked any 2.4 kernels with 65536 files and
tails yet.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

