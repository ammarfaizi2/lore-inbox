Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbTGDCZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265671AbTGDCYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:24:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57532 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265653AbTGDCUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:20:39 -0400
Subject: Re: Overhead of highpte
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <574790000.1057186404@flay>
References: <574790000.1057186404@flay>
Content-Type: text/plain
Organization: 
Message-Id: <1057286058.11027.106.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jul 2003 19:34:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-02 at 15:53, Martin J. Bligh wrote:
> Some people were saying they couldn't see an overhead with highpte.
> Seems pretty obvious to me still. It should help *more* on the NUMA
> box, as PTEs become node-local.
> 
> The kmap_atomic is, of course, perfectly understandable. The increase
> in the rmap functions is a bit of a mystery to me.
> 
> M.
> 
> Kernbench: (make -j vmlinux, maximal tasks)
>                               Elapsed      System        User         CPU
>                2.5.73-mm3       45.38      114.91      565.81     1497.75
>        2.5.73-mm3-highpte       46.54      130.41      566.84     1498.00

OK, let's add to the mystery.  Here's my run, on virtually the same
hardware except, I don't do a bzImage.  bzImage is pretty useless
because I don't want to benchmark gzip, so I just do vmlinux.  My times
should be _faster_ than yours, right?

                   Elapsed:     User:   System:    CPU:
2.5.73-mjb2         77.008s  937.756s       90s   1334%
2.5.73-mjb2-highpte 76.756s  935.464s   93.116s   1339%

Yeah, system time goes up.  Something funky is going on.  We should have
the same machines, except that I have twice the RAM, right?  What kind
of fs are you doing your tests on?  I'm doing ramfs.

-- 
Dave Hansen
haveblue@us.ibm.com

