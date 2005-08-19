Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVHSE0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVHSE0F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 00:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVHSE0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 00:26:05 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:4930 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932416AbVHSE0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 00:26:04 -0400
Message-ID: <43055F5A.2000406@bigpond.net.au>
Date: Fri, 19 Aug 2005 14:26:02 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Con Kolivas <kernel@kolivas.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4	for
 2.6.12 and 2.6.13-rc6
References: <43001E18.8020707@bigpond.net.au>	 <200508180916.08454.kernel@kolivas.org> <4303CCB9.6000403@bigpond.net.au>	 <200508180945.50185.kernel@kolivas.org>	 <6bffcb0e050818200936bad1d3@mail.gmail.com> <1124422128.25424.7.camel@mindpipe>
In-Reply-To: <1124422128.25424.7.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 19 Aug 2005 04:26:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-08-19 at 05:09 +0200, Michal Piotrowski wrote:
> 
>>Hi,
>>here are interbench v0.29 resoults:
> 
> 
> The X test under simulated "Compile" load looks most interesting.
> 
> Most of the schedulers do quite poorly on this test - only Zaphod with
> default max_ia_bonus and max_tpt_bonus manages to deliver under 100ms
> max latency.  As expected with interactivity bonus disabled it performs
> horribly.
> 
> I'd like to see some results with X reniced to -10.  Despite what the
> 2.6 release notes say, this still seems to make a difference.

Even spa_no_frills, which does absolutely nothing to help interactive 
(or other special interest) tasks, can cope in these circumstances as 
illustrated by these results from my (relatively old) SMP machine show:

--- Benchmarking simulated cpu of X nice -10 in the presence of 
simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	   0.01 +/- 0.129          2		 100	       99.3
Video	  0.007 +/- 0.0818         1		 100	       99.3
Burn	  0.006 +/- 0.0817         1		 100	       99.3
Write	  0.033 +/- 0.271          3		99.3	         98
Read	  0.046 +/- 0.337          3		98.4	         97
Compile	  0.023 +/- 0.208          2		99.3	       98.3
Memload	  0.043 +/- 0.31           3		98.1	         97

This machine isn't directly comparable with Michal's so for comparison 
here are the results from "out of the box" Zaphod on the same machine:

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	   0.02 +/- 0.2            2		99.3	       98.7
Video	  0.007 +/- 0.0818         1		 100	       99.3
Burn	  0.023 +/- 0.208          2		99.3	       98.3
Write	  0.147 +/- 0.949         12		94.7	       93.2
Read	  0.033 +/- 0.258          2		98.7	       97.7
Compile	   2.94 +/- 10.7         105		76.8	       71.6
Memload	  0.017 +/- 0.153          2		 100	       98.7

As you can see there's evidence in these numbers the file writes are 
implicated in the bad numbers for the Compile load (which is a mixture 
of Burn, Read, Write and (I think) Memload).  So testing with different 
I/O schedulers might be interesting.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
