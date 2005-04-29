Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVD2R2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVD2R2C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVD2R2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:28:01 -0400
Received: from postman4.arcor-online.net ([151.189.20.158]:50420 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S262846AbVD2R0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:26:35 -0400
Date: Fri, 29 Apr 2005 19:27:59 +0200
From: Juergen Quade <quade@hs-niederrhein.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system-freeze: kprobe and do_gettimeofday
Message-ID: <20050429172759.GA27647@hsnr.de>
References: <20050423101251.GA327@hsnr.de> <20050425155649.GA30272@in.ibm.com> <20050425160859.GA23019@hsnr.de> <20050426145210.GC32766@in.ibm.com> <20050426193440.GA16597@hsnr.de> <20050429111849.GA5185@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050429111849.GA5185@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ...
> Thanks for providing the information, we are not able to reproduce this
> problem here. Can you pls write a similar fault handler for kprobes as shown
> below and get us the log messages.
> 
> int fault_probe(struct kprobe *p, struct pt_regs *regs, int trapnr) {
>         printk("fault_handler:p->addr=0x%p, eflags=0x%lx\n", p->addr, regs->eflags);
>         return 0;

I tried it a few time, system freezes but the fault handler
has not been called. First time the system rebooted completly,
second time I got no output at all.

I added the proposed line into the pre-handler. Here is the
output:

	kprobe registered address c0107bd0
	pre_handler:p->addr=0xc0107bd0, eflags=0x282
	root@esz-mobil:/tmp/kprobes# double fault, gdt
	at c049bd00 ...

The first line is the output of "init_module". The second
line is the output of the pre_handler. As you can see,
before the "double fault" message I get one prompt. Could
there be a problem with the timer interrupt?

         Juergen.
