Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVDYEEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVDYEEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 00:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVDYEEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 00:04:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262526AbVDYEE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 00:04:28 -0400
Date: Mon, 25 Apr 2005 05:04:42 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roland Dreier <roland@topspin.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix include order in mthca_memfree.c
Message-ID: <20050425040442.GO13052@parcelfarce.linux.theplanet.co.uk>
References: <52vf6bwps9.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52vf6bwps9.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 07:31:18PM -0700, Roland Dreier wrote:
>  - Out of curiousity, what arch and/or config requires <linux/mm.h>?
>    I regularly cross-compile drivers/infiniband for i386, x86_64, ppc64,
>    ia64, sparc64 and ppc, and I haven't needed <linux/mm.h> in mthca_memfree.c.

alpha, for instance.  You are using lowmem_page_address().  That's
from linux/mm.h and that's an inline function, so missing include
is fatal.

FWIW, the chain of includes that leads to mm.h on i386 is mthca_memfree.h ->
linux/pci.h -> asm-i386/pci.h -> linux/mm.h.  Other platforms differ...

>  - When making changes to drivers/infiniband, can you please cc the
>    maintainers or at least a public mailing list?  As far as I can
>    tell, the patch went directly to Linus with no public review, which
>    doesn't seem appropriate, no matter how trivial the change.
> 
>  - When adding includes, please match the existing style and put
>    <linux/xxx.h> includes before any local "yyy.h" includes.

Sure, no problem.
