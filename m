Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWGBBDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWGBBDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 21:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWGBBDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 21:03:49 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:46250 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932564AbWGBBDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 21:03:49 -0400
Date: Sat, 1 Jul 2006 20:57:13 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 0/2] sLeAZY FPU feature
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Message-ID: <200607012058_MC3-1-C3F3-F21@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1151782942.3195.56.camel@laptopd505.fenrus.org>

On Sat, 01 Jul 2006 21:42:22 +0200, Arjan van de Ven wrote:

> > What sort of test?
>
> the one I did was long running FPU app (calculating PI using FPU)

Mine was just running a program that loops doing getpid() in one window
and this in another:

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

#define rdtscll(t)      asm("rdtsc" : "=A" (t))

int main(int argc, char * const argv[])
{
        long long tsc1, tsc2;
        long double ld = 0.0;
        int i, iters = 999999999;

        rdtscll(tsc1);
        for (i = 0; i < iters; i++)
                ld += 1.0;
        rdtscll(tsc2);

        printf("count: %Lf, clocks: %llu\n", ld, tsc2 - tsc1);

        return 0;
}

So the ~0.4% gain I saw (averaging 10 tests) was likely the minimum
and Arjan's 8.5% gain when switching tasks after every FPU operation
is the max.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
