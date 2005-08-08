Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVHHHFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVHHHFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVHHHFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:05:20 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:49338 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750725AbVHHHFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:05:20 -0400
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: vatsa@in.ibm.com
Cc: Con Kolivas <kernel@kolivas.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050808024430.GA1539@in.ibm.com>
References: <200508031559.24704.kernel@kolivas.org>
	 <200508080951.26433.kernel@kolivas.org>
	 <C845464B-FE91-4845-BE7A-3995B663396D@mac.com>
	 <200508081130.23636.kernel@kolivas.org>  <20050808024430.GA1539@in.ibm.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123484712.3969.485.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 08 Aug 2005 17:05:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-08-08 at 12:44, Srivatsa Vaddagiri wrote:
> On Mon, Aug 08, 2005 at 11:30:23AM +1000, Con Kolivas wrote:
> > Tony said he had it lying around somewhere and needed to find time to dust it 
> > off and get it up to speed.
> 
> PPC64 is on my ToDo list as well. Will take it up after the dyn-tick is cleaned 
> up for SMP.

An SMP related area you might want to look at (if you haven't already)
is hotplug cpu support. There seems to be some interaction between
dynticks and hotplug that prevents a CPU from getting to set its state
to CPU_DEAD (despite being in the idle function), while the thread
seeking to down it sits in __cpu_die waiting. I observed the issue while
testing Suspend2 - about 1 in 5 resumes would lock solid or have a big
delay at resume time (never when suspending, interestingly). Turning off
dynticks allowed me to do 15 successful resumes on the trot.

Regards.

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

