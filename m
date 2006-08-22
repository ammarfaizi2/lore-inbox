Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWHVNfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWHVNfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWHVNfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:35:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4286 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932232AbWHVNfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:35:36 -0400
Subject: Re: [PATCH] paravirt.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <44DB7596.6010503@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 14:56:03 +0100
Message-Id: <1156254965.27114.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-10 am 11:06 -0700, ysgrifennodd Jeremy Fitzhardinge:
> Rusty Russell wrote:
> > +EXPORT_SYMBOL_GPL(paravirt_ops);
> >   
> This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
> driver module will need to be GPL...

It would be nice not to export it at all or to protect it, paravirt_ops
is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
is properly protected, its an unpleasantly large security target if not.

It would be a lot safer if we could have the struct paravirt_ops in
protected read-only const memory space, set it up in the core kernel
early on in boot when we play "guess todays hypervisor" and then make
sure it stays in read only (even to kernel) space.

Once you can't patch it then the worries about rootkits and patching it
that might make people want it particularly to be _GPL should mostly go
away too.

Alan

