Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbULMEAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbULMEAt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 23:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbULMEAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 23:00:49 -0500
Received: from colo.lackof.org ([198.49.126.79]:61091 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262126AbULMEAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 23:00:39 -0500
Date: Sun, 12 Dec 2004 20:59:36 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: frahm@irsamc.ups-tlse.fr
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org, jgarzik@pobox.org
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
Message-ID: <20041213035936.GB26501@colo.lackof.org>
References: <20041212214803.GB22514@colo.lackof.org> <200412130313.iBD3DAF4004365@albireo.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412130313.iBD3DAF4004365@albireo.free.fr>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 04:13:10AM +0100, frahm@irsamc.ups-tlse.fr wrote:
> I am sorry, I forgot the modification for "i" in the loop and the udelay:

np...I really appreciate you taking the time to run these.

...
> Here is the output of dmesg (I carefully removed the old tulip module and 
> inserted its new version after each recompilation.)
> 
> --- i=2000/10, udelay(10)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

> --- i=4000/10, udelay(10)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

> --- i=1300/50, udelay(50)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

> --- i=4000/50, udelay(50)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

> --- i=1300/100, udelay(100)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

> --- i=4000/100, udelay(100)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
> 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

> There is no modification in the values of CSR5 and CSR6.

yeah. :^(
Rules out those two theories pretty much.

> I suppose this implies a Chip defect which is quite plausible
> since a I have cheap Sitecom card which is perhaps not 100%
> compatible with the tulip-driver ? 

Definitely not compatible.

And as noted in the previous email, I don't advise ifdown the NIC
unless you can verify it will not corrupt the memory that was
previously used for RX descriptors and RX buffers.

OTOH, 100BT cards are *so* cheap, it should be possible to replace
if it's not built-in on the motherboard.

Sorry for the bad news and thanks for doing the extra tests.

But still, I'm hopeing for two code changes as a result:
1) include CSR5 and CSR6 in the printk output
2) the date of the tulip driver revision needs to be updated (or dropped).

thanks,
grant
