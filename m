Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423188AbWCUSeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423188AbWCUSeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbWCUSeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:34:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423174AbWCUSeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:34:04 -0500
Date: Tue, 21 Mar 2006 10:33:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sander <sander@humilis.net>
cc: Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
In-Reply-To: <20060321153708.GA11703@favonius>
Message-ID: <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
 <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca>
 <20060321153708.GA11703@favonius>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Sander wrote:
> 
> The system just freezes. Rock solid. No sysrq, no ctrl-alt-del, nothing.

Can you enable the NMI watchdog? It could be a PCI bus lockup (in which 
case nothing will help), but if it's some interrupts-off busy loop 
(whether due to a spinlock deadlock or due to the driver just spinning) 
then nmi-watchdog should help.

Of course, that requires that you have support for local/io-APIC (ie if 
UP, please select CONFIG_X86_UP_.*APIC)

		Linus
