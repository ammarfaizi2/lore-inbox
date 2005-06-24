Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbVFXGH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbVFXGH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 02:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVFXGEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 02:04:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52359 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263106AbVFXGEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 02:04:11 -0400
Date: Thu, 23 Jun 2005 23:03:45 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
In-Reply-To: <20050623.211140.131918815.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506232256360.17993@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0506232047450.29103@graphe.net>
 <20050623.205447.66178303.davem@davemloft.net> <Pine.LNX.4.62.0506232057340.29222@graphe.net>
 <20050623.211140.131918815.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, David S. Miller wrote:

> > outweigh the complexity added by these patches. What would be 
> > the performance benefit that we would need to see to feel that is 
> > is right to get such a change in?
> 
> Something on the order of %10.  If I recall correctly, that's
> basically what we got on SMP from the RCU changes to the routing
> cache.

Ok. Then we are done. With 58 Itanium processors and 200G Ram I get 
more than 10% improvement ;-). With 500 tasks we have 453 vs. 499 j/m/t.
That is 9.21%. For 300 tasks we have 9.4% etc. I am sure that I can push 
this some more with bigger counts of processors and also some other NUMA 
related performance issues.

58p SGI Altix 200G Ram running 2.6.12-mm1.

with patch:

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1     2439.02  100      2439.0244      2.46      0.02   Fri Jun 24 00:28:01 2005
  100   138664.20   92      1386.6420      4.33    106.04   Fri Jun 24 00:28:19 2005
  200   191113.23   87       955.5662      6.28    218.09   Fri Jun 24 00:28:45 2005
  300   219968.23   85       733.2274      8.18    329.09   Fri Jun 24 00:29:19 2005
  400   237037.04   85       592.5926     10.12    442.07   Fri Jun 24 00:30:01 2005
  500   249418.02   82       498.8360     12.03    551.93   Fri Jun 24 00:30:51 2005
  600   257879.66   80       429.7994     13.96    663.44   Fri Jun 24 00:31:49 2005
  700   264550.26   84       377.9289     15.88    774.88   Fri Jun 24 00:32:54 2005
  800   269587.19   81       336.9840     17.80    886.85   Fri Jun 24 00:34:07 2005
  900   273736.50   83       304.1517     19.73    997.90   Fri Jun 24 00:35:28 2005
 1000   277225.89   82       277.2259     21.64   1109.18   Fri Jun 24 00:36:57 2005

without patch

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1     2439.02  100      2439.0244      2.46      0.02   Fri Jun 24 00:46:03 2005
  100   131955.14   92      1319.5514      4.55    114.52   Fri Jun 24 00:46:22 2005
  200   177409.82   88       887.0491      6.76    246.62   Fri Jun 24 00:46:50 2005
  300   201027.47   85       670.0916      8.95    373.49   Fri Jun 24 00:47:27 2005
  400   216313.65   87       540.7841     11.09    497.36   Fri Jun 24 00:48:13 2005
  500   226637.46   83       453.2749     13.24    620.68   Fri Jun 24 00:49:07 2005
  600   233781.41   85       389.6357     15.40    746.18   Fri Jun 24 00:50:10 2005
  700   239561.94   84       342.2313     17.53    869.34   Fri Jun 24 00:51:22 2005
  800   243630.09   85       304.5376     19.70    996.39   Fri Jun 24 00:52:43 2005
  900   246992.64   85       274.4363     21.86   1121.90   Fri Jun 24 00:54:13 2005
 1000   249979.17   84       249.9792     24.00   1245.55   Fri Jun 24 00:55:52 2005


