Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264234AbTIIRCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTIIRCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:02:54 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:18328 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S264234AbTIIRCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:02:37 -0400
Date: Tue, 9 Sep 2003 10:02:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with remap_page_range
Message-ID: <20030909100235.A20267@home.com>
References: <3F5E7ACD.8040106@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F5E7ACD.8040106@tait.co.nz>; from dmytro.bablinyuk@tait.co.nz on Tue, Sep 09, 2003 at 09:13:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:13:49PM -0400, Dmytro Bablinyuk wrote:
> 
> We have a DSP shared memory which we should access (from PowerPC).
> The problem is when I do ioremap I can see the memory correctly from the 
> driver (see below) but when I do remap_page_range to the user space 
> application then data appears to be wrong, I can recognize some values 
> there, but they are in the wrong places and other values around from 
> everywhere else (see below).

<snip>

>   if (remap_page_range(vma->vm_start,
>                        DSP_ADDR,
>                        size,
>                        vma->vm_page_prot
>                        ))

Your remap call isn't adding _PAGE_NO_CACHE and _PAGE_GUARDED flags
like ioremap_nocache()/ioremap() do on PPC.  You'll get bad results
because of the ordering and cache issues resulting from not using
these PTE flags.  In 2.6, these can be added using pgprot_noncached()
that is defined per-arch.

BTW, ioremap_nocache() and ioremap() are identical on PPC.

-Matt
