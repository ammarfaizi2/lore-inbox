Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278974AbRJ2D57>; Sun, 28 Oct 2001 22:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278975AbRJ2D5k>; Sun, 28 Oct 2001 22:57:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27213 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278974AbRJ2D5g>; Sun, 28 Oct 2001 22:57:36 -0500
Date: Mon, 29 Oct 2001 04:57:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>
Subject: 2.4.14pre3aa3 [was Re: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)]
Message-ID: <20011029045747.N1396@athlon.random>
In-Reply-To: <20011028120721.A286@earthlink.net> <20011029014715.J1396@athlon.random> <20011029034546.L1396@athlon.random> <20011029042938.M1396@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011029042938.M1396@athlon.random>; from andrea@suse.de on Mon, Oct 29, 2001 at 04:29:38AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 04:29:38AM +0100, Andrea Arcangeli wrote:
> On Mon, Oct 29, 2001 at 03:45:46AM +0100, Andrea Arcangeli wrote:
> > andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w     
> > PASS ... 536870912 bytes allocated.
> > 
> > real    1m8.655s
> > user    0m9.370s
> > sys     0m2.250s
> > andrea@dev4-000:~> 
> 
> new exciting result on exactly the same test (4Ganon mem +512m swap,
> then started the bench):
> 
> andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w
> PASS ... 536870912 bytes allocated.
> 
> real    0m40.473s
> user    0m9.290s
> sys     0m3.860s
> andrea@dev4-000:~> 
> 
> (mainline takes 1m 40s, 1 minute more for the same thing)
> 
> I guess I cheated this time though :), see the _only_ change that I did to
> speedup from 68/69 seconds to exactly 40 seconds:

I uploaded a new 2.4.14pre3aa3 patckit with this and the other changes
included (again, under the rule that if this is wrong, MAP_SHARED was
just broken in first place). so you may want to give it a spin and see
if it goes better now. Of course also verify that you are doing a
reliable benchmark by always using -b option, or apply my patch to fix
the breakage of the -p option of the benchmark. Of course background
load matters too, so no updatedb or netscape or whatever, just mp3blast
and the benchmark with -b or with fixed -p, so we make sure to compare
apples to apples :). thanks!

(this isn't very well tested [my desktop still runs 2.4.14pre3aa2], but the
4-way 4G+2G at osdlab is under heavy swapout load and it doesn't complain yet

 1  2  0 449880   4984    164   1644 7092 5760  7092  5760  371   528  25   2  73
 1  2  0 449696   4724    164   1644 6912 6528  6912  6528  356   505  25   2  74
 1  2  1 450656   5504    168   1644 6112 6912  6116  6912  329   452  25   2  73
 1  2  1 450340   5248    164   1644 6924 6400  6924  6404  362   511  25   1  74
 1  2  1 450248   5188    164   1644 6632 6400  6632  6400  350   492  25   1  74
 1  2  1 449988   4900    164   1644 6544 6144  6544  6144  349   485  25   1  74
 1  2  0 449340   4288    164   1644 6432 5600  6432  5600  345   479  25   2  73
 1  2  2 450296   5432    168   1644 5632 6432  5636  6432  321   432  25   1  74
 2  1  0 449924   4652    164   1644 6028 5360  6028  5364  330   440  19   8  73
 1  2  0 450276   5264    164   1644 6036 6400  6036  6400  339   476  25   1  74
 1  2  1 450744   5428    164   1644 6696 6928  6696  6928  356   496  25   1  74
 1  2  1 450328   5244    164   1644 6848 6268  6848  6268  353   514  25   2  73
 1  2  2 450156   4924    168   1644 6912 6652  6916  6652  358   510  25   1  74
 1  2  0 449876   4608    164   1644 6180 5640  6180  5644  337   464  25   1  74
 1  2  0 450152   4976    164   1644 6284 6516  6284  6516  338   468  25   2  73
 1  2  1 451188   5184    164   1648 6560 6624  6560  6624  347   474  25   1  74
 1  2  1 448620   3480    164   1644 6748 4780  6748  4780  353   481  25  18  57
 1  2  0 449520   4348    164   1644 5868 6528  5868  6528  330   450  25   0  75
 1  2  0 450460   5012    164   1644 6240 7016  6240  7016  343   459  25   1  74
 1  2  0 450524   5028    164   1644 6616 6552  6616  6552  353   484  25   1  74
 1  2  0 449928   4620    164   1644 6952 6136  6952  6136  365   511  25   2  73
 1  2  0 450036   4936    164   1644 6336 6408  6336  6408  341   460  25   3  72
 1  2  1 450560   5156    168   1644 6172 6400  6176  6400  335   466  25   1  74

again the sane 12/13mbyte/sec of bandwith, instead of the previous 7mbyte/sec)

oom mmap001 failures should be cured (untested though), as said the bug was
pretty obvious after I got the report, thanks!

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre3aa3.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre3aa3/

Only in 2.4.14pre3aa2: 00_files_struct_rcu-2.4.10-04-3
Only in 2.4.14pre3aa3: 00_files_struct_rcu-2.4.10-04-4

	Fixed missing var initialization.

Only in 2.4.14pre3aa2: 10_vm-6
Only in 2.4.14pre3aa3: 10_vm-7
Only in 2.4.14pre3aa3: 10_vm-7.1

	Further vm changes, should fix mmap001 failures and improve
	swapout performance.

Only in 2.4.14pre3aa3: 52_u64-1

	Minor compile fix for uml.

BTW, you can still tweak the /proc/sys/vm/vm_* parameters. there's the
updated commentary in mm/vmscan.c. default values should be sane. As usual an
unit change isn't going to make relevant differences, those numbers doesn't
need to be perfect.

Andrea
