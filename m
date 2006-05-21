Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWEUGGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWEUGGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 02:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWEUGGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 02:06:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:15560 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751487AbWEUGGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 02:06:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vovht3EdzchAWxg5ht+EDFAv6x9L1RGqpCkQ55Qsex1QhTCWpte1IF2aIs7zPUsYIk/5BEvZzcnFDhNcc7v31/EEY14CBO4IObl8wTBdXwnQIsvbB7nWtiV2JCa6qgQfnkTsH7rDemYvG85UpjRKF+2ouoX9J3wIOIFlBBMlipM=
Message-ID: <bf3792800605202306v4b65bcadk51be97e4762b9d0b@mail.gmail.com>
Date: Sun, 21 May 2006 14:06:38 +0800
From: "Liu haixiang" <liu.haixiang@gmail.com>
To: "Balbir Singh" <bsingharora@gmail.com>
Subject: Re: Oops in kthread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <661de9470605200625x73929dbeme8fc487265ba66b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>
	 <661de9470605200625x73929dbeme8fc487265ba66b7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

The FDMA is my coded module. And in my code, I didn't call kthread in
my code but only call kthread_run once to create one kernel thread
CallbackManager.

So I don't understand why there is Oops from kthread and called by my
CallbackManager.

Can anybody explain to me when kthread will be called by the kernel?
Then I can understand well why Oops happen.

best regards

Liu haixiang

2006/5/20, Balbir Singh <bsingharora@gmail.com>:
> On 5/20/06, Liu haixiang <liu.haixiang@gmail.com> wrote:
> > Hi All,
> >
> > Today I debug one kernel thread created by kthread_run. And after
> > several hours run, there is one Oops coming from kthread. Please see
> > below mesage:
> > ====================
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > pc = 00000000
> > *pde = 00000000
> > Oops: 0000 [#1]
> >
> > Pid : 261, Comm:      CallbackManager
> > PC is at 0x0
> > PC  : 00000000 SP  : 869bbf8c SR  : 40008100 TEA : c016db88    Tainted: P
> > R0  : 00000000 R1  : 00000000 R2  : 005770c5 R3  : 40008101
> > R4  : 8b000006 R5  : 00000003 R6  : 07b1ce60 R7  : 00000079
> > R8  : c01c0800 R9  : 07b1ce60 R10 : 00000003 R11 : 00000000
> > R12 : 0000004c R13 : 00000000 R14 : 00000079
> > MACH: 0000025c MACL: 000001c8 GBR : 00000000 PR  : c01b514a
> >
>
> Your kernel is Tainted. I do not see a list of loaded modules in the
> oops log. A quick grep through the kernel sources did not reveal any
> routine called "CallbackManager". From the trace CallbackManager
> (which is also the name of the thread) belongs to a module called
> fdma.
>
> Are you writing fdma or do you have the source code for it? If your
> planning to submit fdma to the linux kernel, I would recommend that
> you go through the coding standards for the kernel. I don't think
> CallbackManager is an acceptable naming convention.
>
> > Call trace:
> > [<8442d184>] kthread+0xe4/0x140
> > [<c01b4f80>] CallbackManager+0x0/0x2c0 [fdma]
> > [<8440f4c0>] complete+0x0/0xc0
> > [<8442d080>] kthread_should_stop+0x0/0x20
> > [<84403004>] kernel_thread_helper+0x4/0x20
> >
> > Then I do objdump the kernel/kthread.c. Please see attached dumped
> > contents. And find the offset 0xe4. The assembly line code is:
> > e4:     08 20           tst     r0,r0
> >
> > Does anybody can explain to me which C code in kthread create this
> > Oops?Is there any easy way to translate assembly code to C?
> >
>
> Try running objdump -d -l on the object file. It should dump the line
> numbers and the corresponding disassembled assembly code.
>
> > best regards
> >
> > Liu haixiang
> >
> >
> >
>
> Balbir
> Linux Technology Center,
> India Software Labs,
> Bangalore
>
