Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVBRMPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVBRMPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBRMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:15:51 -0500
Received: from ltgp.iram.es ([150.214.224.138]:48515 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261332AbVBRMPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:15:46 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 18 Feb 2005 13:09:14 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Message-ID: <20050218120914.GB31891@iram.es>
References: <200502151557.06049.jbarnes@sgi.com> <1108515817.13375.63.camel@gaston> <200502161554.02110.jbarnes@sgi.com> <1108601294.5426.1.camel@gaston> <9e473391050217083312685e44@mail.gmail.com> <1108680350.5665.7.camel@gaston> <9e473391050217145620fecfdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050217145620fecfdc@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 05:56:03PM -0500, Jon Smirl wrote:
> On Fri, 18 Feb 2005 09:45:50 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> > Can't the size be obtained like any other BAR ?
> 
> yes, but cards that don't fully decode their ROM address space can
> waste memory in copy_rom. For example I have a card around here that
> reports a BAR address space of 128K and has a 2K ROM in it. You only
> want to copy the 2K, not the 128K.

Indeed, but they normally repeat by powers of 2, ignoring
high order address bits. Is it that hard to detect?

For example if it declares 128k, compare the two halves, reduce
to 64k if equal. Lather, rinse, repeat.

It's equivalent to reading the BAR declared size twice in 
the worst case, so it's not that bad performance-wise.

That would only be in the case of an unknown signature
in the first bytes, otherwise the third byte gives you
the size IIUC.

	Gabriel
