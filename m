Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUIQLFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUIQLFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUIQLFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:05:02 -0400
Received: from holomorphy.com ([207.189.100.168]:41899 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268672AbUIQLE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:04:56 -0400
Date: Fri, 17 Sep 2004 04:03:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040917110353.GM9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua> <20040916121747.GQ9106@holomorphy.com> <200409171157.24943.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171157.24943.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 15:17, William Lee Irwin III wrote:
>> How do microbenchmarks fare, e.g. lmbench?

On Fri, Sep 17, 2004 at 11:57:24AM +0300, Denis Vlasenko wrote:
> Not a lmbench, but:
[...]
> 2.4:
> # time ./openclose
> real    0m7.455s
> user    0m0.300s
> sys     0m7.150s
> 2.6:
> # time ./openclose
> real    0m8.170s
> user    0m0.370s
> sys     0m7.800s
> 2.6 is at HZ=100 here. /etc is on ramfs.
> configs are in attached tarball.

To address this in a meaningful way, we're going to have to get some
profiling data. The built-in kernel profiler should suffice, though you
may want to run the test for a longer, fixed period of time (I
recommend making the test run as long as 60s and recording the number
of operations completed). Also, please snapshot the profile state with
readprofile(1) immediately before and after the microbenchmark runs on
both kernels. This should only require booting into the kernels you've
already built with an additional commandline parameter, e.g. profile=2.

The number after the = sign is the shift used for the granularity of
accounting.  With a shift of 0, the profile buffer will contain one
atomic_t (4B on ia32, e.g. your box) for every byte of kernel text.
Adding 1 to the shift halves the space needed for the profile buffer,
albeit with a concomitant decrease in the accuracy of its accounting.
profile=2 should be equivalent to the space required for a second copy
of the kernel text.

Thanks.


-- wli
