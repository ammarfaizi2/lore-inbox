Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWANUIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWANUIv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWANUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:08:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:50188 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751050AbWANUIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:08:50 -0500
Date: Sat, 14 Jan 2006 21:08:39 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Watchdog: Winsystems EPX-C3 SBC
Message-ID: <20060114200839.GA14036@w.ods.org>
References: <Pine.LNX.4.64.0601132149430.9231@rtlab.med.cornell.edu> <1137266649.23269.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137266649.23269.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 07:24:09PM +0000, Alan Cox wrote:
> Some quick comments:
> 
> +       if (len) {
> +               epx_c3_pet();
> +       }
> 
> Doesn't need brackets (minor style)
> 
> Otherwise it looks excellent but should use request_region and friends
> to claim the two ports it uses.

You just remind me that I had to comment out the request_region in another
watchdog driver I wrote, because the hardware was mapped on I/O port 0xF2
which is within the FPU I/O space :

   00f0-00ff : fpu

I did not know how to correctly fix this problem, and I could live without
the check, but I found it dirty and never proposed it for inclusion.

It's not the first time I notice that write-only hardware share a reserved
I/O range with other components, and I don't know how to cope with this.
Perhaps it sounds logical not to request_region() as the hardware is meant
to be 100% transparent afterall ?

> The see the "Sign your work:" bit of Documentation/SubmittingPatches are
> it looks ready to go in.
> 
> Alan

Willy

