Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTJIKeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTJIKeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:34:06 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:20435 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261695AbTJIKeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:34:00 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.14743.394699.836359@laputa.namesys.com>
Date: Thu, 9 Oct 2003 14:33:59 +0400
To: linux-kernel@vger.kernel.org
Cc: mikeb@netnation.com, Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: File System shootout...
In-Reply-To: <1065636511.29220.34.camel@mikeb.staff.netnation.com>
References: <1065636511.29220.34.camel@mikeb.staff.netnation.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Benoit writes:
 > To all those who are interested, here are the results of the benchmarks
 > I've been running over the last week between all the major file systems
 > (and there different mount options) using both Bonnie++ and IOzone. More
 > tests are currently underway, so the results will be updated as they
 > come in. 
 > 
 > Hopefully these results will give you a good comparative overview of each of the
 > different file systems strengths and weaknesses.
 > 
 > http://fsbench.netnation.com/

I should probably add that I am getting quite different bonnie++ results
for reiser4 vs. ext3:

on the box with 128M of ram:

./bonnie++ -s 1g -n 10 -x 5

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite-   -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
v4.128M          1G 19903  89 37911  20 15392  11 13624  58 41807  12 131.0   0
v4.128M          1G 19965  89 37600  20 15845  11 13730  58 41751  12 130.0   0
v4.128M          1G 19937  89 37746  20 15404  11 13624  58 41793  12 132.1   0
v4.128M          1G 19998  89 37184  19 15007  10 13393  56 41611  11 130.2   0
v4.128M          1G 19771  89 37679  20 15206  11 13466  57 41808  11 130.2   1
ext3.128M        1G 21236  99 37258  22 11357   4 13460  56 41748   6 120.0   0
ext3.128M        1G 20821  99 36838  23 12176   5 13154  55 40671   6 120.7   0
ext3.128M        1G 20755  99 37032  24 12069   4 12908  54 40851   5 120.2   0
ext3.128M        1G 20651  99 37094  24 11817   5 13038  54 40842   6 121.3   0
ext3.128M        1G 20928  99 37300  23 12287   4 13067  55 41404   6 120.1   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
v4.128M          10 18503 100 +++++ +++  9488  99 10158  99 +++++ +++ 11635  99
v4.128M          10 19760  99 +++++ +++  9696  99 10441 100 +++++ +++ 11831  99
v4.128M          10 19583 100 +++++ +++  9672 100 10597  99 +++++ +++ 11846 100
v4.128M          10 19720 100 +++++ +++  9577  99 10126 100 +++++ +++ 11924 100
v4.128M          10 19682 100 +++++ +++  9683 100 10461 100 +++++ +++ 11834 100
ext3.128M        10  3279  97 +++++ +++ +++++ +++  3406 100 +++++ +++  8951  95
ext3.128M        10  3303  98 +++++ +++ +++++ +++  3423  99 +++++ +++  8558  96
ext3.128M        10  3317  98 +++++ +++ +++++ +++  3402 100 +++++ +++  8721  93
ext3.128M        10  3325  98 +++++ +++ +++++ +++  3390 100 +++++ +++  9242 100
ext3.128M        10  3315  97 +++++ +++ +++++ +++  3439 100 +++++ +++  8896  96

./bonnie++ -f -d . -s 3072 -n 10:100000:10:10 -x 1

Version  1.03        ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine         Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
v4                3G           37579  19 15657  11           41531  11 105.8   0
v4                3G           37993  20 15478  11           41632  11 105.4   0
ext3              3G           35221  22 10987   4           41105   6  90.9   0
ext3              3G           35099  22 11517   4           41416   6  90.7   0
		             ------Sequential Create------ --------Random Create--------
		             -Create-- --Read--- -Delete-- -Creat
