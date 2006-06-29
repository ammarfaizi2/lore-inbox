Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWF2Pj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWF2Pj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWF2Pj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:39:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41120 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750807AbWF2Pj2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:39:28 -0400
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA
	from	Longhaul by rw semaphores
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: =?UTF-8?Q?Rafa=C5=82?= Bilski <rafalbilski@interia.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44A3EEDC.30006@etpmod.phys.tue.nl>
References: <44A2C9A7.6060703@interia.pl>
	 <1151581077.23785.9.camel@localhost.localdomain>
	 <44A3C17F.3060204@etpmod.phys.tue.nl> <44A3DFDB.7050202@interia.pl>
	 <44A3EEDC.30006@etpmod.phys.tue.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 29 Jun 2006 16:55:51 +0100
Message-Id: <1151596551.23785.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-29 am 17:16 +0200, ysgrifennodd Bart Hartgers:
> Rafał Bilski wrote:
> > CPU is VIA C3 in EBGA "Nehemiah" core 6.9.8.
> > I'm using flush_cache_all(). Is there anything more powerfull?
> > I'm using MSR_VIA_FCR.
> > I can disable L2 cache (or at least I think so) - this doesn't help.
> > I can't disable L1 cache - processor stops when I'm trying to set 
> > I-cache or D-cache disable bit.

If you can flush any cached writes to RAM before you do the changeover
and after you disabled interrupts then it ought to be sufficient to
invalidate the cache just before re-enabling everything.

The reason I make that claim is that you know nobody will be DMAing over
the pages of memory you use for the speed change itself. Might need a
little care with the stack that is all.


Alan

