Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWGPVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWGPVMo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 17:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGPVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 17:12:44 -0400
Received: from mx1.suse.de ([195.135.220.2]:11195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751209AbWGPVMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 17:12:43 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH for 2.6.18-rc2] [2/8] i386/x86-64: Don't randomize stack top when no randomization personality is set
Date: Sun, 16 Jul 2006 23:14:07 +0200
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
References: <44ba2f8d.0hsur33TTkK+bbJl%ak@suse.de> <20060716204712.GA29161@elte.hu>
In-Reply-To: <20060716204712.GA29161@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607162314.07764.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 July 2006 22:47, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> >  unsigned long arch_align_stack(unsigned long sp)
> >  {
> > -	if (randomize_va_space)
> > +	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> >  		sp -= get_random_int() % 8192;
> >  	return sp & ~0xf;
>
> i'm not opposing this patch at all, but didnt the performance problems
> go away when the 0xf was changed to 0x7f?

Yes, but i sent the patch before that other patch was available.

I guess it's a separate issue anyways - this patch is just concerned about 
disabling randomization consistently. Performance optimization can be done
in another one.

-Andi


