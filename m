Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTJIMz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTJIMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:55:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37382 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262111AbTJIMzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:55:54 -0400
Date: Thu, 9 Oct 2003 14:55:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <Pine.LNX.4.44.0310081904330.2721-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0310091408460.8124-100000@serv>
References: <Pine.LNX.4.44.0310081904330.2721-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 8 Oct 2003, Linus Torvalds wrote:

> And while I agree that the depth clearing is bogus, but I'd be worried
> about removing it in case some driver actually depends on it (ie
> historically it has actually been ok to do:
> 
> 	disable_irq(irq);
> 	.. set up device ..
> 	request_irq(irq, ..);	// This will also enable the irq
> 
> even though it's ugly, and I hope nobody does it).

If there are such cases left, I'd really prefer we fix them, as currently 
nothing protects this against another driver requesting the same irq. To 
make this even more fun the behaviour is also different if the irq is 
shared, as the irq is not enabled in this case.
In the ide driver I'd really like to see that at the time the probe 
function reenables the interrupt there is either an irq handler installed 
or it failed. On the Amiga we also have always problems with this, as the 
interrupt must be acknowledged by the driver, so we have to be careful not 
to leave anything pending. The irq handler would automatically take care 
of this and would make this simpler.

bye, Roman

