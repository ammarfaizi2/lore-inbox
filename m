Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUBPCit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUBPCit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:38:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:33183 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265310AbUBPCis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:38:48 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jdow <jdow@earthlink.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <124101c3f435$9a66d3a0$1225a8c0@kittycat>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <200402152357.25751.earny@net4u.de> <1076886481.6960.121.camel@gaston>
	 <200402160033.43438.earny@net4u.de> <1076889243.11392.130.camel@gaston>
	 <124101c3f435$9a66d3a0$1225a8c0@kittycat>
Content-Type: text/plain
Message-Id: <1076899019.6958.168.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 13:37:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 13:35, jdow wrote:

> > - do_div(vclk, 1000);
> > - xtal = (xtal * denom) / num;
> > + vclk *= denom;
> > + do_div(vclk, 1000 * num);
> > + xtal = vclk;
> >
> >   if ((xtal > 26900) && (xtal < 27100))
> >   xtal = 2700;
>            ^^^^
> 
> Is that right or a typo for 27100?

No, it's right. Weird but right :)

Look at the whole thing

	if ((xtal > 26900) && (xtal < 27100))
		xtal = 2700;
	else if ((xtal > 14200) && (xtal < 14400))
		xtal = 1432;
	else if ((xtal > 29400) && (xtal < 29600))
		xtal = 2950;
	else {
		printk(KERN_WARNING "xtal calculation failed: %ld\n", xtal);
		return -1;
	}

Ohhh, and I know it's ugly, it comes straight from XFree through.

Don't bother too much with that code, I'm not even sure it works
properly at this point, I need to test it by intentionally disabling
the BIOS detection to check it actually picks the right values.

Ben.

