Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTDFTrG (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTDFTrG (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:47:06 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:47828 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263062AbTDFTq7 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 15:46:59 -0400
Date: Sun, 6 Apr 2003 20:57:14 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: torvalds@transmeta.com, Kevin Brosius <cobra@compuserve.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 bk undefined reference to ip_amanda_lock ?
Message-ID: <20030406195706.GA18213@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	torvalds@transmeta.com, Kevin Brosius <cobra@compuserve.com>,
	kernel <linux-kernel@vger.kernel.org>
References: <3E8ED6C6.316264C6@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8ED6C6.316264C6@compuserve.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 08:14:46AM -0500, Kevin Brosius wrote:
 > Anyone else seeing:
 > 
 >         ld -m elf_i386  -T arch/i386/vmlinux.lds.s
 > arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
 > --start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
 > arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
 > kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
 > security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
 > drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
 > net/built-in.o --end-group  -o .tmp_vmlinux1
 > net/built-in.o: In function `help':
 > net/built-in.o(.text+0x6a283): undefined reference to `ip_amanda_lock'
 > net/built-in.o(.text+0x6a2ac): undefined reference to `ip_amanda_lock'
 > net/built-in.o(.text+0x6a2c5): undefined reference to `ip_amanda_lock'
 > net/built-in.o(.text+0x6a2da): undefined reference to `ip_amanda_lock'
 > net/built-in.o(.text+0x6a2ec): undefined reference to `ip_amanda_lock'
 > net/built-in.o(.text+0x6a334): more undefined references to
 > `ip_amanda_lock' follow
 > make: *** [.tmp_vmlinux1] Error 1
 > 
 > in 2.5 bk current?  I've attached 'grep "=[y|m]" .config'


Looks like a cut-n-paste thinko.

		Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/ipv4/netfilter/Kconfig linux-2.5/net/ipv4/netfilter/Kconfig
--- bk-linus/net/ipv4/netfilter/Kconfig	2003-04-02 11:51:59.000000000 +0100
+++ linux-2.5/net/ipv4/netfilter/Kconfig	2003-04-06 15:34:02.000000000 +0100
@@ -415,8 +415,8 @@ config IP_NF_NAT_TFTP
 config IP_NF_NAT_AMANDA
 	tristate
 	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
-	default IP_NF_NAT if IP_NF_TFTP=y
-	default m if IP_NF_TFTP=m
+	default IP_NF_NAT if IP_NF_AMANDA=y
+	default m if IP_NF_AMANDA=m
 
 config IP_NF_MANGLE
 	tristate "Packet mangling"
