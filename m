Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265733AbTGDCej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbTGDCdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:33:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57799 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265751AbTGDCcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:32:16 -0400
Date: Thu, 03 Jul 2003 19:46:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Overhead of highpte
Message-ID: <68160000.1057286782@[10.10.2.4]>
In-Reply-To: <1057286058.11027.106.camel@nighthawk>
References: <574790000.1057186404@flay> <1057286058.11027.106.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2003-07-02 at 15:53, Martin J. Bligh wrote:
>> Some people were saying they couldn't see an overhead with highpte.
>> Seems pretty obvious to me still. It should help *more* on the NUMA
>> box, as PTEs become node-local.
>> 
>> The kmap_atomic is, of course, perfectly understandable. The increase
>> in the rmap functions is a bit of a mystery to me.
>> 
>> M.
>> 
>> Kernbench: (make -j vmlinux, maximal tasks)
>>                               Elapsed      System        User         CPU
>>                2.5.73-mm3       45.38      114.91      565.81     1497.75
>>        2.5.73-mm3-highpte       46.54      130.41      566.84     1498.00
> 
> OK, let's add to the mystery.  Here's my run, on virtually the same
> hardware except, I don't do a bzImage.  bzImage is pretty useless
> because I don't want to benchmark gzip, so I just do vmlinux.  My times
> should be _faster_ than yours, right?

I do vmlinux as well.
 
>                    Elapsed:     User:   System:    CPU:
> 2.5.73-mjb2         77.008s  937.756s       90s   1334%
> 2.5.73-mjb2-highpte 76.756s  935.464s   93.116s   1339%
> 
> Yeah, system time goes up.  Something funky is going on.  We should have
> the same machines, except that I have twice the RAM, right?  What kind
> of fs are you doing your tests on?  I'm doing ramfs.

ext2.

I suspect the problem is that your gcc is such a slow piece of shit,
you're totally userspace bound. Try 2.95 (just move the /usr/bin/gcc
symlink on debian).

M.

