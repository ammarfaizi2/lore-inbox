Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbWJKT7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWJKT7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWJKT7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:59:34 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60387 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161192AbWJKT7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:59:33 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=TiXxYa62bLWuvzXBm3jqeeHG1NGLSxEAt6uJ4gPcMgqgffzX708Bd2fkgo55iTjL5
	shWtKoy3ZjShVMWaYjy1g==
Message-ID: <452D4D17.1090705@google.com>
Date: Wed, 11 Oct 2006 12:59:19 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>
>
> -
>   

Oh, and hangs in LTP.

x86_64 just hangs.
http://test.kernel.org/abat/54544/debug/test.log.1 (in something io-ish)


http://test.kernel.org/abat/54541/debug/test.log.1 (ppc64)
craps itself with

Modules linked in:
NIP: C0000000000CC520 LR: C0000000000CC4EC CTR: 0000000000000FF5
REGS: c00000069ae83940 TRAP: 0700   Not tainted  (2.6.19-rc1-mm1-autokern1)
MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 28002424  XER: 20000000
TASK = c000000768026660[32160] 'openfile' THREAD: c00000069ae80000 CPU: 2
GPR00: 0000000000000001 C00000069AE83BC0 C00000000065E548 FFFFFFFFFFFFFFF4 
GPR04: 00000000000000D0 0000000000000040 C0000006DF1D200A 0000000000000008 
GPR08: 0000000000000001 0000000000000000 C00000003FFA3000 0000000000000000 
GPR12: 000000000000F032 C00000000053E480 0000000000000000 0000000000000000 
GPR16: 00000000100D5D40 00000000100CCFF8 00000000FF8352E0 00000000F800F7E0 
GPR20: 00000000FF8352D0 0000000010000D38 0000000000000001 0000000000000003 
GPR24: 00000000F67C9F80 FFFFFFFFFFFFFF9C C0000007750C4680 C0000007750C4690 
GPR28: 0000000000000040 C000000775AF9CC0 C000000000570348 C000000775AF9CC0 
NIP [C0000000000CC520] .expand_files+0x1f4/0x354
LR [C0000000000CC4EC] .expand_files+0x1c0/0x354
Call Trace:
[C00000069AE83BC0] [C0000000000CC470] .expand_files+0x144/0x354 (unreliable)
[C00000069AE83C60] [C0000000000AE148] .get_unused_fd+0x80/0x170
[C00000069AE83D00] [C0000000000AE6EC] .do_sys_open+0x5c/0x140
[C00000069AE83DB0] [C0000000000ED574] .compat_sys_open+0x24/0x38
[C00000069AE83E30] [C00000000000871C] syscall_exit+0x0/0x40


and another one from another ppc64 box

gekko-lp1 login:-- 0:conmux-control -- time-stamp -- Oct/10/06  9:38:14 --
 cpu 0x3: Vector: 700 (Program Check) at [c0000000e9a43960]
    pc: c0000000000f1454: .expand_files+0x1f4/0x354
    lr: c0000000000f1420: .expand_files+0x1c0/0x354
    sp: c0000000e9a43be0
   msr: 8000000000029032
  current = 0xc0000000e8b4a810
  paca    = 0xc000000000482b80
    pid   = 26003, comm = creat05
kernel BUG in copy_fdtable at fs/file.c:138!
enter ? for help
[c0000000e9a43c80] c0000000000d0af8 .get_unused_fd+0x80/0x170
[c0000000e9a43d20] c0000000000d1094 .do_sys_open+0x54/0x12c
[c0000000e9a43dc0] c0000000000161b8 .compat_sys_creat+0x14/0x28
[c0000000e9a43e30] c00000000000871c syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000ff6e3b0
SP (ff9cf310) is in userspace
3:mon>-- 0:conmux-control -- time-stamp -- Oct/10/06  9:40:19 --
-- 0:conmux-control -- time-stamp -- Oct/10/06  9:48:51 --


