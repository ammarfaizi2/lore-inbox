Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWAGWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWAGWEp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWAGWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:04:45 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:65173 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030609AbWAGWEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:04:44 -0500
Date: Sat, 7 Jan 2006 17:01:31 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.15-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601071704_MC3-1-B57D-AAFF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

printk-levels-for-i386-oops-code.patch has two minor problems:

> @@ -178,14 +178,15 @@ void show_stack(struct task_struct *task
>         }
> 
>         stack = esp;
> +       printk(KERN_EMERG);
>         for(i = 0; i < kstack_depth_to_print; i++) {
>                 if (kstack_end(stack))
>                         break;
>                 if (i && ((i % 8) == 0))
> -                       printk("\n       ");
> +                       printk("\n       " KERN_EMERG);

Should be:
+                       printk("\n" KERN_EMERG "       ");

>                 printk("%08lx ", *stack++);
>         }
> -       printk("\nCall Trace:\n");
> +       printk("\n" KERN_EMERG "Call Trace:\n");
>         show_trace(task, esp);
>  }


And:

> @@ -236,17 +237,17 @@ void show_registers(struct pt_regs *regs
>         if (in_kernel) {
>                 u8 __user *eip;
> 
> -               printk("\nStack: ");
> +               printk("\n" KERN_EMERG "Stack: ");
>                 show_stack(NULL, (unsigned long*)esp);
> 
> -               printk("Code: ");
> +               printk(KERN_EMERG "Code: ");
> 
>                 eip = (u8 __user *)regs->eip - 43;
>                 for (i = 0; i < 64; i++, eip++) {
>                         unsigned char c;
> 
>                         if (eip < (u8 __user *)PAGE_OFFSET || __get_user(c, eip)) {
> -                               printk(" Bad EIP value.");
> +                               printk(KERN_EMERG " Bad EIP value.");

The above one-line change should not be made -- it's in the middle of a line.

>                                 break;
>                         }
>                         if (eip == (u8 __user *)regs->eip)
-- 
Chuck
Currently reading: _Sleepside: The Collected Fantasies Of Greg Bear_
