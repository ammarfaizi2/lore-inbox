Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTJUVQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTJUVQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:16:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54424 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263370AbTJUVQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:16:20 -0400
Date: Tue, 21 Oct 2003 14:16:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: ricklind@us.ibm.com
Subject: Re: Nick's scheduler v16
Message-ID: <56890000.1066770968@flay>
In-Reply-To: <3F913704.5040707@cyberone.com.au>
References: <3F913704.5040707@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm starting to do some large SMP / NUMA testing. Fixed and changed quite
> a bit. It isn't too bad, although I'm only testing dbench, tbench, and
> volanomark at the moment.
> 
> These SMP and NUMA changes are not tied to my interactivity stuff, so its
> possible they could get included if they turn out well. If you find any
> problems with it (high end or interactivity), please let me know.

Interesting ... some things get getter, some worse:

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.6.0-test8       45.20      100.97      566.65     1476.25
         2.6.0-test8-nick       44.81       93.98      568.49     1477.50
        2.6.0-test8-nick2       44.78       94.69      568.81     1482.00

elapsed is a tiny bit faster, system is significantly less, but with
higher parallelism:


Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test8       45.86      119.41      569.66     1502.00
         2.6.0-test8-nick       47.00      112.75      590.40     1495.00
        2.6.0-test8-nick2       47.11      112.86      590.31     1491.50

elapsed is definitely worse now.
SDET is a happy bunny though:

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test8       100.0%         0.3%
         2.6.0-test8-nick       109.9%         0.2%

Much of the changes there might just be backing out Con's interactivity
changes ...

M.

