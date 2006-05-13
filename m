Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWEMNHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWEMNHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWEMNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 09:07:32 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:44983 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932424AbWEMNHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 09:07:31 -0400
In-Reply-To: <20060513052750.41cfcb9d.akpm@osdl.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.491027000@sous-sol.org> <20060513052750.41cfcb9d.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6c98457a59001e5e833121fb65075d00@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 24/35] Add support for Xen event channels.
Date: Sat, 13 May 2006 14:02:58 +0100
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 May 2006, at 13:27, Andrew Morton wrote:

>
>> +	init_evtchn_cpu_bindings();
>> +
>> +	/* No VIRQ or IPI bindings. */
>> +	for (cpu = 0; cpu < NR_CPUS; cpu++) {
>
> Using NR_CPUS is a little...  old-fashioned.  I'd suggest a sweep 
> through
> all the Xen code, look for places where it should be using
> for_each_foo_cpu().

Actually that's a particularly good catch in this case, since we use 
per_cpu() inside the loop and that's only well defined for 
cpu_possible_map. Oops.

The elusive users of ring.h are our split device drivers. It hides a 
bunch of details about muxing requests and responses on the same ring, 
and notification thresholds. There are a few other places we have ring 
buffers but they are sufficiently simple that implementing in place is 
clearer.

  Thanks,
  Keir

