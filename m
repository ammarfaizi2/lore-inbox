Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbUDNIYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUDNIYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:24:31 -0400
Received: from mail.shareable.org ([81.29.64.88]:7072 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263967AbUDNIY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:24:29 -0400
Date: Wed, 14 Apr 2004 09:23:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Non-Exec stack patches
Message-ID: <20040414082355.GA8303@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Recent ia64 mm trees are broken because of this issue. Attached
> patch fixes protection_map[7] in IA64.

> --- linux-265mm5/include/asm-ia64/pgtable.h~    2004-04-14 00:09:04.000000000 -0700
> +++ linux-265mm5/include/asm-ia64/pgtable.h     2004-04-13 23:45:29.000000000 -0700
> @@ -148,7 +148,7 @@
>  #define __P100 __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
>  #define __P101 __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
>  #define __P110 PAGE_COPY
> -#define __P111 PAGE_COPY
> +#define __P111 PAGE_COPY_EXEC
>   
>  #define __S000 PAGE_NONE
>  #define __S001 PAGE_READONLY

I'm looking at 2.6.5, and it doesn't define PAGE_COPY_EXEC.  In 2.6.5,
asm-ia64/pgtable.h, PAGE_COPY is executable, and PAGE_READONLY is
non-executable.

Yes I know the naming is different from all the other asm-* files, but
that's what it says.  All of those definitions have confused names on
ia64, although they seem to have the rights bits set in the end.

Has the meaning of PAGE_COPY in asm-ia64/pgtable.h changed in 2.6.5-mm5?

If so, you want to change __P110 as well as __P111.

-- Jamie
