Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUA3EBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUA3EBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:01:46 -0500
Received: from dp.samba.org ([66.70.73.150]:60348 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266501AbUA3EBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:01:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: david.ronis@mcgill.ca
Cc: linux-kernel@vger.kernel.org, fischer@norbit.de
Subject: Re: Problem with module-init-tools-3.0-pre3 
In-reply-to: Your message of "Thu, 29 Jan 2004 11:02:01 CDT."
             <16409.11897.539398.14955@ronispc.chem.mcgill.ca> 
Date: Fri, 30 Jan 2004 14:29:59 +1100
Message-Id: <20040130040158.4785D2C002@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16409.11897.539398.14955@ronispc.chem.mcgill.ca> you write:
> Rusty Russell writes:
> I triggered the bug again, although this time in a different order;
> namely, I ran xsane as a regular user, removed the sg and aha152x
> modules, and then reran xsane while still root.  

Right.  Sounds like root v. non-root is a red herring.

BTW, you can just use "dmesg" in 2.6: ksymoops is not needed.

> CPU 1 IS NOW UP!
> Unable to handle kernel NULL pointer dereference at virtual address 00000708
> c0162800
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    1
> EIP:    0060:[<c0162800>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: e5880000   ebx: 00000708   ecx: 00000015   edx: e5881f28
> esi: f1452780   edi: 00000001   ebp: f1452780   esp: e5881ed8
> ds: 007b   es: 007b   ss: 0068
> Stack: 00000000 c1b64de0 e5880000 00000000 c01626ef f1452780 c01ebce9 01500000 
>        f1452780 00000006 c01626d0 00000000 e5880000 00000000 00000000 00000000 
>        c0162517 f7fe2c00 01500000 e5881f28 00000000 e5ed9080 e83a14d4 00000001 
>  [<c01626ef>] exact_lock+0xf/0x20
>  [<c01ebce9>] kobj_lookup+0x119/0x200
>  [<c01626d0>] exact_match+0x0/0x10
>  [<c0162517>] chrdev_open+0x1e7/0x290
>  [<c0157570>] dentry_open+0x160/0x230
>  [<c0157408>] filp_open+0x68/0x70
>  [<c015797b>] sys_open+0x5b/0x90
>  [<c01092ab>] syscall_call+0x7/0xb
> Code: 83 3b 02 8b 40 10 74 7f c1 e0 05 8d 04 18 ff 80 a0 00 00 00 
> 
> >>EIP; c0162800 <cdev_get+20/b0>   <=====
> Code;  c0162800 <cdev_get+20/b0>
> 00000000 <_EIP>:
> Code;  c0162800 <cdev_get+20/b0>   <=====
>    0:   83 3b 02                  cmpl   $0x2,(%ebx)   <=====
> Code;  c0162803 <cdev_get+23/b0>
>    3:   8b 40 10                  mov    0x10(%eax),%eax
> Code;  c0162806 <cdev_get+26/b0>
>    6:   74 7f                     je     87 <_EIP+0x87>
> Code;  c0162808 <cdev_get+28/b0>
>    8:   c1 e0 05                  shl    $0x5,%eax
> Code;  c016280b <cdev_get+2b/b0>
>    b:   8d 04 18                  lea    (%eax,%ebx,1),%eax
> Code;  c016280e <cdev_get+2e/b0>
>    e:   ff 80 a0 00 00 00         incl   0xa0(%eax)

Looks like aha152x or sd is not cleaning up properly, and when
reinserted, something screws up.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
