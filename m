Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUJNSpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUJNSpC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUJNSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:43:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5280 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266914AbUJNSAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:00:19 -0400
Date: Thu, 14 Oct 2004 10:59:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: akpm@osdl.org, luto@myrealbox.com, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V9: [7/7] atomic pte operatiosn
 for s390
In-Reply-To: <20040928150743.GA6305@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0410141051560.18209@schroedinger.engr.sgi.com>
References: <20040928150743.GA6305@mschwid3.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004, Martin Schwidefsky wrote:

> operation that needs to get implemented by use of the ipte. You'll
> find a new patch that adds an implementation of ptep_xchg_flush for
> s390 below, the old patch is broken. Please replace.

Ok. Thanks. Added to my patch.


> There are some more things that need improvement:
> * You should introduce a #define for each of the new primitives
>   (__HAVE_ARCH_PTEP_CMPXCHG, __HAVE_ARCH_PTEP_XCHG_FLUSH, etc) so
>   that the architectures can redefine the primitives separatly.
>   For s390 I need to define a ptep_xchg_flush but want to use the
>   default implementation for all the other new primitives.

Ok. done.

> * In the generic implementations of the new primitives please use
>   the mm from the vma to do the locking. To rely on the fact that
>   the memory structure in the functions that use the macros are always
>   called "mm" is quite a hack.

I did not notice that. The vma was passed to the macro but the mm
was used for locking... Amazingly it worked. Thanks...

> * The ptep_get_clear_flush primitive isn't used anywhere and should
>   be removed.

Done.

> * The flush_tlb_page in the generic ptep_cmpxchg implementation
>   shouldn't be there, the macro is used in code sequences where it
>   isn't needed (the old code didn't flush).

Removed.

Thanks for all the feedback and sorry for the late response. I was busy
with other stuff and there was a deadline upon us.

Hopefully I will get V10 out soon.

Greetings
	Christoph
