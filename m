Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVEQWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVEQWvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVEQWmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:42:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:36031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262021AbVEQWjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:39:09 -0400
Date: Tue, 17 May 2005 15:39:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: hugh@veritas.com, luming.yu@intel.com, racing.guo@intel.com, ak@suse.de,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] x86 port lockless MCE quirky bank0
Message-Id: <20050517153941.7d99d1f6.akpm@osdl.org>
In-Reply-To: <20050517202428.GD307@wotan.suse.de>
References: <Pine.LNX.4.61.0505172107490.5585@goblin.wat.veritas.com>
	<20050517202428.GD307@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > +	if ((c->x86_vendor == X86_VENDOR_AMD ||
> > +	     c->x86_vendor == X86_VENDOR_INTEL) && c->x86 == 6) {
> > +		/*
> > +		 * Intel P6 cores go bang quickly when bank0 is enabled.
> > +	 	 * Some Athlons cause spurious MCEs when bank0 is enabled.
> > +		 */
> > +		quirky_bank0 = 1;
> > +	}
> 
> That's wrong on K8 AMD machines at least. You need to check c->x86
> there too.
> 
> And better would be to just do bank[0] = 0 instead of
> adding the new variable.
> 
> -Andi
> 
> P.S.: Also Yu Luming can you please submit an updated patch that keeps mce.c
> in arch/x86_64 like we discussed earlier?

Yes.  I'll drop the following from -mm:

x86-port-lockless-mce-preparation.patch
x86-port-lockless-mce-implementation.patch
x86-port-lockless-mce-implementation-fix.patch
x86-port-lockless-mce-implementation-fix-2.patch

