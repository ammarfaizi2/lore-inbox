Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSBIIdm>; Sat, 9 Feb 2002 03:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288731AbSBIId1>; Sat, 9 Feb 2002 03:33:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288623AbSBIIdM>;
	Sat, 9 Feb 2002 03:33:12 -0500
Message-ID: <3C64DE99.D8F2DC61@zip.com.au>
Date: Sat, 09 Feb 2002 00:32:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.21.0202090808390.872-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> It's frustrating that when Verbose BUG() reporting is configured,
> info gets lost: fix for i386 below.  This is your area, Andrew:

Well you know I'm a sucker for debug code.

> please confirm to Marcelo if you'd like him to apply this.

I'd like it.
 
> Example: in hpa's recent prune_dcache crash, %eax showed the length of
> the kernel BUG printk, when we'd have liked to see the invalid d_count:
> off-by-one or obviously corrupted?

Absolutely.
 
> Hugh
> 
> --- 2.4.18-pre9/arch/i386/kernel/entry.S        Thu Feb  7 14:38:06 2002
> +++ linux/arch/i386/kernel/entry.S      Fri Feb  8 21:47:39 2002

The implementation looks fine to me.  You've checked that it
builds OK with CONFIG_DEBUG_BUGVERBOSE=n?

It's a shame that gcc never seems to have gained full support for
attribute __interrupt__, which, if they did it right, would preserve 
all registers.   gcc-for-PPC seems to support it.

-
