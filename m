Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUB0IIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 03:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUB0IIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 03:08:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45453 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261197AbUB0IIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 03:08:43 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Carlos Silva" <r3pek@r3pek.homelinux.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: kexec "problem" [and patch updates]
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
	<20040226165446.16a5bb3b.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Feb 2004 01:00:04 -0700
In-Reply-To: <20040226165446.16a5bb3b.rddunlap@osdl.org>
Message-ID: <m1znb5c5q3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On Tue, 24 Feb 2004 11:02:21 -0000 (WET) Carlos Silva wrote:
> 
> | hi guys,
> | 
> | i have just compiled a kernel with the kexec patch. compiled kexec-tools
> | and when i try to load a kernel, it gives me this:
> | # ./do-kexec.sh /boot/bzImage-2.6.2-g
> | kexec_load failed: Invalid argument
> | entry       = 0x91764
> | nr_segments = 2
> | segment[0].buf   = 0x80b3480
> | segment[0].bufsz = 1880
> | segment[0].mem   = 0x90000
> | segment[0].memsz = 1880
> | segment[1].buf   = 0x40001008
> | segment[1].bufsz = 19795a
> | segment[1].mem   = 0x100000
> | segment[1].memsz = 19795a
> | 
> | anyone tried to run kexec and actually did it? i'm trying with kernel 2.6.3
> | -
> 
> I updated the kexec patch for 2.6.2 and 2.6.3.
> It works fine on 2.6.2.  It works for me on 2.6.3 if not SMP.
> If the kernel is built for SMP, when running kexec, I get a
> BUG in arch/i386/kernel/smp.c at line 359.
> I'm testing various workarounds for that BUG now.

I will eyeball it...

Is it the kernel that is shutting down, or the kernel that is being
brought up that has problems?

The back trace from the BUG would be interesting.

As I see it flush_tlb_others is being called when we have shutdown
cpus and the kernel still thinks we have the mm present on foreign
cpus.

So it appears we simply have a case that was not anticipated
by the authors of that code.  So we need to adjust either
the code we are calling or cpu_vm_mask so it does not list
other cpus after we have shut them down.

At least that it what it looks like at first glance.

Eric
