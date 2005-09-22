Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVIVTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVIVTxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVIVTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:53:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030282AbVIVTxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:53:14 -0400
Date: Thu, 22 Sep 2005 12:52:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.14-rc2-mm1
Message-Id: <20050922125219.7ea04930.akpm@osdl.org>
In-Reply-To: <64900000.1127415577@[10.10.2.4]>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	<64900000.1127415577@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> Build breaks with this config (x440/summit): 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
> 
> arch/i386/kernel/built-in.o(.init.text+0x389d): In function `set_nmi_ipi_callback':
> /usr/local/autobench/var/tmp/build/arch/i386/kernel/traps.c:727: undefined reference to `usb_early_handoff'
> arch/i386/kernel/built-in.o(.init.text+0x4ee0): In function `smp_read_mpc':
> /usr/local/autobench/var/tmp/build/include/asm-i386/mach-summit/mach_mpparse.h:35: undefined reference to `usb_early_handoff'
> 

grr.  David had a hack in there which caused my links to fail so I hacked
it out and broke yours.

> Plus it panics on boot on Power-4 LPAR
> 
> Memory: 30962716k/31457280k available (4308k kernel code, 494564k reserved, 1112k data, 253k bss, 420k init)
> Mount-cache hash table entries: 256
> softlockup thread 0 started up.
> Processor 1 found.
> softlockup thread 1 started up.
> Processor 2 found.
> softlockup thread 2 started up.
> Processor 3 found.
> Brought up 4 CPUs
> softlockup thread 3 started up.
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> IOMMU table initialized, virtual merging disabled
> PCI_DMA: iommu_table_setparms: /pci@3fffde0a000/pci@2,2 has missing tce entries !
> Kernel panic - not syncing: iommu_init_table: Can't allocate 1729382256943765922 bytes
> 
>  <7>RTAS: event: 3, Type: Internal Device Failure, Severity: 5
> ibm,os-term call failed -1

There are ppc64 IOMMU changes in Linus's tree...
