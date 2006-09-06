Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWIFSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWIFSYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWIFSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:24:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751477AbWIFSYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:24:43 -0400
Date: Wed, 6 Sep 2006 11:24:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
In-Reply-To: <44FC193C.4080205@openvz.org>
Message-ID: <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
References: <44FC193C.4080205@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Sep 2006, Kirill Korotaev wrote:
> 
> this patch is already commited into -stable 2.6.17.y tree.

I don't like it. Apparently the patch was bad, and broken on MIPS and 
parisc, and it was applied to the stable tree without being in the 
standard tree.

If MIPS and parisc don't matter for the stable tree (very possible - there 
are no big commercial distributions for them), then dammit, neither should 
ia64 and sparc (there are no big commercial distros for them either). 
Either way, it seems this didn't happen the way it should have.

The proper fix would _seem_ to have the whole

	#ifndef arch_mmap_check
	#define arch_mmap_check(addr, len, flags) (0)
	#endif

in the only file that actually _uses_ this, namely mm/mmap.c. Rather than 
pollute lots of architecture-specific files with this macro that nobody 
really is interested in except for ia64 and sparc.

			Linus
