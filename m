Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269974AbUJNFGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269974AbUJNFGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 01:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269976AbUJNFGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 01:06:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3061 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269974AbUJNFGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 01:06:18 -0400
Date: Thu, 14 Oct 2004 10:39:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven Dietrich <sdietrich@mvista.com>, Daniel Walker <dwalker@mvista.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       abatyrshin@ru.mvista.com, amakarov@ru.mvista.com, emints@ru.mvista.com,
       ext-rt-dev@mvista.com, hzhang@ch.mvista.com, yyang@ch.mvista.com,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       arnd.heursch@unibw-muenchen.de
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041014050905.GA6927@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20041011215420.GA19796@elte.hu> <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com> <20041012055029.GB1479@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012055029.GB1479@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 07:50:29AM +0200, Ingo Molnar wrote:
> 
> regarding RCU serialization - i think that is the way to go - i dont
> think there is any sensible way to extend RCU to a fully preempted
> model, RCU is all about per-CPU-ness and per-CPU-ness is quite limited 
> in a fully preemptible model.

It seems that way to me too. Long ago I implemented preemptible
RCU, but did not follow it through because I believed it
was not a good idea. The original patch is here :

http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.1/0026.html

This allows read-side critical sections of RCU to be preempted.
It will take a bit of work to re-use it in RCU as of now, but
I don't think it makes sense to do so. My primary concern is
DoS/OOM situation due to preempted tasks holding up RCU.

> 
> could you send those RCU patches (no matter how incomplete/broken)? It's
> the main issue that causes the dcache_lock to be raw still. (and a
> number of dependent locks: fs-writeback.c, inode.c, etc.) We can make
> those RCU changes not impact the normal !PREEMPT_REALTIME locking so it
> might have a chance for upstream merging as well.

I would be interested in this too. 

Thanks
Dipankar
