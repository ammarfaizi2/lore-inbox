Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbRJNHfU>; Sun, 14 Oct 2001 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJNHfN>; Sun, 14 Oct 2001 03:35:13 -0400
Received: from robin.mail.pas.earthlink.net ([207.217.120.65]:58706 "EHLO
	robin.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S274683AbRJNHe7>; Sun, 14 Oct 2001 03:34:59 -0400
From: rwhron@earthlink.net
Date: Sun, 14 Oct 2001 03:37:26 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.12aa1 and 2.4.13-pre2aa1
Message-ID: <20011014033726.A299@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Test:
>>
>> Run loop of 10 iterations of Linux Test Project's "mtest01 -p80 -w"
>> This test attempts to allocate 80% of virtual memory and write to
>> each page.  Simulataneously listen to mp3blaster.
>>
> You should try out 2.4.13pre2.aa1.. 

Elapsed (wall clock) time in seconds is much better in 2.4.13-pre2aa1:

2.4.12aa1

Averages for 10 mtest01 runs
bytes allocated:                    1253362892.8
User time (seconds):                2.099
System time (seconds):              2.823
Elapsed (wall clock) time:          64.109
Percent of CPU this job got:        7.5%
Major (requiring I/O) page faults:  135.2
Minor (reclaiming a frame) faults:  306779.8

2.4.13-pre2aa1

Averages for 10 mtest01 runs
bytes allocated:                    1245184000
User time (seconds):                2.050
System time (seconds):              2.874
Elapsed (wall clock) time:          49.513
Percent of CPU this job got:        9.7%
Major (requiring I/O) page faults:  115.6
Minor (reclaiming a frame) faults:  304781.9


Note on mp3blaster audio performance:

2.4.12aa1 got smooth at a lower swpd number than 2.4.13-pre2aa1.
2.4.12aa1 became smooth when swpd hit around 130000-140000 (and above).
2.4.13-pre2aa1 became smooth when swpd hit around 280000-300000 (and above).

2.4.13-pre2aa1 vmstat 1 output.  This is an example from one of the 10 iterations.
At the point the vmstat output starts, mp3blaster has been playing smoothly for
about 20 seconds.

 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  2  1 554920   1564   1188   2312  44 10092   432 10188  498   719   3   7  91
 0  3  1 565652   2288   1192   2400  16 10248   388 10248  423   604   4   9  87
 2  1  1 574848   1628   1196   2388  48 9780   488  9780  449   650   2   5  93
 2  1  1 586608   1780   1188   2320  56 10704   400 10704  498   682   2   6  92
 2  1  1 603504   1784   1184   2316   0 17536   300 17536  457   626   2  10  88
 1  2  1 621424   2552   1180   2316   0 18152    64 18192  463   632   3  14  83
 0  2  1 640880   2556   1184   2316   0 18340    72 18340  484   687   2   9  89
 1  2  1 660848   2036   1180   2316   0 20156    60 20156  487   657   6   8  86
 3  0  1 678768   1788   1184   2320   0 17356    76 17356  488   696   3  13  84
 0  2  1 696176   2540   1176   2324   0 19416    60 19416  472   667   4   8  89
 2  2  1 716144   1656   1172   2324   0 18060    68 18084  481   678   2  13  85
 0  2  1 738160   2172   1176   2316  12 23544    88 23544  566   772   6   7  88
 3  0  0  14700 316844   1236   2640 284 2048   656  2048  415   728  24  37  39

 Around here, mp3blaster begins to stutter.

 2  0  0  14696  51576   1236   2768  64   0   192     0  278   579  49  51   0
 1  3  1  26728   3384   1188   2024 612 16232   732 16272  675   710   7  13  80
 0  3  1  39312   2512   1196   2076 248 13516   428 13520  414   487   4   2  94
 3  1  1  50420   1912   1176   2016 216 11800   356 11800  389   397   4   2  95
 1  2  0  66564   2568   1184   2008 288 13844   432 13844  458   484   4   4  92
 1  2  1  80204   2036   1180   2000 196 16296   256 16320  509   494   2   7  91
 1  1  1  97400   1784   1184   2000 236 16848   308 16848  509   464   2   7  92
 1  2  1 116720   1904   1180   2000 120 19076   176 19076  508   429   6   5  88
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  2  1 134488   3060   1188   2000 152 17124   212 17124  485   411   7   4  89
 0  3  1 151236   3056   1184   2000 148 17716   196 17716  411   360   3   8  89
 0  3  1 168032   2560   1176   2008 100 15928   160 15952  443   371   4   6  91
 2  1  1 187324   1784   1180   2000 164 20480   460 20480  516   421   6   7  87
 2  1  1 200484   1784   1184   2004 152 14752   212 14752  475   372   1   8  91
 0  3  1 220224   3432   1184   2000 228 18560   288 18560  483   437   4   8  89
 2  0  2 236512   1640   1200   2000 116 16384   160 16396  437   392   5   7  88
 0  3  1 253836   3188   1184   2000  84 15284   132 15316  373   343   2   5  93
 1  1  1 270624   2052   1176   2000 104 19536   160 19536  508   581   4   8  88

 At this point, mp3blaster is smooth again.

 2  1  1 294176   1628   1176   2004   0 23420    68 23420  544   741   5   8  87
 2  2  1 317728   3572   1184   2000   0 23588    60 23588  532   740   3   7  90
 0  2  1 335136   3584   1180   2000   0 18080    68 18104  482   669   4   7  90
 0  2  1 356128   2040   1176   2004   0 20244    68 20244  511   702   5   8  87
 0  2  1 373024   1656   1184   2004   0 17960    72 17960  521   695   3   8  89
 0  2  1 394528   1660   1180   2000   0 19900   300 19900  480   655   6   9  86
 1  2  1 413984   2056   1184   2000   0 19924    56 19924  480   678   6   8  87
 0  1  0 433952   3620   1172   2004   0 20488    60 20512  498   696   7   5  88
 1  2  1 458528   1628   1176   2000   0 24100    72 24100  559   766   5   7  88
 2  0  1 478496   3072   1172   1996   0 21288    68 21288  498   692   7  10  82
 0  2  1 499132   1852   1176   1124   0 20172    76 20172  514   696   5  10  84
 0  3  2 520632   1648   1208   1120   4 20524    72 20536  505   691   5   9  86
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  4  1 531272   2792   1212   1164 216 11492   548 11504  574   896   3   3  94
 1  3  1 539920   2144   1208   1320  52 7864   444  7864  411   624   1   6  93
 0  3  1 556728   1664   1180   1188 104 18012   180 18012  518   736   5  12  82
 3  0  1 573612   1784   1188   1296  32 17096   452 17096  500   698   4   9  88
 1  1  1 590508   1784   1176   1212   0 16380    68 16404  473   675   4   6  90
 2  1  1 610988   1912   1184   1212   0 20820    84 20820  529   723   2  11  87
 1  1  1 629420   2412   1172   1216   0 18148    72 18148  474   660   2  10  88
 2  1  1 650924   1744   1180   1220   0 21452    72 21452  544   786   5   9  86
 0  2  1 669868   1600   1180   1216   0 19388    64 19388  468   650   3  10  88
 1  2  1 688300   2552   1180   1216   0 16476    64 16512  462   646   4  11  85
 0  2  1 706220   3032   1184   1216   0 19212    72 19212  487   682   7   8  86
 0  2  1 728748   2548   1176   1220   0 23644    64 23644  530   712   2  15  84
 2  0  0  13904 460316   1228   2292 220 6784  1364  6784  508   765   4  20  76
 2  0  0  13904 196080   1244   2292   0   0     0    36  282   559  42  58   0
 1  3  1  20304   2796   1184   1392 116 10740   152 10740  568   716  21  32  48
 4  0  1  37960   1784   1176   1392 276 17428   348 17428  551   470   4   9  87
 0  2  1  53588   2208   1176   1388 248 15076   308 15076  469   439   4   4  93


 Each iteration behaves consistantly.


Scripty for summarizing mmtest output:


#!/usr/bin/perl -w
# chkmmt - check mmtest output (/usr/bin/time -v and mtest01) 

# variables for interesting information
my ($allocated, $utime, $stime, $pct_cpu, $w_min, $w_secs, $maj_faults, $min_faults);
my ($tot_allocated, $tot_utime, $tot_stime, $tot_pct_cpu, $tot_w_secs, 
	$tot_maj_faults, $tot_min_faults);

my $count_runs;

# junk
my ($p, $d, $b, $a, $u, $t, $s);

#PASS ... 1244659712 bytes allocated.
#	User time (seconds): 2.01
#	System time (seconds): 2.84
#	Percent of CPU this job got: 8%
#	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:59.02
#	Major (requiring I/O) page faults: 108
#	Minor (reclaiming a frame) page faults: 304655

# read a logfile from mmtest script  (stdin)
while (<>) {
	if (/allocated/o) {
		($p, $d, $allocated, $b, $a) = split;
		$tot_allocated += $allocated;
		$count_runs++;
	} elsif (/User/o) {
		($u, $t, $p, $utime) = split;
		$tot_utime += $utime;
	} elsif (/System/o) {
		($s, $t, $p, $stime) = split;
		$tot_stime += $stime;
	} elsif (/Percent/o) {
		s/.* (\d+)%/$1/;
		$percent = $_;
		$tot_pct_cpu += $percent;
	} elsif (/Elapsed/o) {
		s/.*\): //o;
		($w_min, $w_secs) = split ':';
		$tot_w_secs += ($w_min * 60);
		$tot_w_secs += $w_secs;
	} elsif (/Major/o) {
		s/.*: //o;
		$maj_faults = $_;
		$tot_maj_faults += $maj_faults;
	} elsif (/Minor/o) {
		s/.*: //o;
		$min_faults = $_;
		$tot_min_faults += $min_faults;
	}
}

# print summary:

print  "Averages for $count_runs mtest01 runs\n";
print  "bytes allocated:                    ", $tot_allocated / $count_runs, "\n";
printf "User time (seconds):                %.3f\n", $tot_utime / $count_runs;
printf "System time (seconds):              %.3f\n", $tot_stime / $count_runs;
printf "Elapsed (wall clock) time:          %.3f\n", $tot_w_secs / $count_runs;
print  "Percent of CPU this job got:        ", $tot_pct_cpu / $count_runs, "%\n";
print  "Major (requiring I/O) page faults:  ", $tot_maj_faults / $count_runs, "\n";
print  "Minor (reclaiming a frame) faults:  ", $tot_min_faults / $count_runs, "\n";

# end of script


-- 
Randy Hron

