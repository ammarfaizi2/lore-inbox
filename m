Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUKOX0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUKOX0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUKOX0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:26:40 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2317 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261533AbUKOX0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:26:39 -0500
Date: Mon, 15 Nov 2004 23:26:35 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Nickolai Zeldovich <kolya@MIT.EDU>
Cc: linux-kernel@vger.kernel.org, csapuntz@stanford.edu
Subject: Re: [patch] Fix GDT re-load on ACPI resume
In-Reply-To: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
Message-ID: <Pine.LNX.4.58L.0411152320520.12776@blysk.ds.pg.gda.pl>
References: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Nickolai Zeldovich wrote:

> This simple patch adds the 0x66 prefix to lgdt, which forces it to load
> all 32 bits of the GDT base address, thereby removing any restrictions on
> where the GDT can be placed in memory.  This makes ACPI resume work for me
> on a Thinkpad T40 laptop.
[...]
> +	.byte	0x66			# force 32-bit operands in case
> +					# the GDT is past 16 megabytes
>  	lgdt	real_save_gdt - wakeup_code

 You should use "lgdtl" and let gas figure out the rest.

  Maciej
