Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWETNZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWETNZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWETNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 09:25:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:41267 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964839AbWETNZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 09:25:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V0jydBaHqQBKW9ZRIjLSJ+0VkGcVv+R+y9MxCcvEejH49iw/04+S5LO0Eg47ZGCLJwPclO0+bJI3+JMcPfYQuri5AFWwKD0emrJapFS8wV3973T4IDNE7ZLDfJgLanr+2kjO9b5+krNsEGsR0KOVPoao9Os3Af/Zz/KrlKy/iCc=
Message-ID: <661de9470605200625x73929dbeme8fc487265ba66b7@mail.gmail.com>
Date: Sat, 20 May 2006 18:55:06 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Liu haixiang" <liu.haixiang@gmail.com>
Subject: Re: Oops in kthread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/06, Liu haixiang <liu.haixiang@gmail.com> wrote:
> Hi All,
>
> Today I debug one kernel thread created by kthread_run. And after
> several hours run, there is one Oops coming from kthread. Please see
> below mesage:
> ====================
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pc = 00000000
> *pde = 00000000
> Oops: 0000 [#1]
>
> Pid : 261, Comm:      CallbackManager
> PC is at 0x0
> PC  : 00000000 SP  : 869bbf8c SR  : 40008100 TEA : c016db88    Tainted: P
> R0  : 00000000 R1  : 00000000 R2  : 005770c5 R3  : 40008101
> R4  : 8b000006 R5  : 00000003 R6  : 07b1ce60 R7  : 00000079
> R8  : c01c0800 R9  : 07b1ce60 R10 : 00000003 R11 : 00000000
> R12 : 0000004c R13 : 00000000 R14 : 00000079
> MACH: 0000025c MACL: 000001c8 GBR : 00000000 PR  : c01b514a
>

Your kernel is Tainted. I do not see a list of loaded modules in the
oops log. A quick grep through the kernel sources did not reveal any
routine called "CallbackManager". From the trace CallbackManager
(which is also the name of the thread) belongs to a module called
fdma.

Are you writing fdma or do you have the source code for it? If your
planning to submit fdma to the linux kernel, I would recommend that
you go through the coding standards for the kernel. I don't think
CallbackManager is an acceptable naming convention.

> Call trace:
> [<8442d184>] kthread+0xe4/0x140
> [<c01b4f80>] CallbackManager+0x0/0x2c0 [fdma]
> [<8440f4c0>] complete+0x0/0xc0
> [<8442d080>] kthread_should_stop+0x0/0x20
> [<84403004>] kernel_thread_helper+0x4/0x20
>
> Then I do objdump the kernel/kthread.c. Please see attached dumped
> contents. And find the offset 0xe4. The assembly line code is:
> e4:     08 20           tst     r0,r0
>
> Does anybody can explain to me which C code in kthread create this
> Oops?Is there any easy way to translate assembly code to C?
>

Try running objdump -d -l on the object file. It should dump the line
numbers and the corresponding disassembled assembly code.

> best regards
>
> Liu haixiang
>
>
>

Balbir
Linux Technology Center,
India Software Labs,
Bangalore
