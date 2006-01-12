Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWALSSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWALSSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWALSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:18:49 -0500
Received: from hera.kernel.org ([140.211.167.34]:28560 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932356AbWALSSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:18:48 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: sk98lin
Date: Thu, 12 Jan 2006 10:18:43 -0800
Organization: OSDL
Message-ID: <20060112101843.0b0e159f@dxpl.pdx.osdl.net>
References: <20060112180048.8A18EBC32@mx.dtiltas.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1137089925 2217 10.8.0.74 (12 Jan 2006 18:18:45 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 12 Jan 2006 18:18:45 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 20:01:43 +0200
Nerijus Baliunas <nerijus@users.sourceforge.net> wrote:

> Hello,
> 
> Why a newer driver (http://www.marvell.com/drivers/upload/install-8_28.tar.bz2,
> it's v8.28.1.3, while kernel has v6.23) is not integrated into kernel?
> Because of no one submitted it or does it have some problems?

It was submitted, but has several problems:
  * wasn't done as small pieces; too much whole sale replacement
  * ignored all the bugfixes and work that went into the mainline kernel
  * merges support for two kinds of hardware in one driver

Also, it increases the amount of vendor ugly code; the sk98lin driver
would probably not be accepted today.

While developing the skge and sky2 driver I discovered more problems and
those got fixed in the mainline sk98lin driver. The vendor version has
issues like:
  * does NAPI but has interrupts disabled
  * has a watchdog routine to mask off all the bugs they never managed
    to fix.
  * sets PCI-express parameters to benchmark values that cause
    random hangs and data corruption

That is why I wouldn't recommend the vendor version for any production
systems.

> Because w/o it some newer cards are not recognized
> (Marvell Technology Group Ltd. 88E8050 Gigabit Ethernet Controller (rev 17)
> for example).
> 
> Regards,
> Nerijus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
