Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269774AbUJMSQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269774AbUJMSQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269775AbUJMSQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:16:00 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:17263 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S269774AbUJMSP4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:15:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Getting a process' EIP address (and other registers)
Date: Wed, 13 Oct 2004 11:15:54 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C204FB4BA7@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Getting a process' EIP address (and other registers)
Thread-Index: AcSw2/qD3C2vn8x7RqSqxFsW/Tfg4QAc9VBw
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <hzhong@cisco.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2004 18:15:53.0829 (UTC) FILETIME=[AD6C9150:01C4B150]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Hua Zhong [mailto:hzhong@cisco.com] 
Sent: Tuesday, October 12, 2004 9:20 PM
To: Hanson, Jonathan M; linux-kernel@vger.kernel.org
Subject: RE: Getting a process' EIP address (and other registers)

The EIP is not on the user space stack. It's a system call, not a
function
call, and the EIP is where the system call is made.

Upon entering kernel all registeres are saved on the kernel stack. You
can
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

	Thanks for the help. I think it's working now. I did have to
drop the pointer dereference at the front of the statement to get it to
compile, but my register values are now more consistent and believable.

