Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUJTPxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUJTPxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJTPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:52:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268479AbUJTPt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:49:27 -0400
Date: Wed, 20 Oct 2004 16:49:22 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org,
       linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       linux-sh@m17n.org, linux-390@vm.marist.edu, sparclinux@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-arm-kernel@lists.arm.linux.org.uk,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020154922.GV16153@parcelfarce.linux.theplanet.co.uk>
References: <3506.1098283455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3506.1098283455@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:44:15PM +0100, David Howells wrote:
> The attached patch adds syscalls for almost all archs (everything barring
> m68knommu which is in a real mess, and i386 which already has it).
> 
> It also adds 32->64 compatibility where appropriate.

> --- linux-2.6.9-bk4/arch/parisc/kernel/syscall_table.S	2004-06-18 13:43:47.000000000 +0100
> +++ linux-2.6.9-bk4-keys/arch/parisc/kernel/syscall_table.S	2004-10-20 14:58:51.533643420 +0100
> @@ -341,5 +341,7 @@
>    ENTRY_SAME(mq_timedreceive)
>    ENTRY_SAME(mq_notify)
>    ENTRY_SAME(mq_getsetattr)
> -  /* Nothing yet */       /* 235 */
> +	ENTRY_SAME(add_key)	/* 235 */
> +	ENTRY_SAME(request_key)
> +	ENTRY_SAME(keyctl)

Um, no.  Should be ENTRY_COMP() if there's compat syscalls.  And those
particular syscall numbers have already been assigned (blame Linus for
dropping the PA-RISC patch on the floor instead of including it in 2.6.9).

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
