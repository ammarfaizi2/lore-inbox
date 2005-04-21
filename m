Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVDUL4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVDUL4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDUL4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:56:33 -0400
Received: from ns.suse.de ([195.135.220.2]:48788 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261325AbVDUL4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:56:14 -0400
Date: Thu, 21 Apr 2005 13:56:08 +0200
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
Subject: Re: x86-64 Uncorrected machine check panic on boot
Message-ID: <20050421115608.GU7715@wotan.suse.de>
References: <200504192212.44742.mita@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504192212.44742.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:12:43PM +0900, Akinobu Mita wrote:
> Hello,
> 
> I got the following Machine Check Exception on 4-way Opteron Server.
> I've tried 2.6.11.7 and 2.6.12-rc2.
> The kernel parameter "nomce" could help to boot it up.

Sounds like a bogus BIOS. It should disable these machine checks
for timeout on pci config access imho.

What 4way board did you use? Can you check if there is a BIOS
update?

-Andi

> 
> I wrote this panic messages by hand.
> This panic seems to happen around "arch/x86_64/pci/../../i386/pci/direct.c:28"
> 
> ==========================================================
> Calling initcall 0xffffffff........: netlink_proto_init...
> NET: Registered protocol family 16
> 
> Calling initcall 0xffffffff........: pcibus_class_init...
> Calling initcall 0xffffffff........: pci_driver_init
> Calling initcall 0xffffffff........: tty_class_init
> Calling initcall 0xffffffff........: mtrr_if_init
> Calling initcall 0xffffffff........: pci_direct_init
> 
> CPU3: Machine Check Exception: 7 Bank 3: b40000000000083b
> RIP 10: <ffffffff802cfefe> {pci_conf1_read+0xce/0x110}
> TSC 85ece4f ADDR fdfc000cfe
> 
> kernel panic - not syncing: Uncorrected machine check
> ==========================================================
> 
> 
> $ addr2line -e vmlinux ffffffff802cfee0
> arch/x86_64/pci/../../i386/pci/direct.c:28
> 
> $ addr2line -e vmlinux ffffffff802cfee2
> include/asm/io.h:81
> 
> $ addr2line -e vmlinux ffffffff802cfefe
> include/asm/io.h:84
> 
> 
