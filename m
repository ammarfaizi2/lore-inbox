Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSIYCdw>; Tue, 24 Sep 2002 22:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSIYCdw>; Tue, 24 Sep 2002 22:33:52 -0400
Received: from ip66-105-100-132.z100-105-66.customer.algx.net ([66.105.100.132]:52406
	"HELO godzilla.whitewlf.net") by vger.kernel.org with SMTP
	id <S261857AbSIYCdu>; Tue, 24 Sep 2002 22:33:50 -0400
Date: Tue, 24 Sep 2002 22:38:56 -0400
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Content-Type: text/plain; delsp=yes; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       <linux-kernel@vger.kernel.org>, Adam Taylor <iris@servercity.com>
To: Rik van Riel <riel@conectiva.com.br>
From: Adam Goldstein <Whitewlf@Whitewlf.net>
In-Reply-To: <Pine.LNX.4.44L.0209242223040.22735-100000@imladris.surriel.com>
Message-Id: <EFED8A1D-D02F-11D6-AD2E-000502C90EA3@Whitewlf.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.543)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moya used ext3 as well (I listed the file systems&partitions for each  
machine near the bottom of the post)

It hasn't run out of ram, even though I have set mysql to use -a lot-.  
2Gigs of ram should
be more than enough for this... I would hope. 1.5G was OK before.

These are under current load, i will run a full snap of tests tomorrow  
during peak load.

Can anyone recommend any long term cumulative monitors for vmstat,  
and/or other processes that could run behind the scenes and gather  
cooperative data? Personally, I can't make heads or tails of the vmstat  
output, and, I still have as of yet to get a -real- answer for what   
"load" is.. besides the knee-jerk answer of "its the avg load over X  
minutes".  :)

[root@nosferatu whitewlf]# vmstat -n 1
    procs                      memory    swap          io     system      
     cpu
  r  b  w   swpd   free		buff	  cache 	si  so    bi    bo   in 	cs    us  
   sy  id
  5  5  2  94076 1181592  61740 219676   0   0    10    16  125   111   
69  12  19
  7  2  4  94076 1186024  61752 219664   0   0     0   948  454  1421   
95   5   0
10  2  2  94076 1172288  61764 219672   0   0     0  1024  468  1425   
88  12   0
  7  2  3  94076 1175220  61772 219660   0   0     0  1236  509  1513   
93   7   0
  5  2  2  94076 1187824  61784 219664   0   0     0   864  419  1524   
87  13   0
  8  1  2  94076 1170140  61792 219656   0   0     0   656  362   945   
88  12   0
  5  7  3  94076 1182448  61800 219712   0   0    36   696  580  1616   
93   7   0
  5  4  3  94076 1186500  61808 219740   0   0    12  1252  595  1766   
90  10   0
  8  1  3  94076 1177424  61812 219744   0   0     0  1124  497  1588   
96   4   0
  8  3  3  94076 1167564  61824 219748   0   0     0  1136  485  1476   
88  12   0
  5  4  2  94076 1187024  61836 219740   0   0     0  1204  473  1659   
93   7   0
10  6  3  94076 1180816  61840 219832   0   0    52  1124  668  3079   
73  27   0
  6  6  2  94076 1184404  61840 219932   0   0    88  1356 1110  1886   
94   6   0
  8  4  2  94076 1176276  61852 219948   0   0     0  1324  683  1819   
89  11   0
  6  4  3  94076 1183948  61860 219932   0   0     0   984  441  1296   
92   8   0
11  1  2  94076 1177320  61872 219940   0   0     0   948  448  1351   
88  12   0
12  2  2  94076 1150268  61880 219952   0   0     0   952  438  1206   
88  12   0

here is a snap of top (idles off):
  10:21pm  up 1 day, 19:13,  2 users,  load average: 12.53, 12.30, 11.85
