Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756472AbWKSGPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472AbWKSGPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 01:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756473AbWKSGPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 01:15:23 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:14820 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1756471AbWKSGPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 01:15:22 -0500
Message-ID: <455FF672.4070502@lwfinger.net>
Date: Sun, 19 Nov 2006 00:15:14 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Ray Lee <ray-lk@madrabbit.org>
Subject: Problem with DMA on x86_64 with 3 GB RAM
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org>
In-Reply-To: <455F4271.1060405@madrabbit.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to debug a bcm43xx DMA problem on an x86_64 system with 3 GB RAM. Depending on the 
particular chip and its implementation, dma transfers may use 64-, 32-, or 30-bit addressing, with 
the problem interface using 30-bit addressing. From test prints, the correct mask (0x3FFFFFFF) is 
supplied to pci_set_dma_mask and pci_set_consistent_dma_mask. Neither call returns an error. In 
addition, several x86_64 systems with more than 1 GB RAM have worked with the current code.

If the system is booted with mem=1024M on the command line, it operates normally; however, it gets a 
kernel NULL pointer dereference and panics when booted with either 2 or 3 GB RAM.

The config parameters in the processor section are as follows:

CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

I would appreciate any tips on debugging this problem. Are there any quantities that should be 
dumped, etc?

Thanks,

Larry


