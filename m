Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWGaOwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWGaOwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGaOwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:52:41 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:47622 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751136AbWGaOwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:52:40 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: armbru@redhat.com (Markus Armbruster), ak@suse.de
Subject: Re: [PATCH] Fix trivial unwind info bug
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <874px31tz4.fsf@pike.pond.sub.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G7Z8C-0007IO-00@gondolin.me.apana.org.au>
Date: Tue, 01 Aug 2006 00:52:32 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Armbruster <armbru@redhat.com> wrote:
> CFA needs to be adjusted upwards for push, and downwards for pop.
> arch/i386/kernel/entry.S gets it wrong in one place.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks for the patch Markus.  Andi Kleen is now maintaining i386
so please cc him in future for i386 patches.

> diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
> index d9a260f..37a7d2e 100644
> --- a/arch/i386/kernel/entry.S
> +++ b/arch/i386/kernel/entry.S
> @@ -204,7 +204,7 @@ #define RING0_PTREGS_FRAME \
> ENTRY(ret_from_fork)
>        CFI_STARTPROC
>        pushl %eax
> -       CFI_ADJUST_CFA_OFFSET -4
> +       CFI_ADJUST_CFA_OFFSET 4
>        call schedule_tail
>        GET_THREAD_INFO(%ebp)
>        popl %eax

I wonder if this is related to the problem of dump_stack() crashing...

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
