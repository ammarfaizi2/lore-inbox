Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWDXVJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWDXVJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDXVJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:09:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbWDXVJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:09:37 -0400
Date: Mon, 24 Apr 2006 14:09:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <Pine.LNX.4.61.0604241648340.24574@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0604241407130.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.61.0604241529360.24459@chaos.analogic.com>
 <Pine.LNX.4.64.0604241319030.3701@g5.osdl.org> <Pine.LNX.4.61.0604241648340.24574@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, linux-os (Dick Johnson) wrote:
> On Mon, 24 Apr 2006, Linus Torvalds wrote:
> >
> > SA_SHIRQ does NOT mean that the irq is shared.
> >
> > It means that it's not exclusive, and that the driver is _ok_ with it
> > being shared if that makes sense.
> 
> Yeah. You have been talking to too many lawyers! You are getting a
> forked tongue!

No, it's just legacy from some _really_ really old code. As in 1991.

The very original Linux irq system didn't share interrupts at all (hey, 
PCI was newfangled, and ISA interrupts ruled), so when interrupt sharing 
was added, the default was to not do it.

These days, that doesn't make any sense, and if somebody did the flags 
today, you'd do it the other way around (default to shared, and if 
somebody wants a really exclusive interrupt, they should say so with 
SA_EXCLUSIVE or something). 

But Linux grew from humble and stupid roots.

		Linus
