Return-Path: <linux-kernel-owner+w=401wt.eu-S1750960AbXACRBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbXACRBS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbXACRBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:01:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35331 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbXACRBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:01:16 -0500
Subject: Re: [PATCH] quiet MMCONFIG related printks
From: Arjan van de Ven <arjan@infradead.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200701030849.33205.jbarnes@virtuousgeek.org>
References: <200701012101.38427.jbarnes@virtuousgeek.org>
	 <1167832386.3095.20.camel@laptopd505.fenrus.org>
	 <200701030849.33205.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 03 Jan 2007 09:01:13 -0800
Message-Id: <1167843673.3127.162.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 08:49 -0800, Jesse Barnes wrote:
> On Wednesday, January 3, 2007 5:53 am, Arjan van de Ven wrote:
> > On Mon, 2007-01-01 at 21:01 -0800, Jesse Barnes wrote:
> > > Using MMCONFIG for PCI config space access is simply an
> > > optimization, not a requirement.  Therefore, when it can't be used,
> > > there's no need for KERN_ERR level message.  This patch makes the
> > > message a KERN_INFO instead to reduce some of the noise in a kernel
> > > boot with the 'quiet' option. (Note that this has no effect on a
> > > normal boot, which is ridiculously verbose these days.)
> >
> > this is wrong, please leave this loud complaint in...
> 
> So the issues as I understand them:
>   o some BIOSes are broken and don't properly map MCFG space (though
>     according to Petr V. reserving MCFG space in e820 is optional, so
>     the test may be slightly wrong as-is)

it's optional but it's the best test we have for "is the bios total
crap" ;(

>   o MCFG space is required for (many) PCIe devices (any regular PCI
>     devices?)

it's not required for *many* (it can't be, windows XP doesn't use MCFG),
but it's required for some of the advanced PCI-E features

>   o often, there's nothing the user can do to address the points above

other than complain to the vendor.

> 
> So where does that leave us?  I've got what I consider to be a stupid 
> error message in my log.

contact your bios vendor.

>   My system behavior isn't affected in any way 
> (at least that I can tell), yet I get a loud complaint at boot time.
> 
> I guess I just have to live with it?

We really really should complain about bios issues. If only to make sure
vendors who do pay attention to linux have a chance of finding and
fixing them (and via the firmware kit, several big vendors pay attention
early on nowadays)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

