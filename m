Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUEVGN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUEVGN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 02:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUEVGN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 02:13:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58085 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264896AbUEVGNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 02:13:48 -0400
Date: Fri, 21 May 2004 23:13:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: brettspamacct@fastclick.com
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <1720000.1085206414@[10.10.2.4]>
In-Reply-To: <40AE93E0.7060308@fastclick.com>
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it><1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it><1YmMN-4Kh-17@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it> <m3lljld1v1.fsf@averell.firstfloor.org> <93090000.1085171530@flay> <40AE93E0.7060308@fastclick.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now, 5 processes are running taking up a good deal of the CPU doing memory-intensive work(cacheing) and I notice that none of the processes seem to have CPU affinity.  top shows they execute pseudo randomly on the CPU's.
> 
> 
> At this point I'd like to decrease the number of processes to 4 and test performance with and without setting CPU & memory allocation affinity.
> 
> I've read the archives and I'm not sure how to get numactl running, both .5 and .6 versions give me:
> 
># numactl --show
> No NUMA support available on this system.
> 
> despite using kernel 2.6.6.
> 
> running numactl under strace gives me:
> 
> 32144 sched_getaffinity(32144, 16,  { 0 }) = 8
> 32144 syscall_239(0, 0, 0, 0, 0, 0, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30) = -1 (errno 38)
> 32144 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 53), ...}) = 0
> 32144 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a9556c000
> 32144 write(1, "No NUMA support available on thi"..., 42) = 42
> 32144 munmap(0x2a9556c000, 4096)        = 0
> 32144 exit_group(1)                     = ?
> 
> 
> In case someone might have ran into this before.

Did you turn on CONFIG_NUMA?

M.

