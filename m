Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292121AbSBAWx4>; Fri, 1 Feb 2002 17:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292123AbSBAWxg>; Fri, 1 Feb 2002 17:53:36 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18665 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292121AbSBAWx0>; Fri, 1 Feb 2002 17:53:26 -0500
Importance: Normal
Sensitivity: 
Subject: context-switch under 2.4.18pre7aa2 and 2.4.18pre7+O(1)J9
To: andrea@suse.de, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Cc: "ltc performance" <ltc_performance@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF478AC24A.EEF7EA7E-ON85256B53.007AAA30@raleigh.ibm.com>
From: "Duc Vianney" <dvianney@us.ibm.com>
Date: Fri, 1 Feb 2002 16:53:16 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/01/2002 05:53:18 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hello, I'd be curious if you could add a column for 2.4.18pre7aa2 too, I
>did some optimization there, and I'd like to be sure it doesn't perform
>worse than 2.4.17 at least :). thanks,

>Andrea

The following results are context-switch latency time in microseconds,
taken under various test scenarios for lat_ctx.
Test configuration: smp 2-way 550 MHz, 512MB, smp kernel built.
Kernel under test: 2.4.17base, 2.4.17+O(1)J9, 2.4.18pre7base,
     2.4.18pre7+O(1)J9, and 2.4.18pre7aa2.

Basic Results:
=> ctx in 2.4.18pre7aa2 is as fast as in 2.4.17 base.
=> ctx in 2.4.17pre7aa2 seems faster than in 2.4.18pre7 base.
=> ctx in 2.4.18pre7 base is slightly slower than in 2.4.17 base.
=> O(1)J9 helps ctx in either 2.4.17 base or 2.4.18pre7 base.

Test Data:

Test case: lat_ctx -s 0 2 4 8 16 32 64
                Base     O(1)J9  Base        O(1)J9      aa2
# of processes  2.4.17   2.4.17  2.4.18pre7  2.4.18pre7  2.4.18pre7
      2         3.03     0.97    3.27        0.93        3.07
      4         3.55     4.97    3.80        4.28        3.51
      8         4.41     4.43    4.55        3.92        4.39
      16        4.78     3.82    4.71        3.50        5.35
      32        7.29     4.56    5.70        4.53        6.62
      64        8.37     5.62    7.73        5.73        7.49

Test case: lat_ctx -s 16 2 4 8 16 32 64
                Base     O(1)J9  Base        O(1)J9      aa2
# of processes  2.4.17   2.4.17  2.4.18pre7  2.4.18pre7  2.4.18pre7
      2         16.15    13.93   16.83       13.80       16.25
      4         16.13    16.51   16.76       15.18       16.19
      8         16.38    15.20   17.24       15.32       16.20
      16        19.34    16.54   25.57       16.48       18.53
      32        39.93    32.65   38.95       27.77       22.33
      64        49.87    49.91   48.53       45.73       52.28

Test case: lat_ctx -s 32 2 4 8 16 32 64
                Base     O(1)J9  Base        O(1)J9      aa2
# of processes  2.4.17   2.4.17  2.4.18pre7  2.4.18pre7  2.4.18pre7
      2         24.73    24.29   25.36       23.12       24.68
      4         24.85    25.22   25.37       25.30       25.08
      8         30.94    25.04   33.86       24.61       31.34
      16        74.32    48.32   58.81       43.20       35.71
      32        94.41    89.62   77.29       93.76       79.53
      64        96.91    94.29  100.88       92.95      102.02

Test case: lat_ctx -s 64 2 4 8 16 32 64
                Base     O(1)J9  Base        O(1)J9      aa2
# of processes  2.4.17   2.4.17  2.4.18pre7  2.4.18pre7  2.4.18pre7
      2         42.06    40.72   42.88       41.54       42.46
      4         43.28    42.85   56.71       46.40       45.38
      8        105.56    58.41  102.62       55.49       54.56
      16       182.84   169.94  141.00      164.39      124.70
      32       182.81   175.70  184.79      170.11      187.15
      64       184.46   178.63  188.30      184.97      189.13

Duc.... dvianney@us.ibm.com


