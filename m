Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272427AbRIKMTs>; Tue, 11 Sep 2001 08:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272431AbRIKMTi>; Tue, 11 Sep 2001 08:19:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61570 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272427AbRIKMTU>; Tue, 11 Sep 2001 08:19:20 -0400
Date: Tue, 11 Sep 2001 08:15:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Raghava Raju <vraghava_raju@yahoo.com>
cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Kernel stack....
In-Reply-To: <20010910214741.19309.qmail@web20008.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1010911080108.9663A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Raghava Raju wrote:

> 
> 
> Hi,
> 
>       1) I want to know what exactly is the structure
> of kernel stack. Is it some thing like bss,data,text?
> 
>       2) I want to access kernel stack(in kernel
> mode). So I am using  kernel stack pointer provided in
> thread_struct. So how to access different areas(.i.e 
> data,text)  in kernel stack.
> 
> 
>        Any pointers will be helpful.
> 
>    Please mail me as I did't subscribe.
>    vraghava_raju@yahoo.com
> 
>      Thank you.
>      Raj. 

I am assuming that you want to know how parameters loaded on the
stack are passed to called procedures, i.e., the offset. I assume
that you know that the kernel stack is just like a user stack and
you don't actually manipulate it directly.

Given:
	procedure(one, two, three);
where one, two, and three are values of any size up to the length
of a register..

The called procedure gets the values as:

	0x04(%esp) = one
	0x08(%esp) = two
	0x0c(%esp) = three

If, and only if, no registers are saved on the called procedure's
stack. If some register(s) have been saved, the parameters are
offset by the length of the register(s)...

proc:	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi			# 4 * 4 = 0ffset 16
	movl	0x14(%esp), %ebx	# One
	movl	0x18(%esp), %ecx	# Two
	movl	0x1c(%esp), %edx	# Three


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