235 processes: 229 sleeping, 6 running, 0 zombie, 0 stopped
CPU0 states: 87.5% user, 12.0% system,  0.0% nice,  0.0% idle
CPU1 states: 90.2% user,  9.4% system,  0.0% nice,  0.0% idle
Mem:  2061772K av,  867640K used, 1194132K free,       0K shrd,    
57560K buff
Swap: 1493808K av,   94080K used, 1399728K free                   
198052K cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
16800 apache    20   0  4732 4260  2988 R    37.7  0.2   0:35 httpd
21171 apache    16   0  4976 4548  3268 R    36.6  0.2   2:02 httpd
  6949 apache    17   0  4604 4132  2936 R    36.5  0.2   0:53 httpd
29183 apache    17   0  4900 4468  3192 R    36.0  0.2   6:18 httpd
21179 root      19   0  1200 1200   812 R     9.3  0.0   0:07 top
21584 amavis     9   0  6840 6840   632 D     3.8  0.3   0:00 sweep
21585 amavis     9   0  6836 6836   632 D     3.8  0.3   0:00 sweep
    21 root      10   0     0    0     0 DW    1.2  0.0  16:52 kjournald
25742 postfix    9   0  1864 1864  1288 D     0.7  0.0   3:46 qmgr
17272 apache     9   0  4412 3924  2928 D     0.6  0.1   0:00 httpd
     4 root      19  19     0    0     0 RWN   0.0  0.0   0:01  
ksoftirqd_CPU1
20854 postfix    9   0  1540 1540  1188 D     0.0  0.0   0:00 cleanup
21362 postfix    9   0  1376 1376  1080 D     0.0  0.0   0:00 smtp
21365 postfix    9   0  1356 1356  1060 D     0.0  0.0   0:00 smtp
21399 apache     9   0  4344 4244  4072 D     0.0  0.2   0:00 httpd
21401 apache     9   0  5212 5112  4176 D     0.0  0.2   0:00 httpd

Also, I ran a bonnie++ test this eve during the nightly lull. It pushed  
the load from about
7 to 16, then settled in at about 12 during the test.

Version 1.02a       ------Sequential Output------ --Sequential Input-  
--Random-
                                   -Per Chr- --Block-- -Rewrite- -Per  
Chr- --Block-- --Seeks--
Machine       Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP   
/sec %CP
nosferatu        4G 14665  88 53478  46 21632  21  5415  27 39694  18  
216.2   2

                            ------Sequential Create------ --------Random  
Create--------
                              -Create-- --Read--- -Delete-- -Create--  
--Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP   
/sec %CP
     64:20000:16/512   876  11  4980  20  3596  14  2497  29   891   4    
578   3
nosferatu,4G,14665,88,53478,46,21632,21,5415,27,39694,18,216.2,2,64:2000 
0:16/512,876,11,4980,20,3596,14,2497,29,891,4,578,3

On Tuesday, September 24, 2002, at 09:28 PM, Rik van Riel wrote:

> On Wed, 25 Sep 2002, Roger Larsson wrote:
>
>> Have you been able to determine if it is I/O bound or CPU bound?
>> Or maybe using to much CPU to do I/O?
>>
>> Does anyone know what virtual memory system does Mandrake uses?
>
> If it's IO bound, it's quite possible the problem is the disk
> elevator and Andrew Morton's read-latency2 patch might help
> somewhat (if the system is heavy on both reads and writes).
>
> If the system is short on RAM and/or swapping, that might be
> a VM thing or just a shortage of RAM...
>
> It would make sense to study the output of top and vmstat for
> a few hours to identify exactly what the problem is, instead
> of trying to fix all kinds of random things that aren't the
> core problem.
>
> regards,
>
> Rik
> -- 
> Bravely reimplemented by the knights who say "NIH".
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> Spamtraps of the month:  september@surriel.com trac@trac.org
>
-- 
Adam Goldstein
White Wolf Networks

