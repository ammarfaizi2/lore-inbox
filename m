Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSBFNA0>; Wed, 6 Feb 2002 08:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290495AbSBFNAH>; Wed, 6 Feb 2002 08:00:07 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18706 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288960AbSBFM77>; Wed, 6 Feb 2002 07:59:59 -0500
Message-Id: <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: kernel: ldt allocation failed
Date: Wed, 6 Feb 2002 14:58:17 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com> <5.1.0.14.2.20011207092244.049f6720@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20011207092244.049f6720@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 December 2001 07:45, Anton Altaparmakov wrote:
> However, looking at 2.4.16/arch/i386/kernel/process.c::copy_segments()
> which generates this message it seems odd: It returns void, yet it can fail
> because it is doing a vmalloc().
>
> When the vmalloc() fails, the new_mm->context.segments is set to NULL and
> the function returns.
>
> That seems wrong, no? Shouldn't there be a panic() when the allocation
> fails at least? Or even better the function should perhaps return an error
> code?
>
> Considering there is only one caller (kernel/fork.c::copy_mm()) it would be
> easy to modify copy_mm() to handle a returned error code gracefully and
> goto fail_nomem, which would in turn result in kernel/fork.c::do_fork(),
> the only caller of copy_mm(), cleaning up properly and returning an error
> code.

I am ignorant on the subject, but why LDT is used in Linux at all?
LDT register can be set to 0, this can speed up task switch time and save 
some memory used for LDT.

I see a i386 specific syscall (kernel/ldt.c:sys_modify_ldt()) and 
        /*
         * default LDT is a single-entry callgate to lcall7 for iBCS
         * and a callgate to lcall27 for Solaris/x86 binaries
         */
        set_call_gate(&default_ldt[0],lcall7);
        set_call_gate(&default_ldt[4],lcall27);
in kernel/traps.c:trap_init().

Is it used elsewhere?
--
vda
