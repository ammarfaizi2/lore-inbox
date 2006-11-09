Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424052AbWKIP27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424052AbWKIP27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424054AbWKIP27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:28:59 -0500
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:11689 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1424052AbWKIP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:28:57 -0500
Date: Thu, 9 Nov 2006 16:44:36 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, sct@redhat.com, ak@suse.de,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Message-ID: <20061109154436.GA31954@mailshack.com>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <1163084072.31014.275411753@webmail.messagingengine.com> <Pine.LNX.4.58.0611091016100.6250@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611091016100.6250@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Thu, 09 Nov 2006 16:28:53 +0100 (CET)
X-AntiVirus: checked by AntiVir Milter (version: 1.1.3-1; AVE: 7.2.0.39; VDF: 6.36.1.10; host: AntiVir1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:18:53AM -0500, Steven Rostedt wrote:
> Hmm, Andi,
> 
> Should this be more like what is done in x86? Although this isn't a major
> bug or anything, would it be cleaner. For example doing:
> 
> @@ -836,11 +836,15 @@ gdt:
>         .word   0x9200                          # data read/write
>         .word   0x00CF                          # granularity = 4096, 386
>                                                 #  (+5th nibble of limit)
> +gdt_end:
> +       .align  4
> +
> +       .word   0                               # alignment byte
>  idt_48:
>         .word   0                               # idt limit = 0
>         .word   0, 0                            # idt base = 0L
>  gdt_48:
> -       .word   0x8000                          # gdt limit=2048,
> +       .word   gdt_end - gdt - 1               # gdt limit=2048,
>                                                 #  256 GDT entries
> 
>         .word   0, 0                            # gdt base (filled in
> 
> instead?

Hi!

Maybe you should consider 16-byte aligning the gdt table too, like
i386 does? It doesn't hurt, and as per the comment in the i386-file
"16 byte aligment is recommended by intel."

Greetings,
	Alexander van Heukelum

> If so, I can send you another patch that does this. Will need to test it
> first.
> 
> -- Steve
