Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUJME4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUJME4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 00:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUJME4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 00:56:14 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:58430 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267985AbUJME4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 00:56:09 -0400
Message-ID: <46561a7904101221564f0ef523@mail.gmail.com>
Date: Wed, 13 Oct 2004 10:26:04 +0530
From: suthambhara nagaraj <suthambhara@gmail.com>
Reply-To: suthambhara nagaraj <suthambhara@gmail.com>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Subject: Re: Getting a process' EIP address (and other registers)
Cc: main kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C204FB456A@azsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <C863B68032DED14E8EBA9F71EB8FE4C204FB456A@azsmsx406>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why don't you use the pt_regs structure to restore the EIP
value stored during SAVE_ALL. Add a line in sys_ioctl to access the SAVE_ALL
stored values (EIP).This would then be simple pointer arithmetic.

I hope I havae answered you.

Regards 
Suthambhara





On Tue, 12 Oct 2004 21:10:13 -0700, Hanson, Jonathan M
<jonathan.m.hanson@intel.com> wrote:
>        I have written a 2.4 kernel module that is triggered upon an
> IOCTL from a user application. Once triggered the kernel module dumps
> out the contents of the system memory and the x86 CPU architecture state
> to separate files.
>        I'm writing to the list because my method for getting registers
> from the user process before it entered the kernel is producing
> incorrect results. I've looked all through the kernel code and searched
> all over the web for an answer to this specific question and found
> nothing relevant.
>        In my research how to do this I've found that the stack pointer
> for the user process before it entered the kernel is stored in
> current->thread.esp0. From there the registers for the user process are
> stored at offsets from that location (for example, EIP is supposed to be
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
> the user process' general purpose registers contents as they were before
> the kernel was entered (or correct my code above if I'm accessing
> something wrong)?
>        Thanks in advance for any help offered.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
