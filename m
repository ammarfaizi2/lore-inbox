Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTKMVFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTKMVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:05:06 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:12738 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262118AbTKMVFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:05:00 -0500
Date: Thu, 13 Nov 2003 13:30:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v18
Message-ID: <38770000.1068759009@flay>
In-Reply-To: <3FAFC8C6.8010709@cyberone.com.au>
References: <3FAFC8C6.8010709@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Average of 5 kernel compiles (make -j) on a 16-way 512KB cache NUMAQ gives
>          bk14  bk14-v18
> real    83.5s     81.7s
> user   987.6s    992.5s
> sys    158.0s    142.3s
> 
> Volanomark looks much better than mainline.
> 
> More testing welcome.

-noint is just backing out the interactivity patch (part of your patch)
Not sure that's helping you much really, but maybe it conflicts with
your other stuff.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.6.0-test9       45.28      100.19      568.01     1474.75
        2.6.0-test9-noint       48.20       99.05      567.26     1389.00
       2.6.0-test9-nick18       45.06       91.56      568.77     1467.50

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
              2.6.0-test9       46.17      122.20      571.58     1501.00
        2.6.0-test9-noint       46.43      117.96      577.60     1498.00
       2.6.0-test9-nick18       46.90      109.05      589.77     1488.75

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test9       45.84      120.14      570.93     1507.00
        2.6.0-test9-noint       47.42      123.52      582.91     1488.75
       2.6.0-test9-nick18       46.83      110.70      588.91     1494.00

It seems that you're decreasing system time significantly, but increasing
user time if you have lots of tasks ... context switch thrash, maybe?

Would be interesting if you know which of the many patches in there make
the performance difference ... the whole thing is a bit too big to pick
up and maintain easily ;-)

M.

