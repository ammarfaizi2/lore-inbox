Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUEXQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUEXQZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUEXQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:25:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:26507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262574AbUEXQZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:25:48 -0400
Date: Mon, 24 May 2004 09:25:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC64] Don't clear MSR.RI in do_hash_page_DSI
In-Reply-To: <16561.60519.989823.14745@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0405240916410.32189@ppc970.osdl.org>
References: <16561.60519.989823.14745@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 looks like somebody has bought into the sign-off procedure. Great.

Except that I (and my tools) expected for the "Signed-off-by:" line to go
into the comment section _before_ the patch (and after the "explanation")
and obviously didn't make that part very clear.

The reason for that is partly because that's how all the current source
control helper tools work by extracting the changeset comments (but that
could certainly be changed), but more importantly because with a large
patch, it's very very easy to overlook the sign-off at the end of the
patch.

I only noticed after I applied this, so now you didn't get the distinction 
of being the first changeset ever to have the sign-off thing recorded ;^)

.. and the race is on.

(Seriously, while nobody has actually complained about the suggested
rules, I don't think anybody should feel compelled to do the sign-off
before we've had more time to let people argue over it. People who feel 
comfortable with the suggestion are obviously encouraged to start asap, 
though).

		Linus


On Mon, 24 May 2004, Paul Mackerras wrote:
>
> Some code that is used on iSeries (do_hash_page_DSI in head.S) was
> clearing the RI (recoverable interrupt) bit in the MSR when it
> shouldn't.  We were getting SLB miss interrupts following that which
> were panicking because they appeared to have occurred at a bad place.
> This patch fixes the problem.
> 
> Please apply.
> 
> Thanks,
> Paul.
> 
> diff -puN arch/ppc64/kernel/head.S~ibm-ppc64-hash-page-ri arch/ppc64/kernel/head.S
> --- forakpm/arch/ppc64/kernel/head.S~ibm-ppc64-hash-page-ri	2004-05-24 15:14:13.809492931 +1000
> +++ forakpm-anton/arch/ppc64/kernel/head.S	2004-05-24 15:14:13.816492844 +1000
> @@ -946,7 +946,7 @@ _GLOBAL(do_hash_page_DSI)
>  	 */
>  	mfmsr	r0
>  	li	r4,0
> -	ori	r4,r4,MSR_EE+MSR_RI
> +	ori	r4,r4,MSR_EE
>  	andc	r0,r0,r4
>  	mtmsrd	r0			/* Hard Disable, RI off */
>  
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
