Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJCOje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJCOje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 10:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUJCOje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 10:39:34 -0400
Received: from jade.aracnet.com ([216.99.193.136]:45465 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S265697AbUJCOjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 10:39:32 -0400
Date: Sun, 03 Oct 2004 07:36:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Peter Williams <pwil3058@bigpond.net.au>,
       Hubertus Franke <frankeh@watson.ibm.com>
cc: dipankar@in.ibm.com, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <821020000.1096814205@[10.10.2.4]>
In-Reply-To: <415F37F9.6060002@bigpond.net.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The O(1) scheduler today does not know about cpumem sets. It operates
>> on the level of affinity masks to adhere to the constraints specified 
>> based on cpu masks.
> 
> This is where I see the need for "CPU sets".  I.e. as a 
> replacement/modification to the CPU affinity mechanism basically adding 
> an extra level of abstraction to make it easier to use for implementing 
> the type of isolation that people seem to want.  I say this because, 
> strictly speaking and as you imply, the current affinity mechanism is 
> sufficient to provide that isolation BUT it would be a huge pain to 
> implement.

The way cpusets uses the current cpus_allowed mechanism is, to me, the most
worrying thing about it. Frankly, the cpus_allowed thing is kind of tacked
onto the existing scheduler, and not at all integrated into it, and doesn't
work well if you use it heavily (eg bind all the processes to a few CPUs,
and watch the rest of the system kill itself). 

Matt had proposed having a separate sched_domain tree for each cpuset, which
made a lot of sense, but seemed harder to do in practice because "exclusive"
in cpusets doesn't really mean exclusive at all. Even if we don't have 
separate sched_domain trees, cpusets could be the top level in the master 
tree, I think.

M.

