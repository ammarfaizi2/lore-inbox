Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUJMFDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUJMFDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUJMFDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:03:43 -0400
Received: from motgate8.mot.com ([129.188.136.8]:26323 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S268013AbUJMFDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:03:40 -0400
Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7023C44DA@sr-bng-exc01.ap.mot.com>
X-Sybari-Trust: 7858ed17 13bac7b5 819362d3 00000129
From: "Thekkedath, Gopakumar" <Gopakumar.Thekkedath@fci.com>
To: "'Dhiman, Gaurav'" <Gaurav.Dhiman@ca.com>, Jan Hudec <bulb@ucw.cz>,
       aq <aquynh@gmail.com>
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
Subject: RE: Kernel stack
Date: Wed, 13 Oct 2004 10:33:11 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>You discussed that kernel do not keep track of SS for process specific
>kernel stack as it always starts from fixed offset of task_struct, but
>does that mean, linux kernel do not make use of SS element in the TSS of
>process. I think the kernel can not by-pass the rules defined by
>processor. Processor expects the SS and SP elements to be right at the
>time of stack switching, so we need to initialize them to the right
>values while forking a process.

	Yes, the kernel cannot bypass the TSS entirely.

>I think kernel definitely keep tracks of SS and SP for all CPU levels
>including kernel mode also (ring 0), so that when we are switching form
>user space to kernel space the processor can switch the stacks
>automatically. At stack switching time CPU expects the SS and SP
>elements of TSS to be right, it's just going to copy those values in SS
>and SP registers of CPU, so that now we can push and pop the things on
>the kernel stack.
	In Linxu , the SS and DS normally holds the same value. Mostly I
have seen that,\
 when in kernel mode, DS=SS=0x18 and when in user mode DS=SS=0x28 
(this is what i remember !). 

As Linux does not believe in x86 processor recommended task switching (ie
storing/retrieving all the
necessary register values in a TSS) it uses the process's stack to hold the
required registers. 
But, it cannot get away from the fact that, when a switch happens to kernel
mode,
 the processor expects to find the SS and ESP values for that privilege
level in the current TSS
 (the one which i pointed to be the TS register if i am correct!).

In Linux, we have only one TSS per processor, and when a process is
scheduled most 
probably the kernel sets the  TSS's SS0 (SS corresponding to ring 0) as 0x18
and ESP0 
will be current process's task_struct + 8K (in 2.4). Again, I have not
really gone through
 that piece of code in the kernel, so this is my assumption. Correct me if I
am wrong.

