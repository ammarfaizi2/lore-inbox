Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291373AbSAaWVi>; Thu, 31 Jan 2002 17:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291374AbSAaWV3>; Thu, 31 Jan 2002 17:21:29 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:11939 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291373AbSAaWVV>; Thu, 31 Jan 2002 17:21:21 -0500
Importance: Normal
Sensitivity: 
Subject: Test results of context-switch under O(1) J9 scheduler
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: "ltc performance" <ltc_performance@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFF03F0C65.2FDC42C6-ON85256B52.007A8452@raleigh.ibm.com>
From: "Duc Vianney" <dvianney@us.ibm.com>
Date: Thu, 31 Jan 2002 16:21:18 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/31/2002 05:21:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The O(1) J9 scheduler with changes to generic context-switch definitely
provides the best context-switch latency time based on the lat_ctx test
from LMBench benchmark. Test hardware was a 2-way SMP system with 512MB
memory. The results obtained from a 2.4.17 SMP kernel built with O(1)J2,
O(1)J4 and O(1)J9 versions, compared against 2.2.19 base and 2.4.17 base.
The data are time in microsecs. In almost all test cases, context switches
under O(1)J9 seem much faster than 2.4.17 base, and as fast as 2.2.19 (or
better at heavy load). The 2.2.19 measurements were used as a reference
point for 2.2.x.

                                    Ratio of
      Base  Base  O(1)J2      O(1)J4      O(1)J9      O(1)J9 /
Kernel      2.2.19      2.4.17      2.4.17      2.4.17      2.4.17
2417Base

lat_ctx -s 0 2 4 8 16 32 64
2     1.46  3.03  7.38  7.38  0.97  32.0%
4     2.04  3.55  4.84  4.89  4.97  140.2%
8     2.74  4.41  6.04  4.96  4.43  100.6%
16    3.01  4.78  4.93  5.46  3.82  80.0%
32    5.48  7.29  4.80  5.75  4.56  62.6%
64    5.74  8.37  5.86  6.12  5.62  67.1%

lat_ctx -s 16 2 4 8 16 32 64
2     14.33 16.15 15.62 15.11 13.93 86.3%
4     14.30 16.13 17.83 16.27 16.51 102.4%
8     14.39 16.38 17.58 17.35 15.20 92.8%
16    16.43 19.34 17.75 17.70 16.54 85.6%
32    39.92 39.93 24.63 24.95 32.65 81.8%
64    53.67 49.87 45.34 42.76 49.91 100.1%

lat_ctx -s 32 2 4 8 16 32 64
2     22.86 24.73 27.56 27.03 24.29 98.2%
4     22.85 24.85 25.98 25.78 25.22 101.5%
8     25.18 30.94 26.51 26.65 25.04 81.0%
16    58.70 74.32 38.69 35.07 48.32 65.0%
32    99.16 94.41 74.32 74.85 89.62 94.9%
64    99.28 96.91 98.45 97.75 94.29 97.3%

lat_ctx -s 64 2 4 8 16 32 64
2     40.24 42.06 44.57 44.11 40.72 96.8%
4     49.10 43.28 43.23 43.99 42.85 99.0%
8     111.28      105.56      49.43 45.81 58.41 55.3%
16    185.12      182.84      127.11      124.74      169.94      92.9%
32    185.20      182.81      184.97      182.92      175.70      96.1%
64    185.26      184.46      186.54      186.22      178.63      96.8%


Duc.

