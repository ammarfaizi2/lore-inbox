Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTFCDHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 23:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTFCDHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 23:07:22 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:5506 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264905AbTFCDHU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 23:07:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 100Hz v 1000Hz with contest
Date: Tue, 3 Jun 2003 13:21:44 +1000
User-Agent: KMail/1.5.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306031322.01389.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've attempted to answer the question does 1000Hz hurt responsiveness in 2.5 
as much as I've found in 2.4; since subjectively the difference wasn't there 
in 2.5. Using the same config with preempt enabled here are results from 
2.5.70-mm3 set at default 1000Hz and at 100Hz (mm31):

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          1   79      94.9    0.0     0.0     1.00
2.5.70-mm31         1   77      94.8    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          1   76      97.4    0.0     0.0     0.96
2.5.70-mm31         1   74      98.6    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          2   108     68.5    64.5    28.7    1.37
2.5.70-mm31         2   107     69.2    67.0    29.0    1.39
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          3   114     70.2    1.0     5.3     1.44
2.5.70-mm31         3   105     73.3    0.7     3.8     1.36
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          3   123     62.6    2.3     5.7     1.56
2.5.70-mm31         3   122     61.5    2.0     4.9     1.58
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          4   116     66.4    40.6    18.8    1.47
2.5.70-mm31         4   114     65.8    41.0    19.3    1.48
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          2   116     66.4    50.0    22.2    1.47
2.5.70-mm31         2   112     67.9    46.1    21.4    1.45
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          2   104     75.0    8.2     5.8     1.32
2.5.70-mm31         2   100     76.0    7.5     7.0     1.30
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          2   95      80.0    0.0     7.4     1.20
2.5.70-mm31         2   92      82.6    0.0     5.4     1.19
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          2   98      80.6    53.0    2.0     1.24
2.5.70-mm31         2   95      81.1    53.0    2.1     1.23
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70-mm3          4   313     24.3    5.0     56.9    3.96
2.5.70-mm31         4   297     24.9    4.5     52.5    3.86

At first glance everything looks faster at 100Hz. However it is well known 
that it will take slightly longer even with no load at 1000Hz. Taking that 
into consideration and looking more at the final ratios than the absolute 
numbers it is apparent that the difference is statistically insignificant, 
except on ctar_load.

Previously I had benchmark results on 1000Hz which showed preempt improved the 
results in a few of the loads. For my next experiment I will compare 100Hz 
with preempt to 100Hz without.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3BRIF6dfvkL3i1gRAnEbAKCpaj/kajzKV3qVrWGRIhOh+Q8O8gCfZp6c
M3Iq1D/41t+4SB2jtNYQc48=
=NMfC
-----END PGP SIGNATURE-----

