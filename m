Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWEZG7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWEZG7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWEZG7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:59:43 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19103
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751304AbWEZG7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:59:43 -0400
Message-Id: <4476C3B1.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 26 May 2006 09:00:33 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <mingo@elte.hu>, "Andreas Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S
	annotations)
References: <4471D691.76E4.0078.0@novell.com> <20060524222359.06f467e8.akpm@osdl.org> <20060524224159.6a049775.akpm@osdl.org>
In-Reply-To: <20060524224159.6a049775.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure - it doesn't use the assembler's .cfi_* directives, but encodes things manually. I'll still have to check why
you're getting these errors, as you should see entirely different ones if the assembler didn't support the directives at
all. Jan

>>> Andrew Morton <akpm@osdl.org> 25.05.06 07:41 >>>
Andrew Morton <akpm@osdl.org> wrote:
>
> "Jan Beulich" <jbeulich@novell.com> wrote:
>  >
>  >  #define SAVE_ALL \
>  >   	cld; \
>  >   	pushl %es; \
>  >  +	CFI_ADJUST_CFA_OFFSET 4;\
>  >  +	/*CFI_REL_OFFSET es, 0;*/\
>  >   	pushl %ds; \
> 
>  arch/i386/kernel/entry.S: Assembler messages:
>  arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
>  arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
>  arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
>  arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
>  arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
>  arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
>  arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> 
>  etcetera.  And
> 
>  arch/i386/kernel/entry.S:757: Error: no such instruction: `eax,0'
>  arch/i386/kernel/entry.S:757: Error: no such instruction: `ebp,0'
> 

btw, this cfi annotation code:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/broken-out/kgdb-cfi_annotations.patch


compiles happily with that toolchain.

