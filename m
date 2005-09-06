Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVIFVKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVIFVKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVIFVKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:10:31 -0400
Received: from are.twiddle.net ([64.81.246.98]:32153 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1750949AbVIFVKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:10:30 -0400
Date: Tue, 6 Sep 2005 14:10:19 -0700
From: Richard Henderson <rth@twiddle.net>
To: Chaskiel Grundman <cg2v@andrew.cmu.edu>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: (alpha) process_reloc_for_got confuses r_offset and r_addend
Message-ID: <20050906211019.GA8430@twiddle.net>
Mail-Followup-To: Chaskiel Grundman <cg2v@andrew.cmu.edu>,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <Pine.LNX.4.63.0509051334440.8784@localhost> <9a874849050905113369bae774@mail.gmail.com> <Pine.LNX.4.61.0509051439040.10147@endicott.pit.dementia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509051439040.10147@endicott.pit.dementia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is correct.


r~

On Mon, Sep 05, 2005 at 02:42:36PM -0400, Chaskiel Grundman wrote:
> On Mon, 5 Sep 2005, Jesper Juhl wrote:
> > Why not post the patch you made for review as well?
> 
> In part because if the analysis is wrong, then the patch surely is.
> 
> but mostly because I didn't want to post my message with the bland subject 
> that the faq recommends for patches.
> 
> --- linux-2.6.12.5/arch/alpha/kernel/module.c      2005-08-14 20:20:18.000000000 -0400
> +++ linux/arch/alpha/kernel/module.c   2005-09-05 12:38:43.000000000 -0400
> @@ -47,7 +47,7 @@
> 
>   struct got_entry {
>          struct got_entry *next;
> -       Elf64_Addr r_offset;
> +       Elf64_Sxword r_addend;
>          int got_offset;
>   };
> 
> @@ -57,14 +57,14 @@
>   {
>          unsigned long r_sym = ELF64_R_SYM (rela->r_info);
>          unsigned long r_type = ELF64_R_TYPE (rela->r_info);
> -       Elf64_Addr r_offset = rela->r_offset;
> +       Elf64_Sxword r_addend = rela->r_addend;
>          struct got_entry *g;
> 
>          if (r_type != R_ALPHA_LITERAL)
>                  return;
> 
>          for (g = chains + r_sym; g ; g = g->next)
> -               if (g->r_offset == r_offset) {
> +               if (g->r_addend == r_addend) {
>                          if (g->got_offset == 0) {
>                                  g->got_offset = *poffset;
>                                  *poffset += 8;
> @@ -74,7 +74,7 @@
> 
>          g = kmalloc (sizeof (*g), GFP_KERNEL);
>          g->next = chains[r_sym].next;
> -       g->r_offset = r_offset;
> +       g->r_addend = r_addend;
>          g->got_offset = *poffset;
>          *poffset += 8;
>          chains[r_sym].next = g;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
