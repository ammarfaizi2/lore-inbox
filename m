Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVHBLkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVHBLkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVHBLkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:40:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:53996 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261494AbVHBLkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:40:42 -0400
Date: Tue, 2 Aug 2005 15:40:22 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Stelian Pop <stelian@popies.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050802154022.A15794@jurassic.park.msu.ru>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net> <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org> <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org> <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050802103226.GA5501@roarinelk.homelinux.net>; from mano@roarinelk.homelinux.net on Tue, Aug 02, 2005 at 12:32:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 12:32:26PM +0200, Manuel Lauss wrote:
> Does not work on -rc4-mm1. The IO-ports pre-reserved message appears,
> though. The 2 io-regions are still located under the "CardBus #03"
> device. Re-Applying
> "revert-gregkh-pci-pci-assign-unassigned-resources.patch" makes it
> work again.

Does the patch in appended message fix that?

Ivan.

----- Forwarded message from Ivan Kokshaysky <ink@jurassic.park.msu.ru> -----

Date: Mon, 1 Aug 2005 11:22:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Tero Roponen <teanropo@cc.jyu.fi>, jonsmirl@gmail.com,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: 2.6.14-rc4: dma_timer_expiry [was 2.6.13-rc2 hangs at boot]
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050729023921.0950968f.akpm@osdl.org>; from akpm@osdl.org on Fri, Jul 29, 2005 at 02:39:21AM -0700
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on jurassic.park.msu.ru
X-Spam-Status: No, hits=-4.9 required=4.0 tests=BAYES_00 autolearn=ham 
	version=2.64
X-Spam-Level: 

On Fri, Jul 29, 2005 at 02:39:21AM -0700, Andrew Morton wrote:
> Tero Roponen <teanropo@cc.jyu.fi> wrote:
> > My original report is here: http://lkml.org/lkml/2005/7/6/174
> 
> I see.  Ivan, do we know what's going on here?

Sort of. The 4K cardbus windows are working fine for non-x86
architectures where all IO resources are usually well known
and added to the resource tree properly.
However, on x86 there are sometimes "hidden" system IO port
ranges that aren't reported by BIOS, so the large (4K) cardbus
windows overlap these ranges.

Actually I don't like reducing CARDBUS_IO_SIZE to 256 bytes, because
we lose an ability to handle cards with built-in p2p bridges (which
require 4K for IO), plus it won't fix Sony VAIO problem.

Tero and Mikael, can you try this one-liner instead?

Ivan.

--- 2.6.13-rc4/include/asm-i386/pci.h	Sun Jul 31 14:32:09 2005
+++ linux/include/asm-i386/pci.h	Mon Aug  1 08:29:18 2005
@@ -18,7 +18,7 @@ extern unsigned int pcibios_assign_all_b
 #define pcibios_scan_all_fns(a, b)	0
 
 extern unsigned long pci_mem_start;
-#define PCIBIOS_MIN_IO		0x1000
+#define PCIBIOS_MIN_IO		0x2000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
 #define PCIBIOS_MIN_CARDBUS_IO	0x4000

----- End forwarded message -----
