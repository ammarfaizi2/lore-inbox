Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJEWfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJEWfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUJEWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:35:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13247 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261239AbUJEWfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:35:24 -0400
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Simon Derr <Simon.Derr@bull.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]>
	 <200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]> <20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]> <20041003212452.1a15a49a.pj@sgi.com>
	 <843670000.1096902220@[10.10.2.4]>
	 <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097015619.4065.61.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 05 Oct 2004 15:33:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 02:26, Simon Derr wrote:
> I'd like to present you at this point what was the original decision for 
> having exclusive (called strict, at this point in history) and 
> non-exclusive cpusets.
> 
> The idea was to have a system, and run all jobs on it through a batch 
> scheduler. Some jobs cared about performance, some didn't.
> 
> The ones who cared about performance got an 'exclusive' cpuset, the ones 
> who didn't got a 'non exclusive' cpuset.

It sounds to me (and please correct me if I'm wrong) like 'non
exclusive' cpusets are more like a convenient way to group tasks than
any sort of performance or scheduling imperative.  It would seem what
we'd really want here is a task grouping functionality, more than a
'cpuset'.  A cpuset seems a bit heavy handed if all we want to do group
tasks for ease of administration.


> There are still processes running outside the job cpusets (i.e in the root 
> cpuset), sshd, the batch scheduler. These tasks use a low amount of CPU, 
> so it is okay if they happen to run inside even 'exclusive' cpusets. For 
> us, 'exclusive' only means that no other CPU-hungry job is going to share 
> our CPU.

If that's all 'exclusive' means then 'exclusive' is a poor choice of
terminology.  'Exclusive' sounds like it would exclude all tasks it is
possible to exclude from running there (ie: with the exception of
certain necessary kernel threads).

-Matt

