Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUHTSzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUHTSzB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUHTSxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:53:15 -0400
Received: from main.gmane.org ([80.91.224.249]:9184 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268633AbUHTSvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:51:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Wes Felter" <wmf@austin.ibm.com>
Subject: Re: SMP cpu deep sleep
Date: Fri, 20 Aug 2004 11:44:44 -0500
Organization: IBM Austin Research Lab
Message-ID: <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
References: <1092989207.18275.14.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 10:06:47 +0200, Hans Kristian Rosbach wrote:

> While reading through hotplug and speedstep patches
> I came to think of a feature I think might be useful.
> 
> In an SMP system there are several cpus, this generates
> extra heat and power consuption even on idle load.
> Is there a way to put all cpus but cpu1 into a kind of
> deep sleep? Cpu1 would have to do all work (including irqs)
> of course.
> 
> We have a lot of SMP systems that we host, and they
> are heavily used ~10 hours of the day, the rest they are
> mostly idle. They could run on only 1 cpu during lenghty
> idle periods.
> 
> If it is possible to put cpus to a deeper sleep than
> just the simple idle, then the kernel could make use of this.

I worked on this last year (I call it CPU packing, because the idea is to
pack the load onto the fewest number of CPUs).

The CPU hotplug patch is the way to go, but the hardware is the problem. I
talked to an Intel CPU architect at MICRO last year and he confirmed that
SMP Intel systems don't support any low-power modes besides HLT. AMD's
documentation says that Opterons support voltage/frequency scaling (aka
Cool 'n' Quiet), but AFAICT the documentation is wrong. In summary, you
are doomed.

-- 
Wes Felter
Power-Aware Systems Department
IBM Austin Research Lab
11400 Burnet Road, Austin, TX 78758
Tel 512-838-7933


