Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUCVFGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUCVFGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:06:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38559
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261706AbUCVFGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:06:10 -0500
Date: Mon, 22 Mar 2004 06:07:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
Message-ID: <20040322050701.GM3649@dualathlon.random>
References: <20040322051318.597ad1f9.ak@suse.de> <20040322043454.GL3649@dualathlon.random> <20040322054512.0333dad8.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322054512.0333dad8.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 05:45:12AM +0100, Andi Kleen wrote:
> On Mon, 22 Mar 2004 05:34:54 +0100
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> 
> > 32bit archs needs to get O_LARGEFILE in return from getfl (if they set
> > it [it's not set implicitly in 32bit archs] they will be able to handle
> > it transparently in glibc too, and I believe they really want it). 64bit
> > archs not, hence the fix.
> 
> If 32bit archs need it then 64bit archs need it too (think 32bit emulated processes
> on 64bit jernels)  But I think in practice it doesn't matter, so I would prefer to be 
> consistent between 32bit and 64bit.
> 
> I don't feel very strongly about this however ...

I agree it'd be a lot simpler to handle 32bit user on 64bit kernel if we
can clear it unconditionally (otherwise we've to trap getfl with a
ia32 wrapper) but I'm afraid the api may break if we clear that bit
unconditionally. I can't tell you for sure by memory though because the
last time I worked on this was one year and half ago and this is really
a matter of API. We should ask the glibc people for another confirmation
before choosing if to clear it only in 64bit archs or in 32bit too.
