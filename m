Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbTH2Pmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbTH2Pmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:42:51 -0400
Received: from holomorphy.com ([66.224.33.161]:1737 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261330AbTH2Pmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:42:38 -0400
Date: Fri, 29 Aug 2003 08:43:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jlnance@unity.ncsu.edu
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Lockless file readingu
Message-ID: <20030829154339.GB1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jlnance@unity.ncsu.edu, root@mauve.demon.co.uk,
	linux-kernel@vger.kernel.org
References: <E19sUna-0003Zq-00@calista.inka.de> <200308282344.AAA26603@mauve.demon.co.uk> <20030829100011.GA663@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829100011.GA663@ncsu.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:00:11AM -0400, jlnance@unity.ncsu.edu wrote:
> Be careful.  I remember discussing in probability class the liklyhood that
> two people in a room with N people have the same birthday.  N does not have
> to be anywhere close to 365 for your probability of a collision to be greater
> than 50%.  I forget what the exact number is but its less than 30.  The
> image problem sounds similar, depending on exactly how you phrase it.

This is very simple to see. Consider the probability of not having a
collision instead of having a collision. Each choice eliminates a
choice, so the probability of not colliding while taking a sample after
taking N samples from a uniform distribution over K values is (K-N)/K.
You end up getting 1 - K!/((K-N)! * K**N).

Given one possible value for each day of the year, K == 365.

So you want 1 - 365!/((365 - N)! * 365**N) > 1/2.

The first few probabilities of collision (calculated afresh) are:

0  0.0
1  0.0
2  2.739726027397249e-3
3  8.204165884781345e-3
4  1.6355912466550326e-2
5  2.713557369979358e-2
6  4.0462483649111536e-2
7  5.6235703095975365e-2
8  7.433529235166902e-2
9  9.462383388916673e-2
10 0.11694817771107757
11 0.14114137832173312
12 0.16702478883806438
13 0.19441027523242949
14 0.223102512004973
15 0.25290131976368646
16 0.2836040052528499
17 0.31500766529656066
18 0.34691141787178936
19 0.37911852603153673
20 0.41143838358058005
21 0.4436883351652058
22 0.4756953076625501
23 0.5072972343239854
24 0.5383442579145288
25 0.5686997039694639
26 0.598240820135939
27 0.626859282263242
28 0.6544614723423994
29 0.680968537477777
30 0.7063162427192686
31 0.7304546337286438
32 0.7533475278503207
33 0.774971854175772
34 0.7953168646201543
35 0.8143832388747152
36 0.8321821063798795
37 0.8487340082163846
38 0.8640678210821209
39 0.878219664366722
40 0.891231809817949
41 0.9031516114817354
42 0.9140304715618692
43 0.9239228556561199
44 0.9328853685514263
45 0.940975899465775
46 0.9482528433672547
47 0.9547744028332994
48 0.9605979728794224
49 0.9657796093226765
50 0.9703735795779884

N = 23 should do fine for your purposes.


-- wli
