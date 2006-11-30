Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967363AbWK3Ofh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967363AbWK3Ofh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 09:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936433AbWK3Ofh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 09:35:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60569 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936432AbWK3Ofg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 09:35:36 -0500
Date: Thu, 30 Nov 2006 15:35:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130143522.GA28507@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu> <20061130031933.5d30ec09.akpm@osdl.org> <20061130114617.GA2324@elte.hu> <20061130124421.GB25439@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130124421.GB25439@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> In process context preemptible code, 
> Lets say we are currently running on processor i.
> 
> cpu_hotplug_lock() ; /* does mutex_lock(&percpu(hotplug_lock, i)) */
> 
> /* do some operation, which might sleep */
> /* migrates to cpu j */
> 
> cpu_hotplug_unlock(); /* does mutex_unlock(&percpu(hotplug_lock, i)
> 			 while running on cpu j */
> 
> This would cause cacheline ping pong, no?

that would be attached to a very cache-inefficient thing: migrating a 
task from one CPU to another. This is not the kind of ping-pong we are 
normally worried about. (nor does it happen all that often)

	Ingo
