Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTJOXfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTJOXfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:35:00 -0400
Received: from dp.samba.org ([66.70.73.150]:51844 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262720AbTJOXe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:34:56 -0400
Date: Thu, 16 Oct 2003 05:15:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031015191500.GI610@krispykreme>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F86BD0E.4060607@longlandclan.hopto.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Hotplug RAM I could see would be possible, but hotplug CPUs?  I spose if 
> you've got a multiprocessor box, you could swap them one at a time, but 
> my thinking is that this would cause issues with the OS as it wouldn't 
> be expecting the CPU to suddenly disappear.  Problems would be even 
> worse if the old and new CPUs were of different types too.

Our ppc64 hardware supports hotswap cpu - not physically adding a cpu but
rather moving the pool of cpus into and out of partitions.

There are many uses for cpu hotplug. If you hit a threshold of
correctible errors on a cpu, we can remove the failing cpu and swap in a
spare if available. If we do this before we get a UE then all is good.
One day we can get even more intelligent and recover from certain UEs, I
was talking to Andi and the ia64 guys at OLS about this (eg UE in a cpu
array mapped to a userspace address, we can kill the task and continue
on).

You can also move cpus between partitions on the fly, moving cpus out of
idle partitions and into the busy ones.

Anton
