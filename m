Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUCXCe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUCXCe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:34:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49549
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262972AbUCXCew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:34:52 -0500
Date: Wed, 24 Mar 2004 03:35:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and patch]
Message-ID: <20040324023540.GA2278@dualathlon.random>
References: <20040322175216.GJ3649@dualathlon.random> <Pine.LNX.4.44.0403221842060.12658-100000@localhost.localdomain> <20040322195826.GA22639@dualathlon.random> <20040323214459.GG3682@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323214459.GG3682@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 10:44:59PM +0100, Andrea Arcangeli wrote:
> This is incremental with 2.6.5-rc2-aa1 and it should allow swapping of
> nonlinear mappings too. Has anybody a testcase that I can use to test

I wrote a test app swapping around 1G with 200 tasks mapping 1.7G each after
marking the vmas nonlinear. It's not exactly a smooth-swapping
(expected) but it seems to work just fine (I admit the first few seconds I
wondered if it was deadlocking until I pressed SYSRQ+P and I've seen
idle cpus and then disk running too, so I waited some more ;)

 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
12  1      0 912564  26824  45188    0    0    18     5  270    18  0  0 99  0
19  1      0 684436  26824 269928    0    0     0     0 1087 27560 11 89  0  0
33  0      0 542148  26824 408172    0    0     0     0 1086   104 13 87  0  0
47  2      0 432956  26824 513164    0    0     0     0 1084   104 16 84  0  0
54  0      0 357364  26824 584768    0    0     0     0 1085    86 15 85  0  0
61  0      0 287980  26832 650176    0    0     0    44 1090    95 16 84  0  0
68  0      0 238244  26832 695872    0    0     0     0 1086    81 16 84  0  0
75  0      0 191132  26832 738984    0    0     0     0 1085    82 16 84  0  0
75  0      0 139676  26832 786584    0    0     0     0 1086    75 16 84  0  0
82  0      0 100868  26832 821468    0    0     0     0 1083    82 17 83  0  0
82  0      0  57028  26832 861452    0    0     0     0 1085    72 16 85  0  0
89  0      0   6920  23248 910936    0    0     0     0 1103    85 15 85  0  0
89  2      0   5140  11440 919208    0    0     0   240 2177   738 11 89  0  0
90 71   2160   2048    332 934084    0  284     0   284 1823  2255  5 91  0  4
95 67  11564   6440    332 929572   44 11236    44 11236 1384   582  6 94  0  0
 0 98 751260   2276    192 710688 88296 628492 90828 628640 104070 47927  1 18  0 81
 0 98 751464   6052    200 711364   64 2924   712  2924 1580   161  0  0  0 100
 1 96 752124   2312    200 717264  256 5720   380  5748 1736   170  0  3  0 97
 0 97 750392   2384    204 718800 2432 4608  2432  4612 1319   373  0  1  0 99
 0 97 750968   2516    204 720672  128 3796   128  3796 1612   119  0  2  0 98
 0 97 750260   2640    204 724312  472 3968   472  3968 1401   146  0  1  0 99
 0 97 751816   2384    212 726712  792 4124   912  4124 1701   256  0  2  0 98
 0 97 772464   2240    216 714092  176 7320   176  7348 1875   292  2 22  0 77
 0 97 776016   2248    216 735556  100 37828   100 37828 1457   228  1  4  0 95
 0 97 773044   6024    216 738528 3984 3124  3984  3124 1223   451  0  1  0 100
 0 97 769832   2504    216 741740 3792    0  3792     0 1253   491  0  0  0 100
 0 97 773096   2448    216 738688 3296 10048  3296 10048 1330   512  0  2  0 98
 0 209 771488   2192    216 750164  960 25636   960 25636 1424  7683  1  7  0 92
 0 209 772984   2272    216 769216 2120 7880  2120  7880 1331  8610  1 12  0 87
 0 209 776216   2292    216 772664 2744 2584  2744  2584 1439  1522  1 13  0 86
 0 208 775828   2740    220 776292  556 6912   688  6912 1628   651  1  6  0 93
 0 208 778384   3280    220 778492  544 15796   544 15796 1719   401  0  2  0 98
 0 208 784516  23548    220 771880  440 17764   440 17764 1564  2062  0  4  0 97

it's like going back to the 2.4 swapping behaviour. If those nonlinear mappings
are big and they must be swapped efficiently, remap_file_pages should not be
used. Of course mlock on top of nonlinear will fix it completely.

I doubt we can do much better than this w/o throwing lots of memory at tracking
ptes (like rmap did with the pte_chains), but IMO the pte_chains would
invalidate the point of the nonlinear vmas (if one has to pay for the
pte_chains then one can as well use the vmas since the cost is the same as far
as there are at least a dozen pages per-vma). I think this way is
optimal, remap_file_pages wants to be even faster and scalable and with
less memory footprint for the fast path, at the expense of a less
efficient and less scalable swapping.

