Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUJMEUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUJMEUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 00:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUJMEUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 00:20:33 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:51312 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S268327AbUJMEUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 00:20:30 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Hanson, Jonathan M'" <jonathan.m.hanson@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Getting a process' EIP address (and other registers)
Date: Tue, 12 Oct 2004 21:20:23 -0700
Organization: Cisco Systems
Message-ID: <015501c4b0db$f5e6b340$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C204FB456A@azsmsx406>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EIP is not on the user space stack. It's a system call, not a function
call, and the EIP is where the system call is made.

Upon entering kernel all registeres are saved on the kernel stack. You can
get it by the following:

struct pt_regs *regs = *(((struct pt_regs *)(THREAD_SIZE + (unsigned
long)current)) - 1);

> 	I have written a 2.4 kernel module that is triggered upon an
> IOCTL from a user application. Once triggered the kernel module dumps
> out the contents of the system memory and the x86 CPU 
> architecture state
> to separate files.
> 	I'm writing to the list because my method for getting registers
> from the user process before it entered the kernel is producing
> incorrect results. I've looked all through the kernel code 
> and searched
> all over the web for an answer to this specific question and found
> nothing relevant.
> 	In my research how to do this I've found that the stack pointer
> for the user process before it entered the kernel is stored in
> current->thread.esp0. From there the registers for the user 
> process are
> stored at offsets from that location (for example, EIP is 
> supposed to be
> 0x28 unsigned char bytes from esp0). I have code to get the EIP as
> follows:
> 
> unsigned char *stack_address, *eip;
> 
> stack_address = (unsigned char *)(current->thread.esp0);
> eip = stack_address + 0x28;
> printk("eip = %08lx\n", *(unsigned long *)eip);
> 
> Like I mentioned this is producing incorrect results. How do I access
> the user process' general purpose registers contents as they 
> were before
> the kernel was entered (or correct my code above if I'm accessing
> something wrong)?
> 	Thanks in advance for any help offered.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

