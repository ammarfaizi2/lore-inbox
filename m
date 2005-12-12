Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVLLVh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVLLVh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVLLVh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:37:58 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:32731 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932084AbVLLVh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:37:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Mon, 12 Dec 2005 22:39:19 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20051211041308.7bb19454.akpm@osdl.org> <200512122155.43632.rjw@sisk.pl> <20051212130957.146fbcc3.akpm@osdl.org>
In-Reply-To: <20051212130957.146fbcc3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512122239.20264.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 12 December 2005 22:09, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> >  > It's best to actually send a copy of line 620 - kernels vary a lot, and
> >  > many developers won't have that particualr -mm tree handy.
> >  > 
> >  > The way I normally do this is to do `gdb vmlinux' and then `l
> >  > *0xffffffff880ad9d0'.
> > 
> >  Does it work for modules too?
> 
> Ah.  There are certainly ways of doing this - see the kgdb documentation. 
> Or you can work out the module load address, gdb the module and do the
> appropriate arithmetic I guess.
> 
> Generally I just statically link anything which I want to play with.

Still, the oops is from a module.  I could link it statically for debugging,
but then the address would be different to the one in the oops.

Anyway, please tell me if my reasoning was correct: I thought I couldn't
figure it out based on the absolute address, but I could use the
displacements.  Namely, it followed from the oops that the problem
occured at the address {:ehci_hcd:ehci_irq+224}, which is at the
offset 224 wrt ehci_irq, so I did:

gdb drivers/usb/host/ehci-hcd.o

In gdb I did:

info line ehci_irq

and it told me the address the line started at, so I added 224 to it and
got the line 620.
