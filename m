Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUIXFAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUIXFAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUIXFAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:00:48 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:2200 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267798AbUIXFAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:00:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16723.43493.796084.90914@wombat.chubb.wattle.id.au>
Date: Fri, 24 Sep 2004 15:00:21 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fs-devel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
In-Reply-To: <372479081@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Steven Pratt <slpratt@austin.ibm.com> wrote:
>>  The readahead code has undergone many changes in the 2.6 kernel
>> and the current implementation is in my opinion obtuse and hard to
>> maintain.

Andrew> It did get a bit ugly - it was intially designed to handle
Andrew> pagefault readaround and perhaps could be further simplified
Andrew> as we're now doing that independently.

If you're coding up new readahead schemes, it may be worth taking into
account Papathanasiou and Scott, `Energy Efficient Prefetching and
Caching'
( http://www.usenix.org/events/usenix04/tech/general/papathanasiou/papathanasiou_html/index.html
)

which describes tuning of readahead for optimum disk energy usage,
while not compromising performance.

Here's the abstract:

       Traditional disk management strategies--prefetching and caching
       in particular--are designed to maximize performance. In mobile
       systems they conflict with strategies that attempt to save
       energy by powering down the disk when it is idle. We present
       new rules for prefetching and caching that maximize power-down
       opportunities (without performance loss) by creating an access
       pattern characterized by intense bursts of activity separated
       by long idle times. We also describe an automatic system that
       monitors past application behavior in order to generate
       appropriate prefetching hints, and a general system of kernel
       enhancements that coordinate I/O activity across all running
       applications.

       We have implemented our system in the Linux kernel, and have
       measured its performance and energy consumption via physical
       instrumentation of a running laptop. We describe our
       implementation and present quantitative results. For workloads
       including a mix of sequential access to large files
       (multimedia), concurrent access to large numbers of files
       (compilation), and random access to large files (speech
       recognition), we report disk energy savings of 60-80%, with
       negligible loss in throughput or interactive responsiveness.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
