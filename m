Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUB0Kpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUB0Kpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:45:46 -0500
Received: from barclay.balt.net ([195.14.162.78]:48235 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S261754AbUB0Kpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:45:43 -0500
Date: Fri, 27 Feb 2004 12:45:28 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
Message-ID: <20040227104528.GB31552@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <1077863238.2522.6.camel@damai.telkomsel.co.id> <1077865490.22215.217.camel@gaston> <1077876373.843.3.camel@damai.telkomsel.co.id> <1077875802.22215.267.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077875802.22215.267.camel@gaston>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 08:56:42PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2004-02-27 at 21:06, arief# wrote:
> > Dear all.
> > 
> > 
> > This patch from Benjamin solved my problem.
> > 
> > To Zilvinas <zilvinas@gemtek.lt>, I've tried your suggestion to change
> > my XF86Config-4 file to include UseFBDev line. But it doesnt work. It
> > made my Xserver wont even start. But I'm not sure, it could be X problem
> > (Debian Unstable got some updated X package that I haven't got a chance
> > to upgrade to).
> 
> There is a problem with recent radeonfb's an X + UseFBDev. I think the
> problem is that XFree is claiming a mode whose virtual resolution is very
> large. I have to verify that (it works for me here). Radeonfb has
> limitations on what it allows on the virtual resolution in recent
> version to limit the ioremap'ing done in the kernel. Unfortunately,
> there is no simple way to "detach" one from the other at this point. 
> 
> I should modify radeonfb to crop the virtual resolution instead of
> failing though...
> 
> Can you try hacking in drivers/video/aty/radeon_base.c, function
> check_mode() and see why it fails ? (I think it's that function
> that is failing).

Not sure what was failing on Arief# laptop, here it works perfectly
fine. Hardware: Compaq EVO N800v, kernel 2.6.3 , frambuffer and 
UseFBDev "true" just fine. 

Without UseFBDev console had almost the same effects Arief has reported.
After "clear screen" ^L in console with X running in background, I see a
lot of artifacts ... UseFBDev made it go away.

BR

> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
