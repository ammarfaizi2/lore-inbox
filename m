Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTFKWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTFKWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:40:25 -0400
Received: from aneto.able.es ([212.97.163.22]:60651 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264544AbTFKWkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:40:20 -0400
Date: Thu, 12 Jun 2003 00:54:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Artemio <artemio@artemio.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
Message-ID: <20030611225401.GE2712@werewolf.able.es>
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com> <200306112313.30903.artemio@artemio.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200306112313.30903.artemio@artemio.net>; from artemio@artemio.net on Wed, Jun 11, 2003 at 22:13:30 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.11, Artemio wrote:
> Hello!
> 
> > > How much performance will I loose this way? Is SMP *THAT* critical?
> >
> > 	You will lose about half your CPU power.
> 
> Hmmm... So, you mean uni-processor Linux kernel can't see two processors as 
> one "big" processor? 
> 

No, but it will work as if it does...explain below.

You have 2 processor packages, each one is HyperThreading capable. This
means you have two 'CPUs' inside each package, so that sums up your 4 CPUs.
But there is a flaw. The 2 'CPUs' inside each processor package are not
full real CPUs, just two register sets that share cache, FP units, integer
units and so on. So let's say your Xeon has 8 FP units, and you want to
run a FPU intensive task with low or null disk IO. If you activate
hyperthreading each of the 2 'cpus' has 4 FP units, so half the computation
power. If you deactivate HT, you have 1 CPU with 8 FP units.

In short, for FP intensive tasks, hyperthreading is a big lie...
You can't run 2 computations in parallel.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
