Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWEYFmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWEYFmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWEYFmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:42:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965050AbWEYFmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:42:37 -0400
Date: Wed, 24 May 2006 22:41:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbeulich@novell.com, ak@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S
 annotations)
Message-Id: <20060524224159.6a049775.akpm@osdl.org>
In-Reply-To: <20060524222359.06f467e8.akpm@osdl.org>
References: <4471D691.76E4.0078.0@novell.com>
	<20060524222359.06f467e8.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

