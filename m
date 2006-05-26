Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWEZHYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWEZHYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWEZHYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:24:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27554 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030482AbWEZHYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:24:50 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S annotations)
Date: Fri, 26 May 2006 09:18:52 +0200
User-Agent: KMail/1.9.1
Cc: "Jan Beulich" <jbeulich@novell.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <4471D691.76E4.0078.0@novell.com> <20060524222359.06f467e8.akpm@osdl.org>
In-Reply-To: <20060524222359.06f467e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605260918.52484.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 07:23, Andrew Morton wrote:
> "Jan Beulich" <jbeulich@novell.com> wrote:
> >
> >  #define SAVE_ALL \
> >   	cld; \
> >   	pushl %es; \
> >  +	CFI_ADJUST_CFA_OFFSET 4;\
> >  +	/*CFI_REL_OFFSET es, 0;*/\
> >   	pushl %ds; \
> 
> arch/i386/kernel/entry.S: Assembler messages:
> arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
> arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
> arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> arch/i386/kernel/entry.S:757: Warning: rest of line ignored; first ignored character is `4'
> arch/i386/kernel/entry.S:757: Error: CFI instruction used without previous .cfi_startproc
> 
> etcetera.  And
> 
> arch/i386/kernel/entry.S:757: Error: no such instruction: `eax,0'
> arch/i386/kernel/entry.S:757: Error: no such instruction: `ebp,0'

It works for me with
GNU assembler 2.16.91.0.2 20050720 (SuSE Linux)
(from SUSE 1.1) 

You probably need newer binutils.

If it's a common problem we might need to somehow hack a binutils version check 
into Kconfig or the Makefiles. 

-andi

