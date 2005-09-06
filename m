Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVIFOkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVIFOkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVIFOkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:40:51 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:9228 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750701AbVIFOkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:40:51 -0400
Date: Tue, 6 Sep 2005 15:40:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: viro@ZenIV.linux.org.uk
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (GEN_RTC dependencies)
In-Reply-To: <20050906022423.GT5155@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.61L.0509061109350.6760@blysk.ds.pg.gda.pl>
References: <20050906005645.GQ5155@ZenIV.linux.org.uk>
 <20050905.185141.44096788.davem@davemloft.net> <20050906022423.GT5155@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:

> >From my reading of that code, GEN_RTC should've been called FAKE_RTC...

 Yep, it's an excuse for platform maintainers not to write proper drivers.

> AFAICS, more or less clean solution would be to split the damn thing
> into frontend (parsing of ioctls, hopefully very few API variants) and
> backend (set of methods for talking to real hardware, or, in this case,
> fake of a hardware).  With at most one backend selectable (i.e. select
> in Kconfig) and frontend available if backend is selected.  With any
> luck we could eventually get frontends down to one; in any case, their
> APIs have no place in include/asm-*
> 
> Note that e.g. fsckloads of MIPS RTC drivers would simply become backends
> in that scheme; lots of duplicated glue would disappear from them...

 Note that a few of MIPS RTC drivers are actually I2C devices that the 
fake code accesses directly bypassing the relevant I2C driver.  That may 
be a justified fallback for the one-off boot-time system clock setup when 
no suitable I2C driver has been built in, but for normal operation that's 
rather miserable.  As I happen to have a suitable system for testing, I 
may have a look at how to interface such drivers to a generic frontend.  
I'm not sure whether in this particular system the RTC chip's interrupt is 
wired though -- probably not -- so I may only leave this part of code to 
be tested by others.

  Maciej
