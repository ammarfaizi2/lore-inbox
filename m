Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWKWBtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWKWBtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWKWBtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:49:04 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:40875 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id S932313AbWKWBtB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:49:01 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 23 Nov 2006 02:48:48 +0100
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: David Brownell <david-b@pacbell.net>, akpm@osdl.org,
       hackers@lists.ntp.isc.org, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       paulus@samba.org, rmk@arm.linux.org.uk, Kim@ozlabs.org,
       davem@davemloft.net, kkojima@rr.iij4u.or.jp, mills@udel.edu
Subject: Re: NTP time sync
Message-ID: <20061123014848.GA8675@iram.es>
References: <20061122203633.611acaa8@inspiron> <200611221155.26686.david-b@pacbell.net> <20061122212355.046de470@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061122212355.046de470@inspiron>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 09:23:55PM +0100, Alessandro Zummo wrote:
> On Wed, 22 Nov 2006 11:55:23 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > > 
> > >  So, if the arch maintainers agree, 
> > >  I would suggest to schedule it for removal.
> > > 
> > > [1] http://lkml.org/lkml/2006/3/28/358
> > 
> > Suggested time of removal: one year after two relevant software
> > package releases get updated:
> > 
> >   - NTPD, to call hwclock specifying the relevant RTC;
> 
>  This might introduce delays. ntpd might open the device
>  and update the time itself.
> 

Indeed, the update should be at least _triggered_ by ntp.

In the end it will be the kernel that accesses the hardware,
the fundamental problem is that with RTC chips with very slow 
access like I2C it cannot be done from an interrupt.

But it nevertheless has to be done as close as possible
to the half-second or second boundary (depending on the chip) 
boundary if we want to keep some precision. You can't expect 
miracles from RTC chips in this respect, since the crystal
period is about 30µs to boot and from some tests I did a long
time ago it seems that most do not reset the first bits of
the divider when written to, so the precision is much worse
(something like 30ms IIRC). It is still much better than 1
second in any case.

How can ntp know if the RTC chip has to be updated at the 
half-second or second boundary? That is the kind of knowledge
that is better left to the driver.

	Regards,
	Gabriel
