Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUJIVjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUJIVjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUJIVjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:39:06 -0400
Received: from gw.anda.ru ([212.57.164.72]:39434 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S267450AbUJIVif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:38:35 -0400
Date: Sun, 10 Oct 2004 03:38:20 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] Something wrong with ISAPnP and serial driver
Message-ID: <20041010033820.B30047@natasha.ward.six>
Mail-Followup-To: Rene Herman <rene.herman@keyaccess.nl>,
	linux-kernel@vger.kernel.org
References: <20041010015206.A30047@natasha.ward.six> <4168479C.5080306@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4168479C.5080306@keyaccess.nl>; from rene.herman@keyaccess.nl on Sat, Oct 09, 2004 at 10:18:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 10:18:36PM +0200, Rene Herman wrote:
> Denis Zaitsev wrote:
> 
> > 1) The 2.6 kernel doesn't activate the ISA PnP modem at the boot,
> >    while the 2.4 one always does.
> 
> 2.4 used to scan the ISA PnP device ID string for some common substrings 
> indicating a modem given a completely unknown ISA PnP device (the code 
> is still present -- see drivers/serial/8250_pnp.c:check_name()) while 
> 2.6 really needs your modem's PnP ID to be listed.
> 
> > 2) The 8250 driver finds the PnP card's port, while the 8250_pnp finds
> >    the non-PnP ports.
> 
> 8250_pnp not finding it is therefore very likely a simple matter of it 
> not knowing that it should be driving it. Try seeing if your modem's PnP 
> ID (/sys/bus/pnp/devices/?/id) is listed in drivers/serial/8250_pnp.c 
> and if not add it (and send as a patch to Russel King).

Ok, it isn't listed (USR0009).  I'll send a patch.  BTW, there is some
other ID - /sys/devices/pnp1/01:01/card_id - and it contains USR0101.
What's this?

> 8250 itself finding it was no doubt due to you enabling the port 
> yourself so that from its standpoint, it was just another serial port 
> already present.

But why doesn't it find the two standard mb-embedded ports?  And why
they are found by 8250_pnp?  Is it a normal behaviour?

> With your modem's ID added, 8250_pnp should find and activate the
> mdem itself without you needing to do anything other than "modprobe
> 8250_pnp"

Ok.  I' trying.  The kernel is compiling...

> Hope that helps.

Thanks.  But what about the incorrect info in /proc/tty/driver/serial?
