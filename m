Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273175AbSISVN1>; Thu, 19 Sep 2002 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273177AbSISVN0>; Thu, 19 Sep 2002 17:13:26 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:42255 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S273175AbSISVNY> convert rfc822-to-8bit; Thu, 19 Sep 2002 17:13:24 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: TPC-C benchmark used standard RH kernel
Date: Thu, 19 Sep 2002 16:18:22 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106402D09E45@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TPC-C benchmark used standard RH kernel
Thread-Index: AcJgHOs3lV5H11YeQ6mZ3Elfa/QVDwAANKbA
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2002 21:18:23.0221 (UTC) FILETIME=[15E3F250:01C26022]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dave Hansen [mailto:haveblue@us.ibm.com]
> Sent: Thursday, September 19, 2002 4:41 PM
> To: Bond, Andrew
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: TPC-C benchmark used standard RH kernel
> 
> 
> Bond, Andrew wrote:
>  > This isn't as recent as I would like, but it will give you an idea.
>  > Top 75 from readprofile.  This run was not using bigpages though.
>  >
>  > 00000000 total                                      7872   0.0066
>  > c0105400 default_idle                               1367  21.3594
>  > c012ea20 find_vma_prev                               462   2.2212
>  > c0142840 create_bounce                               378   1.1250
>  > c0142540 bounce_end_io_read                          332   0.9881
>  > c0197740 __make_request                              256   0.1290
>  > c012af20 zap_page_range                              231   0.1739
>  > c012e9a0 find_vma                                    214   1.6719
>  > c012e780 avl_rebalance                               160   0.4762
>  > c0118d80 schedule                                    157   0.1609
>  > c010ba50 do_gettimeofday                             145   1.0069
>  > c0130c30 __find_lock_page                            144   0.4500
>  > c0119150 __wake_up                                   142   0.9861
>  > c01497c0 end_buffer_io_kiobuf_async                  140   0.6250
>  > c0113020 flush_tlb_mm                                128   1.0000
>  > c0168000 proc_pid_stat                               125   0.2003
> 
> Forgive my complete ignorane about TPC-C...  Why do you have so much 
> idle time?  Are you I/O bound? (with that many disks, I sure hope not 
> :) )  Or is it as simple as leaving profiling running for a 
> bit before 
> or after the benchmark was run?
> 

We were never able to run the system at 100%.  This run looks like it may have had more than normal.  We always had around 5% idle time that we were not able to get ride of by adding more user load, so we were definitely hitting a bottleneck somewhere.  Initial attempts at identifying that bottleneck yielded no results.  So we ended up living with it for the benchmark, intending to post-mortem a root cause.

> Earlier, I got a little over-excited because I thinking that the 
> machines under test were 8-ways, but it looks like the DL580 is a 
> 4xPIII-Xeon, and you have 8 of them.  I know you haven't 
> published it, 
> but do you do any testing on 8-ways?
> 
> For most of our work (Specweb, dbench, plain kernel compiles), the 
> kernel tends to blow up a lot worse at 8 CPUs than 4.  It really dies 
> on the 32-way NUMA-Qs, but that's a whole other story...
> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
> 

Don't have any data yet on 8-ways.  Our focus for the cluster was 4-ways because those are what HP uses for most Oracle RAC configurations.  We had done some testing last year that showed very bad scaling from 4 to 8 cpus (only around 10% gain), but that was in the days of 2.4.5.  The kernel has come a long way from then, but like you said there is more work to do in the 8-way arena.

Are the 8-way's you are talking about 8 full processors, or 4 with Hyperthreading?

Regards, 
Andy
