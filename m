Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030715AbWKUEj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbWKUEj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934305AbWKUEj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:39:58 -0500
Received: from tapsys.com ([72.36.178.242]:18628 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S934304AbWKUEj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:39:57 -0500
Message-ID: <456282DE.1000407@madrabbit.org>
Date: Mon, 20 Nov 2006 20:38:54 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org> <455FF672.4070502@lwfinger.net>
In-Reply-To: <455FF672.4070502@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

Haven't seen any follow ups to this, so I'm going to ask stupid questions.  (I
only have 1G of RAM on my x86_64, so I'm no help.)

First off, have you pinged David Miller (davem at davemloft.net)? He seems to
have the DMA API tattooed on a body part, I think.

Larry Finger wrote:
> I am trying to debug a bcm43xx DMA problem on an x86_64 system with 3 GB
> RAM. Depending on the particular chip and its implementation, dma
> transfers may use 64-, 32-, or 30-bit addressing, with the problem
> interface using 30-bit addressing. From test prints, the correct mask
> (0x3FFFFFFF) is supplied to pci_set_dma_mask and
> pci_set_consistent_dma_mask. Neither call returns an error. In addition,
> several x86_64 systems with more than 1 GB RAM have worked with the
> current code.
> 
> If the system is booted with mem=1024M on the command line, it operates
> normally; however, it gets a kernel NULL pointer dereference and panics
> when booted with either 2 or 3 GB RAM.

Confused. As in, once the bcm43xx module initcall happens? Or without bcm43xx
at all? If the former, is the behavior different when built as a module versus
built-in? (ie, are there ordering problems.)

> The config parameters in the processor section are as follows:
> 
> CONFIG_X86_64=y
> CONFIG_64BIT=y
> CONFIG_X86=y
> CONFIG_ZONE_DMA32=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_MMU=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_DMI=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> 
> I would appreciate any tips on debugging this problem. Are there any
> quantities that should be dumped, etc?
