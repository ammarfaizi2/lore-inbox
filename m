Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVDZWUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDZWUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDZWUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:20:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16050 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261817AbVDZWUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:20:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17006.48763.905570.316355@alkaid.it.uu.se>
Date: Wed, 27 Apr 2005 00:19:39 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>, ak@suse.de,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31-pre1] x86_64 breakage on UP_IOAPIC
In-Reply-To: <Pine.LNX.4.62.0504270017210.2071@dragon.hyggekrogen.localhost>
References: <17006.40286.664503.252615@alkaid.it.uu.se>
	<Pine.LNX.4.62.0504270017210.2071@dragon.hyggekrogen.localhost>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl writes:
 > Tiny, trivial, pedantic whitespace nit : 
 > 
 > On Tue, 26 Apr 2005, Mikael Pettersson wrote:
 > 
 > > The
 > > 
 > >   o x86_64: Resend lost APIC IRQs on Uniprocessor too
 > > 
 > > change in 2.4.31-pre1 causes linkage errors: on UP_IOAPIC systems it
 > > creates references to send_IPI_self() which is only defined on SMP.
 > > 
 > > The patch below reverts this change.
 > > 
 > > Alternatively, x86_64 could implement a send_IPI_self() fallback for !SMP,
 > > just like i386 does.
 > > 
 > > /Mikael
 > > 
 > > --- linux-2.4.31-pre1/include/asm-x86_64/hw_irq.h.~1~	2005-04-26 20:57:43.000000000 +0200
 > > +++ linux-2.4.31-pre1/include/asm-x86_64/hw_irq.h	2005-04-26 21:09:31.000000000 +0200
 > > @@ -156,7 +156,7 @@ static inline void x86_do_profile (unsig
 > >  	atomic_inc((atomic_t *)&prof_buffer[eip]);
 > >  }
 > >  
 > > -#ifdef CONFIG_X86_IO_APIC
 > > +#ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
 >                      ^^^
 >                       Space here?

I did a cut-n-paste from the 2.4.30 original.

/Mikael
