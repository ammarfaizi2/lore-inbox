Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263438AbUJ3BnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbUJ3BnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbUJ3Bij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:38:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8381 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263466AbUJ2Ti2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:38:28 -0400
Date: Fri, 29 Oct 2004 20:38:27 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: net: generic netdev_ioaddr
Message-ID: <20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
References: <1099044244.9566.0.camel@localhost> <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk> <courier.418290EC.00002E85@courier.cs.helsinki.fi> <m3y8hpbaf9.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3y8hpbaf9.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 09:18:18PM +0200, Krzysztof Halasa wrote:
> "Pekka J Enberg" <penberg@cs.helsinki.fi> writes:
> 
> > Yup, I thought about that after I sent the patch. However, as it
> > stands now, many network drivers use netdev->base_addr for just that.
> > Perhaps it should be nuked completely instead?
> 
> I thinks so. With ifmap, SIOCSIFMAP, ifr_map, mem_end etc.,
> irq, if_port, dma.

SIOCSIFMAP is unfortunate, but legitimate - it passes more or less
opaque structure to driver and lets driver interpret it.

SIOCGIFMAP, OTOH, is really bad - among other things, for many drivers
it leaks ioremapped addresses to userland.  And *that* is a LARTable
offense - it's an information that makes no sense whatsoever for userland
code and should never be exposed, just as with any kernel pointers.

What uses ->base_addr from the data returned by SIOCGIFMAP?
