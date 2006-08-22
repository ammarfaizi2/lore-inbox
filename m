Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWHVPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWHVPMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHVPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:12:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932307AbWHVPMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:12:35 -0400
Subject: Re: [PATCH] paravirt.h
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <44EB1BEB.60202@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain> <44EB1BEB.60202@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 17:12:10 +0200
Message-Id: <1156259530.2976.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 07:59 -0700, Jeremy Fitzhardinge wrote:
> Alan Cox wrote:
> > It would be nice not to export it at all or to protect it, paravirt_ops
> > is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
> > is properly protected, its an unpleasantly large security target if not.
> >   
> 
> Do you have an example of an attack which would become significantly 
> easier with pv_ops in use?  I agree it might make a juicy target, but 
> surely it is just a matter of degree given that any attacker who can get 
> to pv_ops can do pretty much anything else.

it makes for a "clean" and robust rootkit rather than a fragile one

> 
> > It would be a lot safer if we could have the struct paravirt_ops in
> > protected read-only const memory space, set it up in the core kernel
> > early on in boot when we play "guess todays hypervisor" and then make
> > sure it stays in read only (even to kernel) space.
> >   
> 
> Yes, I'd thought about doing something like that, but as Arjan pointed 
> out, nothing is actually read-only in the kernel when using a 2M 

that's why there is a config option :) THe 2Mb advantage is a bit
overrated btw; there are very few such tlbs in current processors so the
kernel gets tlb misses anyway. And since most of the code is in the
first 2Mb (which isn't broken up) of the kernel text it's not that bad
tlb wise either

(and it was Andi that pointed that out, not me)

