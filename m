Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUFLDua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUFLDua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 23:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUFLDua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 23:50:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28070 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264625AbUFLDu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 23:50:28 -0400
Date: Fri, 11 Jun 2004 23:50:25 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: stian@nixia.no
cc: linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks my console race
In-Reply-To: <Pine.LNX.4.44.0406112252160.13607-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0406112308100.13607-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004, Rik van Riel wrote:

> Reproduced here, on my test system running a 2.6 kernel.
> I did get a kernel backtrace over serial console, though ;)

With a 2.4 kernel I get a similar stack trace (also 
on alt-sysrq-p) output:

Pid/TGid: 3815/3815, comm:      kernel-hang-bz1
EIP: 0060:[<c03ec1cc>] CPU: 0
EIP is at coprocessor_error [kernel] 0x0 (2.4.21-15.5.ELsmp)
 ESP: 0060:c0113d14 EFLAGS: 00000206    Not tainted
EAX: 00100000 EBX: bfffc888 ECX: bfffc888 EDX: d9818000
ESI: bfffc888 EDI: d9819fb0 EBP: bfffc830 DS: 0068 ES: 0068 FS: 0000
GS: 0033
CR0: 80050033 CR2: b7566720 CR3: 02553380 CR4: 000006f0
Call Trace:   [<c0113d14>] restore_i387_fxsave [kernel] 0x24 (0xd9819ee4)
[<c0113de8>] restore_i387 [kernel] 0x78 (0xd9819f04)
[<c010b40e>] restore_sigcontext [kernel] 0x10e (0xd9819f18)
[<c010b51d>] sys_sigreturn [kernel] 0xed (0xd9819f94)

Now I'm not sure if the process is actually stuck in kernel
space or if it's looping tightly through both kernel and
user space...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

