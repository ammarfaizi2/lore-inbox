Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUEWA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUEWA3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUEWA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 20:29:50 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:39567 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S262006AbUEWA3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 20:29:48 -0400
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64
	specifically)?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: brettspamacct@fastclick.com
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40AE93E0.7060308@fastclick.com>
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it>
	 <1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it>
	 <1YmMN-4Kh-17@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it>
	 <m3lljld1v1.fsf@averell.firstfloor.org> <93090000.1085171530@flay>
	 <40AE93E0.7060308@fastclick.com>
Content-Type: text/plain
Message-Id: <1085272089.25212.6.camel@obsidian.pathscale.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 22 May 2004 17:28:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-21 at 16:42, Brett E. wrote:

> Right now, 5 processes are running taking up a good deal of the CPU 
> doing memory-intensive work(cacheing) and I notice that none of the 
> processes seem to have CPU affinity.

I don't know what kind of system you're running on, but if it's a
multi-CPU Opteron, it is normally a sufficient fudge to just use
sched_setaffinity to bind individual processes to specific CPUs.  The
mainline kernel memory allocator does the right thing in that case, and
allocates memory locally when it can.

You can use the taskset command to get at this from the command line, so
you may not even need to modify your code.

	<b

