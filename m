Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWIDKV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWIDKV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWIDKV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:21:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7659 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932122AbWIDKV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:21:56 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> 
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> 
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, dhowells@redhat.com,
       davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 11:21:35 +0100
Message-ID: <17162.1157365295@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Aubrey <aubreylee@gmail.com> wrote:

> Is there any solution/patch to fix the issue?

Make the SLOB allocator mark its pages PG_slab, just like the SLAB allocator
does.  I think this should be okay as the SLOB allocator and the SLAB
allocator seem to be mutually exclusive.

Using PG_slab would also give an instant check to things like SLOB's kfree().

> +#ifdef CONFIG_SLAB
>        if (PageSlab(page))
> +#endif

This is not a valid workaround as the object won't necessarily have been
allocated from a slab (shared ramfs mappings and SYSV SHM for example).  You
may not pass to ksize() objects allocated by means other than SLAB/SLOB.

David

-- 
VGER BF report: H 1.12398e-05
