Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVCMQoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVCMQoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVCMQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:44:31 -0500
Received: from one.firstfloor.org ([213.235.205.2]:37547 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261360AbVCMQht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:37:49 -0500
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 kprobes: handle %RIP-relative addressing mode
References: <200503130954.j2D9sgjB028594@magilla.sf.frob.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 13 Mar 2005 17:37:46 +0100
In-Reply-To: <200503130954.j2D9sgjB028594@magilla.sf.frob.com> (Roland
 McGrath's message of "Sun, 13 Mar 2005 01:54:42 -0800")
Message-ID: <m18y4ry011.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> The existing x86-64 kprobes implementation doesn't cope with the
> %RIP-relative addressing mode.  Kprobes work by single-stepping a copy of

Thanks for fixing that long standing bug. 

> +	static const unsigned char onebyte_has_modrm[256] = {

Can you turn these two arrays into a bitmap please? 

> +	 * This basically replicates __vmalloc, except that it uses a

This shouldn't be opencoded here. Instead make a utility function
like vmalloc_range() that takes a start and end address and
make the module allocation use it too.

Also you should fix up asm-x86_64/page.h and Documentation/x86_64/mm.txt
with the new fixed allocation.

> +	 * range of addresses starting a MODULE_END.  This also
> +	 * allocates a single page of address space with no following
> +	 * guard page (__get_vm_area always adds PAGE_SIZE to the size,
> +	 * so by passing zero we get the one page).  We set up all the

I think Andrea has just changed that and the patch went into
mainline. Be careful with merging.

-Andi
