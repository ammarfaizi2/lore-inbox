Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTKCXoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 18:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTKCXoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 18:44:25 -0500
Received: from rth.ninka.net ([216.101.162.244]:21633 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263494AbTKCXoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 18:44:24 -0500
Date: Mon, 3 Nov 2003 16:41:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, jes@wildopensource.com,
       Jamie.Wellnitz@emulex.com, linux-kernel@vger.kernel.org
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
Message-Id: <20031103164116.5793a95e.davem@redhat.com>
In-Reply-To: <16294.53393.763572.291298@napali.hpl.hp.com>
References: <20031102181224.GD2149@ma.emulex.com>
	<yq0wuahan3t.fsf@trained-monkey.org>
	<20031103125259.GC16690@ma.emulex.com>
	<yq0sml5a63s.fsf@wildopensource.com>
	<16294.53393.763572.291298@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003 14:02:57 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On 03 Nov 2003 09:17:59 -0500, Jes Sorensen <jes@wildopensource.com> said:
> 
>   Jes> Hmmm, my brain has gotten ia64ified ;-) It's basically the normal
>   Jes> mappings of the kernel, ie. the kernel text/data/bss segments as well
>   Jes> as anything you do not get back as a dynamic mapping such as
>   Jes> ioremap/vmalloc/kmap.
> 
> I don't think it's safe to use virt_to_page() on static kernel
> addresses (text, data, and bss).  For example, ia64 linux nowadays
> uses a virtual mapping for the static kernel memory, so it's not part
> of the identity-mapped segment.

That's correct and it'll break on sparc64 for similar reasons.

It's also not safe to do virt_to_page() on kernel stack addresses
either.