to make a comparions this is the swapping of the linear vmas instead
(i.e. the only one we care about, it's quite cpu dominated too and
mostly spent in the trylocks).

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
11  4   5660 959856   2428  29728  220  359   241   362  301   183  0  3 69 28
27  4   5660 747060   2440 239292    0    0     0   180 1089 22479 11 89  0  0
34  1   5660 627052   2448 355496    0    0     0    84 1092   103 13 87  0  0
41  0   5660 523868   2448 454708    0    0     0     0 1084    91 15 85  0  0
49  2   5660 431772   2448 542904    0    0     0     0 1085    88 15 85  0  0
62  1   5660 362204   2448 608320    0    0     0     0 1084    98 14 86  0  0
62  0   5660 302492   2448 664420    0    0     0    48 1093    77 16 84  0  0
69  0   5660 241628   2448 721336    0    0     0     0 1085    79 16 84  0  0
76  0   5660 171020   2448 787976    0    0     0     0 1086    85 15 85  0  0
83  0   5660 126212   2448 828844    0    0     0     0 1085    81 17 83  0  0
83  1   5660  60036   2448 891336    0    0     0     0 1086    70 15 85  0  0
90  1   5660  35764   2448 911464    0    0     0     0 1084    89 16 84  0  0
92  1   3704   2332    704 946516    0  196     0   384 1129    80 12 88  0  0
91  0   9148   3400    332 947688    0 5660     0  5660 1130   129 10 90  0  0
69 28  13252   2064    300 949800  224 3208   344  3208 1161   397  9 91  0  0
80 38  30192   4112    300 942908  584 15468   676 15468 1512  3754  6 94  0  0
89 45  43508   3640    308 940204  932 15304  1052 15316 1469  4564  4 96  0  0
66 74  56072   5156    316 939460 2684 13432  2832 13432 1392 13575  5 95  0  0
69 75  68248   5236    184 937780 3008 12592  3412 12600 1414 17344  2 98  0  0
62 81  79076   7576    132 932404 3964 10836  3964 10836 1526 28044  1 99  0  0
106 95  84068   4444    132 934540 4052 6912  4052  6912 1466 24908  0 100  0  0
107 92  87864   6072    140 930740 3068 4468  3164  4468 1509  4045  0 100  0  0
12 100  92592   6068    148 926096 5156 5424  5156  5440 1508 25626  1 100  0  0
99 93  96872   5572    148 926840 3972 5548  4024  5548 1449 20534  0 100  0  0
107 92 101304   7984    148 922492 3608 5304  3656  5304 1491 14817  0 100  0  0
100 90 105340   8416    148 922012 5592 5400  5592  5400 1439 19803  0 100  0  0
107 89 108688   7376    148 918572 4600 4496  4600  4496 1383 12725  0 100  0  0
108 93 113168   4876    148 918512 5440 5780  5440  5780 1383 23260  0 100  0  0
96 90 116820   4816    148 914956 5192 5008  5192  5008 1342 11427  1 100  0  0
89 99 121152   3288    148 913044 5580 5772  5580  5772 1382 29699  0 100  0  0
107 96 124948   4048    164 912236 4220 4832  4432  4832 1407  7537  0 100  0  0
90 94 128348   4284    164 909940 5056 4656  5056  4656 1398 14028  0 100  0  0
108 90 132028   2472    144 913728 3688 4640  3688  4640 1413  3582  0 100  0  0
89 91 135484   3256    144 911400 4516 4556  4516  4556 1401 11283  0 100  0  0
108 90 139644   2952    144 910092 4268 5084  4268  5084 1500 19229  1 100  0  0
107 89 143772   2636    144 907696 4492 5084  4492  5084 1467 14234  0 100  0  0
82 85 147720   6904    140 903788 3800 4820  3840  4820 1413 11291  0 100  0  0
106 96 152536   2808    140 904904 4520 5940  4520  5940 1417 29255  0 100  0  0

I also found a race condition during the testing:

this bug triggered in unmap_pte_page:

	BUG_ON(!page->mapcount);

that was because I was running page_add_rmap outside the page_table_lock in the
do_anonymous_page. We must do lru_cache_add + set_pte + page_add_rmap
atomically in the same critical section protected by the same page_table_lock
to prevent the swap side to try to unmap pages that have not been tracked by
page_add_rmap (and in turn anon_vma) yet. Fix is easy:

--- x/mm/memory.c.~1~	2004-03-23 23:29:19.000000000 +0100
+++ x/mm/memory.c	2004-03-24 03:30:27.850181344 +0100
@@ -1354,13 +1354,14 @@ do_anonymous_page(struct mm_struct *mm, 
 	set_pte(page_table, entry);
 	pte_unmap(page_table);
 
+	/* ignores ZERO_PAGE */
+	page_add_rmap(page, vma, addr, anon);
+
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
 	spin_unlock(&mm->page_table_lock);
 	ret = VM_FAULT_MINOR;
 
-	/* ignores ZERO_PAGE */
-	page_add_rmap(page, vma, addr, anon);
 
 	return ret;
 }
