Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTEFOLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTEFOLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:11:06 -0400
Received: from ns.suse.de ([213.95.15.193]:16903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263781AbTEFOKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:10:21 -0400
Date: Tue, 6 May 2003 16:22:52 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix x86_64 pte_user() and floppy.h for 2.5.69
Message-ID: <20030506142252.GB28449@Wotan.suse.de>
References: <16055.49364.106094.795419@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16055.49364.106094.795419@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 04:04:04PM +0200, mikpe@csd.uu.se wrote:
> Andi,
> 
> 2.5.69 failed to link on x86_64 due to a missing reference to pte_user().
> I simply stole the one that i386 added in .68 -> .69.
> There's also irqreturn_t warnings on floppy.h -- fixed also by syncing
> with i386' floppy.h.

At least the floppy.h thing is already fixed.

The pte_user fix is not needed. The correct fix is to change the 
#ifdef mm/memory.c checks for. It's broken for most/all
architecture which are not i386 including x86-64. 
They have FIXADDR_START, but don't need this check and it's even
wrong to have it.

It should be probably just #ifdef __i386__ instead of checking
such common symbols or better just be moved into arch/i386/mm/fault.c

-Andi
