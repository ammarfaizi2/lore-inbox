Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbUK0D4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbUK0D4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUK0Dz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:55:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262486AbUKZTdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:04 -0500
Message-ID: <41A5F684.1070901@in.ibm.com>
Date: Thu, 25 Nov 2004 20:43:08 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Akinobu Mita <amgta@yacht.ocn.ne.jp>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
References: <419CACE2.7060408@in.ibm.com>	 <20041119153052.21b387ca.akpm@osdl.org>	 <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com>	 <200411201204.37750.amgta@yacht.ocn.ne.jp>  <41A20DB5.2050302@in.ibm.com>	 <1101170617.4987.268.camel@dyn318077bld.beaverton.ibm.com>	 <41A37E5C.8050305@in.ibm.com> <1101326878.26063.18.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1101326878.26063.18.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari,

Badari Pulavarty wrote:
> Hari,
> 
> 
> I have a success case and a failure case to report.
> 
> 1) Success first.. I was able save /proc/vmcore when my machine
> paniced (not thro sysrq) and gdb showed the stack correctly :)

Thanks for this news! Reassures us that we are on the right track on 
making kdump useful for real-life problems.

> 
> For some reason, gdb failed to show stack correctly, when I
> ran it on /proc/vmcore directly, when I am on kxec kernel :(

Does it throw up wrong entries or does it completely fail?

> 
> # gdb  ../l*9/vmlinux vmcore.3
> ...
.
.
.
>  <0>kexec: opening parachute	<<<<<<<<<<*** trying to kexec ?

Yes, this is the kexec call from the crash dump code.

> Unable to handle kernel paging request at virtual address c30a0000

This is the page reserved for storing the register values. Its really 
strange that it faults here. The page is reserved already during early 
boot.

>  printing eip:
> c1039956
> *pde = 00000000
> Oops: 0002 [#2]
> SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c1039956>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.10-rc2-mm2kexec)
> EIP is at __crash_machine_kexec+0x66/0x110      <<<<<<** panic in kexec 

The panic is in crash_dump_save_registers() while doing a memcpy. As I 
mentioned above, it faults on the page reserved to save the registers.

Is it possible I can get the testcase so I can attempt recreating the 
problem here. Please let me know.

Regards, Hari
