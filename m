Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVDCPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVDCPYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVDCPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:24:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34011 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261799AbVDCPYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:24:19 -0400
Date: Sun, 3 Apr 2005 17:24:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050403152413.GA26631@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com> <20050402145351.GA11601@elte.hu> <20050402215332.79ff56cc.pj@engr.sgi.com> <20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com> <20050403071227.666ac33d.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403071227.666ac33d.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> 
>  3) I was noticing that my test system was only showing a couple of 
>     distinct values for cpu_distance, even though it has 4 distinct 
>     distances for values of node_distance.  So I coded up a variant of 
>     cpu_distance that converts the problem to a node_distance problem, 
>     and got the following cost matrix:

>     The code (below) is twice as complicated, the runtime twice as long,
>     and it's less intuitive - sched_domains seems more appropriate as
>     the basis for migration costs than the node distances in SLIT tables.
>     Finally, I don't know if distinguishing between costs of 21.7 and
>     25.3 is worth much.

the main problem is that we can do nothing with this matrix: we only 
print it, but then the values get written into a 0/1 sched-domains 
hierarchy - so the information is lost.

if you create a sched-domains hierarchy (based on the SLIT tables, or in 
whatever other way) that matches the CPU hierarchy then you'll 
automatically get the proper distances detected.

	Ingo
