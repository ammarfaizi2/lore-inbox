Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVA0TZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVA0TZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVA0TZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:25:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32266 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262624AbVA0TZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:25:12 -0500
Date: Thu, 27 Jan 2005 19:25:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Phil Oester <kernel@linuxace.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050127192504.D3036@flint.arm.linux.org.uk>
Mail-Followup-To: Phil Oester <kernel@linuxace.com>,
	Robert Olsson <Robert.Olsson@data.slu.se>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, alexn@dsv.su.se,
	kas@fi.muni.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127183745.GA13365@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050127183745.GA13365@linuxace.com>; from kernel@linuxace.com on Thu, Jan 27, 2005 at 10:37:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:37:45AM -0800, Phil Oester wrote:
> On Thu, Jan 27, 2005 at 04:49:18PM +0000, Russell King wrote:
> > so obviously the GC does appear to be working - as can be seen from the
> > number of entries in /proc/net/rt_cache.  However, the number of objects
> > in the slab cache does grow day on day.  About 4 days ago, it was only
> > about 600 active objects.  Now it's more than twice that, and it'll
> > continue increasing until it hits 8192, where upon it's game over.
> 
> I can confirm the behavior you are seeing -- does seem to be a leak
> somewhere.  Below from a heavily used gateway with 26 days uptime:
> 
> # wc -l /proc/net/rt_cache ; grep ip_dst /proc/slabinfo
>   12870 /proc/net/rt_cache
> ip_dst_cache       53327  57855
> 
> Eventually I get the dst_cache overflow errors and have to reboot.

Can you provide some details, eg kernel configuration, loaded modules
and a brief overview of any netfilter modules you may be using.

Maybe we can work out what's common between our setups.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
