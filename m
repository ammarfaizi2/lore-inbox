Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUI1JP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUI1JP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 05:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUI1JP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 05:15:56 -0400
Received: from gprs214-20.eurotel.cz ([160.218.214.20]:21380 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265697AbUI1JPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 05:15:55 -0400
Date: Tue, 28 Sep 2004 11:12:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Rik van Riel <riel@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040928091252.GD18819@elf.ucw.cz>
References: <20040926002037.GP3309@dualathlon.random> <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com> <20040926004608.GS3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926004608.GS3309@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > But even ppc64 is wrong as far as C is concerned,
> > 
> > Looks fine to me.  From include/asm-ppc64/pgtable.h
> > 
> > static inline void set_pte(pte_t *ptep, pte_t pte)
> > {
> >         if (pte_present(*ptep)) {
> >                 pte_clear(ptep);
> >                 flush_tlb_pending();
> >         }
> >         *ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
> > }
> 
> As far as the C language is concerned that *ptep = something can be
> implemented with 8 writes of 1 byte each (or alternatively with an
> assembler instruction that may make the written data visible not

I'd say that it is okay to do this in arch-dependend
code. Architecture controls list of compilers allowed.


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
