Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUFEWat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUFEWat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFEWat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:30:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:234 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262208AbUFEWam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:30:42 -0400
Subject: Re: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <200406051956.i55JuBrt012803@harpo.it.uu.se>
References: <200406051956.i55JuBrt012803@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1086474562.12783.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 05 Jun 2004 17:29:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 14:56, Mikael Pettersson wrote:
> The current 2.6.7-rc2 kernel hangs after starting INIT
> on my PowerMac 4400. I traced the problem to the
> ptep_set_access_flags() patch in 2.6.7-rc1-bk4, which
> replaces ptep_establish()'s set_pte();flush_tlb_page()
> sequence with a single pte_update() in two places in
> mm/memory.c.
> 
> The patch below disables this change on ppc32, and
> allows my 603ev-based PM4400 to finally boot 2.6.7-rc2.

Can you try just adding the flush_tlb_page() to
ptep_set_access_flags() and let me know if that helps ? I need
to figure out what's wrong with "manual" TLB loads, I suspect
it's the same problem the 8xx folks are hitting, but I don't
see why at this point.

Ben.


