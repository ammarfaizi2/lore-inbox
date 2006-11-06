Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753765AbWKFSWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbWKFSWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbWKFSWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:22:24 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:4768 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1753759AbWKFSWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:22:24 -0500
Date: Mon, 6 Nov 2006 11:22:23 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061106182222.GO27140@parisc-linux.org>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 01:12:05PM -0500, Jeff Layton wrote:
> The attached patch remedies this by making the last_inode counter be an
> unsigned int on kernels that have ia32 compatability mode enabled.

... and this only happens on ia64/x86_64 kernels, not sparc64, ppc64,
s390x, parisc64 or mips64?

>  {
> +#if (defined CONFIG_IA32_EMULATION || defined CONFIG_IA32_SUPPORT)
> +	static unsigned int last_ino;
> +#else
>  	static unsigned long last_ino;
> +#endif
>  	struct inode * inode;

I suspect what you really want there is CONFIG_COMPAT.
