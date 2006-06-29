Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWF2Pk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWF2Pk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWF2Pk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:40:56 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:46669 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750809AbWF2Pkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:40:55 -0400
Message-ID: <44A3F476.5010400@interia.pl>
Date: Thu, 29 Jun 2006 17:40:38 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain> <44A3C17F.3060204@etpmod.phys.tue.nl> <44A3DFDB.7050202@interia.pl> <44A3EB45.1000507@etpmod.phys.tue.nl>
In-Reply-To: <44A3EB45.1000507@etpmod.phys.tue.nl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: 37d1cacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Rafa³,
> 
> Any code to show? Just in case... ;-)
> 
> Groeten,
> Bart
> 

I'm using this for L2 cache:
	preempt_disable();
	local_irq_save(flags);
	rdmsr(MSR_VIA_FCR, lo, hi);
	flush_cache_all();
	wrmsr(MSR_VIA_FCR, lo | 1 << 8, hi);
and this doesn't stop the processor, but when I'm adding
1 << 13 or 1 << 14 CPU stops. I have tried
	flush_cache_all();
	wrmsr(MSR_VIA_FCR, lo | 1 << 8, hi);
	flush_cache_all();
	wrmsr(MSR_VIA_FCR, lo | 1 << 8 | 1 << 13, hi);
and
	flush_cache_all();
	wrmsr(MSR_VIA_FCR, lo | 1 << 8 | 1 << 13, hi);
and more, but result was always the same.

I will be very gratefull if You tell me what I'm doing wrong.

Rafa³


----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

