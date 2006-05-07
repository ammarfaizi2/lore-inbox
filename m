Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWEGBEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEGBEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 21:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEGBEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 21:04:16 -0400
Received: from mail.pioneer-pra.com ([65.205.244.70]:25765 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by vger.kernel.org with ESMTP
	id S1750798AbWEGBEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 21:04:15 -0400
From: Jason Schoonover <jasons@pioneer-pra.com>
Organization: Pioneer PRA
To: bert hubert <bert.hubert@netherlabs.nl>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Date: Sat, 6 May 2006 18:02:47 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200605051010.19725.jasons@pioneer-pra.com> <20060506230320.GA3463@outpost.ds9a.nl>
In-Reply-To: <20060506230320.GA3463@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3cUXEZIcwsrXnMc"
Message-Id: <200605061802.47261.jasons@pioneer-pra.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3cUXEZIcwsrXnMc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Bert,

That's interesting, I didn't know that about the vmstat command, I will 
definitely use that more in the future.  I went ahead and did an ncftpget and 
started vmstat 1 at the same time, I've attached the output here.  It looks 
like the 'id' column was at 100, and then as soon as I started ncftpget, it 
went down to 0 the whole time.

The interesting thing was that after I did a Ctrl-C on the ncftpget, the id 
column was still at 0, even though the ncftpget process was over.  The id 
column was at 0 and the 'wa' column was at 98, up until all of the pdflush 
processes ended.

Is that the expected behavior?

Jason

-------Original Message-----
From: bert hubert
Sent: Saturday 06 May 2006 16:03
To: Jason Schoonover
Subject: Re: High load average on disk I/O on 2.6.17-rc3

On Fri, May 05, 2006 at 10:10:19AM -0700, Jason Schoonover wrote:
> Whenever I copy any large file (over 500GB) the load average starts to
> slowly rise and after about a minute it is up to 7.5 and keeps on rising
> (depending on how long the file takes to copy).  When I watch top, the
> processes at the top of the list are cp, pdflush, kjournald and kswapd.

Load average is a bit of an odd metric in this case, try looking at the
output from 'vmstat 1', and especially the 'id' column. As long as that
doesn't rise, you don't have an actual problem.

The number of processes in the runqueue doesn't really tell you anything
about how much CPU you are using.

Having said that, I think there might be a problem to be solved.

	Bert

--Boundary-00=_3cUXEZIcwsrXnMc
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmstat-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vmstat-1.txt"

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0     40 1991860   9444  14900    0    0    57   136  148     8  0  0 98  1
 0  0     40 1991860   9452  14892    0    0     0   372 1048    24  0  0 100  0
 0  0     40 1991860   9464  14880    0    0     4    36 1051    75  0  0 100  1
 0  0     40 1991860   9464  14880    0    0     0     0 1032    52  0  0 100  0
 0  0     40 1991860   9464  14880    0    0     0     0 1033    42  0  0 100  0
 1  0     40 1971532   9536  35480    0    0   236     0 4944   401  1 10 87  4
 1  0     40 1891056   9620 114616    0    0     4   176 17382   276  1 35 65  0
 1  1     40 1805372   9712 198232    0    0     4 48784 18660   285  1 38 52  9
 1  3     40 1723160   9792 279208    0    0     0 70868 18481   318  1 39 19 43
 0  4     40 1704684   9812 297344    0    0     4 16480 4864   127  0  8  0 92
 1  3     40 1657068   9860 344148    0    0     0 18040 10767   245  0 21  0 78
 0  2     40 1581072   9940 420636    0    0     0  2436 16886   332  1 40 17 43
 1  4     40 1521800  10000 477152    0    0     4 34660 12934   306  0 30 12 58
 1  4     40 1441696  10076 554936    0    0     0 26912 17277   338  0 35  0 64
 0  4     40 1399660  10120 595760    0    0     4 31944 9725   251  0 19  0 81
 1  4     40 1326128  10192 667292    0    0     0 34668 15984   339  1 33  0 67
 1  4     40 1273056  10244 718648    0    0     4 35376 11855   266  0 24  0 76
 1  4     40 1190968  10324 798468    0    0     0 10228 17557   357  1 35  5 59
 1  4     40 1112724  10396 874624    0    0     0 27844 16982   376  1 34  5 61
 0  5     40 1044168  10468 941668    0    0     4 32492 15184   346  0 30  2 67
 1  4     40 997668  10512 986912    0    0     0 22632 10538   244  1 22  0 78
 0  4     40 926120  10576 1056344    0    0     0 13724 15436   332  1 34  0 65
 1  5     40 889656  10628 1094712    0    0     4 28000 9218   285  0 22  5 74
 0  6     40 859028  10660 1124600    0    0     0 13768 7295   196  0 15  0 84
 0  7     40 833856  10684 1148852    0    0     0 12324 6169   165  0 12  0 88

 Did a Ctrl-C here

 0  2     40  47312   7888 1920116    0    0     0 36452 1353    52  0  2 39 60
 0  2     40  47816   7888 1920116    0    0     0 36264 1354    56  0  1  0 99
 0  2     40  48312   7888 1920116    0    0     0 36248 1362    52  0  1  0 99
 0  2     40  48808   7888 1920116    0    0     0 36040 1362    56  0  1  0 99
 0  2     40  49180   7888 1920116    0    0     0 36592 1360    54  0  2  0 99
 0  2     40  49552   7888 1920116    0    0     0 36064 1355    56  0  2  0 98
 0  2     40  50048   7888 1920116    0    0     0 36576 1360    54  0  2  0 99
 0  2     40  50544   7888 1920116    0    0     0 36340 1351    57  0  1  0 99
 0  2     40  51040   7888 1920116    0    0     0 36164 1352    51  0  2  0 99
 0  2     40  51412   7888 1920116    0    0     0 36044 1367    57  0  1  0 99
 0  2     40  51908   7888 1920116    0    0     0 36204 1359    51  0  1  0 99
 0  2     40  52404   7888 1920116    0    0     0 36012 1363    55  0  2  0 99
 0  2     40  52776   7888 1920116    0    0     0 36280 1362    68  0  1  0 99
 0  2     40  53140   7888 1920116    0    0     0 36236 1395   251  0  2  0 98
 0  2     40  53760   7888 1920116    0    0     0 36316 1359    53  0  2  0 99
 0  2     40  54504   7888 1920116    0    0     0 36468 1356    55  0  2  0 98

--Boundary-00=_3cUXEZIcwsrXnMc--
