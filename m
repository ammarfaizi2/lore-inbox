Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264052AbUD0M4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbUD0M4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUD0M4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:56:52 -0400
Received: from [203.14.152.115] ([203.14.152.115]:48136 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264052AbUD0M4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:56:49 -0400
Date: Tue, 27 Apr 2004 22:54:02 +1000
To: Pavel Machek <pavel@suse.cz>
Cc: seife@suse.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427125402.GA16740@gondor.apana.org.au>
References: <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au> <20040427124837.GK10593@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427124837.GK10593@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 02:48:38PM +0200, Pavel Machek wrote:
> 
> This should be better solution, could anyone test it? [It compiles,
> and I'm out of time now].

Well it still doen't solve the non-PSE case since you're only copying the
top-level page table.
  
> --- tmp/linux/arch/i386/power/cpu.c	2003-09-28 22:05:30.000000000 +0200
> +++ linux/arch/i386/power/cpu.c	2004-04-27 14:44:03.000000000 +0200
> @@ -35,6 +35,9 @@
>  unsigned long saved_context_esi, saved_context_edi;
>  unsigned long saved_context_eflags;
>  
> +/* Special page directory for resume */
> +char swsusp_pg_dir[PAGE_SIZE];
> +

You forgot to mark this as nosave.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
