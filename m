Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWASSs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWASSs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWASSs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:48:59 -0500
Received: from hera.kernel.org ([140.211.167.34]:13235 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161199AbWASSs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:48:58 -0500
Date: Thu, 19 Jan 2006 14:48:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kumar Gala <galak@gate.crashing.org>, Andrew Morton <akpm@osdl.org>,
       wim@iguana.be, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Message-ID: <20060119164811.GB4418@dmt.cnet>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org> <1137664156.8471.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137664156.8471.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 09:49:16AM +0000, Alan Cox wrote:
> On Iau, 2006-01-19 at 00:58 -0600, Kumar Gala wrote:
> > Since we can only open the watchdog once having a spinlock to protect
> > multiple access is pointless.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> NAK
> 
> This is a common mistake.
> 
> open is called on the open() call and is indeed in this case 'single
> open', but file handles can be inherited and many users may have access
> to a single file handle.
> 
> eg
> 
> 	f = open("/dev/watchdog", O_RDWR);
> 	fork();
> 	while(1) {
> 		write(f, "Boing", 5);
> 	}

Oops.

At least 50% of the watchdog drivers rely solely on the "wdt_is_open"
atomic variable and are broken with respect to synchronization.
