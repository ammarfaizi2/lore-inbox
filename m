Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUCCPWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUCCPUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:20:43 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:31711 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262479AbUCCPUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:20:22 -0500
Date: Wed, 3 Mar 2004 08:20:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040303152020.GR20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net> <40451CCA.4070907@mvista.com> <20040302235238.GN20227@smtp.west.cox.net> <4045287B.9000304@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4045287B.9000304@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 04:36:11PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >Regardless, it's not that we offer (nor does the -mm version, from what
> >I read of it) eth or serial at any point, it simply allows for serial to
> >be used and a switchover to eth.  And if kgdb is attached at the time,
> >it's a 'fun' gdb session (or at least is was when I was trying it out in
> >-mm and then in my own version).
> 
> I am not really suggesting a live switch capability, more like something 
> that is set a boot time.

That's still not, AFAICT, what's offered in -mm or kgdb.sf.net.

> >The real problem is that you start getting quite complex when you allow
> >for a system to be kgdb eth, or 8250, or some arch serial driver, or
> >some other I/O driver, and so on.  PPC has 3, and I don't see it getting
> >smaller from there.
> 
> I had imagined that it would be rather like a file system.  The stub would 
> pass (or it could be a global if you prefer) the index to use into an array 
> of interface structures.  Something like:
> 
> struct kgdb_interface {
> 	void (*kgdb_in)(*char)
> 	:
> 	:
> }
> 
> struct kgdb_interface kgdb_io_array[N];

And how do you pick a default?

> >And with both of those points, I don't think it's worth the trouble that
> >point 2 is, given the limitations of point 1.
> 
> I imagine that I would like this.  I would use the eth interface until 
> required to use the serial.  I would rather not have to rebuild the kernel 
> to do this....

Then you're talking about live switching again, or some sort of control
from userland.

-- 
Tom Rini
http://gate.crashing.org/~trini/
