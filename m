Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWBVSvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWBVSvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWBVSvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:51:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45247 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422655AbWBVSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:51:07 -0500
Subject: Re: Problem with NETIF_F_HIGHDMA
From: Arjan van de Ven <arjan@infradead.org>
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43FCB1B3.8090101@acm.org>
References: <43FCB1B3.8090101@acm.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 19:51:01 +0100
Message-Id: <1140634261.2979.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 12:47 -0600, Corey Minyard wrote:
> I was looking at a problem with a new system we are trying to get up and
> running.  It has a 32-bit only PCI network device, but is a 64-bit
> (x86_64) system.  Looking at the code for NETIF_F_HIGHDMA (which, when
> not set on a PCI network device, means that it cannot do 64-bit
> accesses) in net/core/dev.c, it seems wrong to me.
> 
> It is dependent on HIGHMEM, but HIGHMEM has nothing to do with 32/64 bit
> accesses.  On 64-bit systems, HIGHMEM is not set, thus the network code
> will pass any address (including those >32bits) to the driver.  Plus,
> highmem on 32-bit systems may very well be 32-bit accessible, possibly
> resulting in unecessary copies.  AFAICT, the current code will only work
> with i386 and PAE and is sub-optim

you use the PCI mapping api right? if you do that then there's no
problem, after pci mapping the addresses will be in the lower address
range perfectly fine....




