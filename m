Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVDAL0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVDAL0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVDAL0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:26:52 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:2188 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262715AbVDAL0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:26:44 -0500
Message-ID: <424D2FE6.3050905@tiscali.de>
Date: Fri, 01 Apr 2005 13:26:30 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeroen Vreeken <pe1rxq@amsat.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: YABM (Yet another benchmark)
References: <424CFF86.3020304@amsat.org>
In-Reply-To: <424CFF86.3020304@amsat.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeroen Vreeken schrieb:

> Hi,
>
> This benchmark was made in response to a recent post here on lkm were 
> Linus indicated he would welcom pretty much any benchmark.
> Since there are already several database benchmarks, 3d benchmarks I 
> opted for a more down to earth approach.
> As such I am pleased to announce the 'linux kernel hacker benchmark', 
> a benchmark designed to simulate the activities of the average linux 
> kernel hacker.
> With this benchmark it should be possible to measure the performance 
> off the kernel for its most important user group, the kernel hacker.
>
> This workload turns out to be relativly simple to simulate as can be 
> seen in the attached benchmark program 'lkh-bm.c'.
> It is compiled with 'gcc -Wall lkh-bm.c -o lkh-bm'.
>
> This test has been run on all 2.6 releases and several older kernels 
> dating some years back. Unfortunatly 1.1 and lower kernels aren't able 
> to complete the test.
> The compiler used was gcc 3.2.3, the cpu a Celeron @ 2.4GHz.
> I plan to run this test daily on all releases, bk, mm and ac snapshots 
> and maybe more trees on kernel.org asuming nobody objects to me doing 
> a recursive web-suck with wget.
>
> At the end of this post you will find the already done benchmarks.
> As Linus seems to dig pretty pictures a graph has been attached 
> (lkh-bm.gif) with the same results.
> Surprisingly the number seems to be constant during the last years. 
> This could either indicate that the kernel hasn't regressed for years 
> in this respect (which would mean somebody is doing a fine job indeed) 
> or it could mean that the average kernel hacker simply doesn't do much 
> usufull anyway....
>
> Regards,
> Jeroen
>
>
> Benchmark results:
> 1.1.0 0
> 1.1.20 0
> 1.1.40 0
> 1.1.60 0
> 1.2.0 603
> 2.0.0 604
> 2.0.10 605
> 2.0.20 600
> 2.0.30 601
> 2.2.0 602
> 2.2.10 603
> 2.2.20 604
> 2.4.0 605
> 2.4.10 600
> 2.4.20 601
> 2.6.0 602
> 2.6.1 603
> 2.6.2 604
> 2.6.3 605
> 2.6.4 600
> 2.6.5 601
> 2.6.6 602
> 2.6.7 603
> 2.6.8 604
> 2.6.9 605
> 2.6.10 600
> 2.6.11 601
>
>
> ------------------------------------------------------------------------
>
>------------------------------------------------------------------------
>
>#include <stdio.h>
>#include <time.h>
>
>#define MEASUREMENT_TIME	60
>#define LINUS_CONSTANT		6
>
>/*
> * my_integer_pi()
> *
> * This function calculates the value of PI, and returns
> * 3. It does so by adding "1" in a loop three times.
> */
>int my_integer_pi(void)
>{
>	int i, pi;
>	
>	/*
>	 * This is the main loop.
>	 */
>	pi = 0;
>	for (i = 0; i < 3; i++)
>		pi++;
>	
>	/* Ok, return it */
>	return pi;
>}
>
>int main(int argc, char **argv)
>{
>	time_t timer, start, prev;
>	int completed = 0;
>	int calc;
>
>	start = time(NULL);
>	timer = start;
>	prev = start;
>	while ( timer - start <= MEASUREMENT_TIME ) {
>		/* do some typical kernel hacker stuff... */
>		calc = my_integer_pi();
>		timer = time(NULL);
>		if ((timer - prev) == LINUS_CONSTANT ) {
>			completed++;
>			prev = timer;
>		}
>	}
>	printf("endless LKH loops per hour: %ld\n",
>	    completed * 3600 / MEASUREMENT_TIME + (time(NULL) % LINUS_CONSTANT));
>
>	return 0;
>}
>  
>
This is _not_ serious a benchmark! It's just a counter! A _real_ 
benchmark would test threads, memory management, the schedule, . . . I 
guess on a NetBSD or Windows machine with the same Hardware you would 
get the same result.

Matthias-Christian Ott
