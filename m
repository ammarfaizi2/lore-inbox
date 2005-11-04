Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVKDUQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVKDUQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVKDUQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:16:23 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:59265 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750901AbVKDUQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:16:22 -0500
From: David Brownell <david-b@pacbell.net>
To: stephen@streetfiresound.com
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Date: Fri, 4 Nov 2005 12:16:20 -0800
User-Agent: KMail/1.7.1
Cc: eemike@gmail.com, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200511031615.22630.david-b@pacbell.net> <1131130365.426.33.camel@localhost.localdomain>
In-Reply-To: <1131130365.426.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041216.20301.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 10:52 am, Stephen Street wrote:
> On Thu, 2005-11-03 at 16:15 -0800, David Brownell wrote:
> > Stephen persuaded me to add controller_data too, which is stored in
> > "struct spi_device".  His PXA SPI controller driver uses that for a
> > structure holding what I'd call DMA tuning information, plus a function
> > that tweaks the GPIO used for a chipselect.  Treat it as readonly.
> > 
> > Controller drivers can have two different kinds of state in each
> > spi_device:  static, and dynamic/runtime.  The names used for them
> > are IMO very confusing (platform_data and controller_data) since
> > they don't mean the same as those names do in board_info.  I'd take
> > a patch to provide better names for those two.  :)
> 
> I agree, the names are bad...  How about modifying struct spi_board_info
> to
> 
> struct spi_board_info {
> ...
> 
> 	void *slave_data;
> 	void *master_data; 

I'd be confused.  They're both slave-specific ... and owned by
the master/controller driver.

Instead, how about "controller_data" changing to match its role
in board_info (static info, not dynamic), and "platform_data"
becoming something like "controller_state"?  

- Dave


> ...
> };
> 
> -Stephen
> 
> 
> 
> 
