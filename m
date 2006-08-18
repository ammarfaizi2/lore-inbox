Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWHRM2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWHRM2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWHRM2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:28:15 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:64745 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932434AbWHRM2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b9uNdx1rUp32FlIY0MCS3faB47Uakfw914HtT7ikLUB9JOB6kMAuAJJAMM+/bIqXdc/oo/NMD8f64z9sm9otX0QLrGJrbBcSTtx7Pyh9BqVII6vBSyKusYpuYIuRznHEdNsK1Ms/i2rY/GCxq+gd+V4bj5J5cD7k9l5zvE2v0gI=
Message-ID: <6bffcb0e0608180528ocadc36ck8868ae1a33342bb9@mail.gmail.com>
Date: Fri, 18 Aug 2006 14:28:13 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608171458l45b717bexbfb8fb2ba68228db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
	 <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
	 <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
	 <b0943d9e0608170801v23592952scf12c2c0b4a7bf4@mail.gmail.com>
	 <b0943d9e0608171458l45b717bexbfb8fb2ba68228db@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 17/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 17/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > I'm not sure it's a good idea, it might have other implications in
> > slab.c. I better fix kmemleak (I think currently you could get a
> > deadlock only on SMP).
>
> I attach a patch for kmemleak-0.9 which seems to work for me. It has a
> new locking mechanism in that memory allocations are performed without
> memleak_lock held. Let me know if you still get errors (I haven't
> fully tested it yet).

Something doesn't work. It appears while udev start.

[<c0106cdc>] show_trace+0xd/0xf
[<c0106dae>] dump_stack+0x17/0x19
[<c016e9a0>] __kmalloc+0xf6/0x10a
[<c019a4bf>] load_elf_binary+0x5b/0xb46
[<c017d77a>] search_binary_handler+0xfc/0x2d4
[<c017daa5>] do_execve+0x153/0x1f0
[<c0104d5f>] sys_execve+0x29/0x7a
[<c0105f11>] sysenter_past_esp+0x5b/0x79
kmemleak: pointer 0xf5a39ae0:
trace:
c016e767: <kmemleak_cache_alloc>
c0127274: <dup_mm>
c0127427: <copy_mm>
c0128227: <copy_process>
c012893: <do_fork>
c0104d19: <sys_clone>

Kernel panic - not syncing: kmemleak: resizing pointer by alias 0xf5ad4a04

BUG: warning at
/usr/src/linux-work8/arch/i386/kernel/smp.c:547/smp_call_function()
[<c0106cdc>] show_trace+0xd/0xf
[<c0106dae>] dump_stack+0x17/0x19
[<c0116ac4>] smp_call_function+0x52/0xf9
[<c0116bad>] smp_send_stop+0x16/0x20
[<c0170c35>] panic+0x50/0xdf
[<c016e9a0>] __kmalloc+0xf6/0x10a
[<c019a4bf>] load_elf_binary+0x5b/0xb46
[<c017d77a>] search_binary_handler+0xfc/0x2d4
[<c017daa5>] do_execve+0x153/0x1f0
[<c0104d5f>] sys_execve+0x29/0x7a
[<c0105f11>] sysenter_past_esp+0x5b/0x79

http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.9/kml-config2

>
> Thanks.
>
> --
> Catalin
>
>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
