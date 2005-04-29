Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVD2LSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVD2LSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVD2LSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:18:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18336 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262304AbVD2LSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:18:51 -0400
Date: Fri, 29 Apr 2005 16:48:49 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Juergen Quade <quade@hsnr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system-freeze: kprobe and do_gettimeofday
Message-ID: <20050429111849.GA5185@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050423101251.GA327@hsnr.de> <20050425155649.GA30272@in.ibm.com> <20050425160859.GA23019@hsnr.de> <20050426145210.GC32766@in.ibm.com> <20050426193440.GA16597@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426193440.GA16597@hsnr.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen,

> 
> I did now a lot of additional tests. When running
> "insmod kgettime.ko" from the console (not from x-windows)
> I get:
> 
> kprobe registered address c0107bd0 // output from the module
> double fault, gdt at c049bd00 [255 bytes]
> double fault, tss at c03d4060
> eip = c0103c86, esp = db932000
> eax = ffffffff, ebx = db932134, ecx = 0000000d, edx = 00000000
> esi = db932080, edi = 0000000d
> 
> Alt+SysRq did not work...
> 
> Then I removed all my modules (except 2) I was able to load the module
> without problems. I added module by module and checked every time with
> "insmod kgettime.ko". When loading the "ohci1394" module it crashed
> again. But next time I loaded the "ohci"-module first - no crash.  (So I
> don't think it is the ohci-module). I was able to load all modules and
> it still worked.
> 
> Hmmm. What else to check?
> 
Thanks for providing the information, we are not able to reproduce this
problem here. Can you pls write a similar fault handler for kprobes as shown
below and get us the log messages.

int fault_probe(struct kprobe *p, struct pt_regs *regs, int trapnr) {
        printk("fault_handler:p->addr=0x%p, eflags=0x%lx\n", p->addr, regs->eflags);
        return 0;
}

Thanks
Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
