Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWJYULM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWJYULM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWJYULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:11:12 -0400
Received: from c60.cesmail.net ([216.154.195.49]:35157 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S965213AbWJYULK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:11:10 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 25 Oct 2006 16:11:09 -0400
Message-Id: <1161807069.3441.33.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan!
> 
> > non-GPL-due-to-transitivity going to be checked? Why does module loader mark
> > only couple of modules as non-GPL, when there are other drivers that load
> > some sort of binary code? It is understandable to mark a module as non-GPL if
> > it is lying about its license, but as far as that is concerned, ndiswrapper
> > (alone) is GPL.
> 
> Yes. I don't think the current situation is neccessarily correct, but if
> it uses EXPORT_SYMBOL_GPL then the "now taint me" ought to fail and the
> driver ought to refuse to load a non GPL windows driver.

Why is that?  I don't see any reasonable argument behind this
requirement.  "now taint me" is not an equivalent to "I was lying about
my license".  It means "I'm going to to something that kernel developers
don't want to debug".

I don't see any legal reasons behind this restriction.  A driver under
GPL should be able to use any exported symbols.  EXPORT_SYMBOL_GPL is a
technical mechanism of enforcing GPL against non-free code, but
ndiswrapper is free.  The non-free NDIS drivers are not using those
symbols.

Neither do I see any technical reasons.  Tainting already means that the
kernel developers are not interested in possible problems created by the
driver.  Imposing further limits on functionality of ndiswrapper makes
no sense.  It only creates problems.

How is this situation different from denying other capabilities to the
drivers that have used GPL symbols?  How can I be sure that my driver
will be able to request firmware from userspace even though it uses
sysfs functionality via EXPORT_SYMBOL_GPL?  What if somebody decides
that it's immoral or questionable for a GPL driver to do so?

Regardless of whether ndiswrapper can work around the limitations
imposed on it, it sets a very bad precedent when kernel developers are
arbitrarily and deliberately breaking existing functionality of an
external driver without having any excuse whatsoever.

I hope the offending code will be backed from the kernel for 2.6.19.  In
my opinion, further changes in that direction (if they are needed)
should be based on more solid reasons.

-- 
Regards,
Pavel Roskin

