Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbSLECdO>; Wed, 4 Dec 2002 21:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSLECdN>; Wed, 4 Dec 2002 21:33:13 -0500
Received: from dp.samba.org ([66.70.73.150]:29909 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267189AbSLECdL>;
	Wed, 4 Dec 2002 21:33:11 -0500
Date: Thu, 5 Dec 2002 13:40:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: jgarzik@pobox.com, davem@redhat.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205024039.GB1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, jgarzik@pobox.com,
	davem@redhat.com, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212050121.RAA03254@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212050121.RAA03254@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 05:21:04PM -0800, Adam J. Richter wrote:
> David Gibson wrote:
> >On Wed, Dec 04, 2002 at 11:47:14AM -0600, James Bottomley wrote:
> [...]
> >> The new DMA API allows a driver to advertise its level of consistent memory 
> >> compliance to dma_alloc_consistent.  There are essentially two levels:
> >> 
> >> - I only work with consistent memory, fail if I cannot get it, or
> >> - I can work with inconsistent memory, try consistent first but return 
> >> inconsistent if it's not available.
> >
> >Do you have an example of where the second option is useful?
> 
> 	From a previous discussion, I understand that there are some
> PCI bus parisc machines without consistent memory.

And there are PPCs without consistent memory, except by disabling
cache.

> >Off hand
> >the only places I can think of where you'd use a consistent_alloc()
> >rather than map_single() and friends is in cases where the hardware's
> >behaviour means you absolutely positively have to have consistent
> >memory.
> 
> 	That would result in big rarely used branches in device
> drivers or lots of ifdef's and the equivalent.  With James's approach,
> porting a driver to support those parisc machines (for example) would
> involve sprinkling in some calls to macros that would compile to
> nothing on the other machines.
> 
> 	Compare the code clutter involved in allowing those
> inconsistent parisc machines to run, say, the ten most popular
> ethernet controllers and the four most popular scsi controllers.  I
> think the difference in the resulting source code size would already
> be in the hundreds of lines.

For cases like this, I'm talking about replacing the
consistent_alloc() with a kmalloc(), then using the cache flush
macros.  Is there any machine for which this is not sufficient?

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
