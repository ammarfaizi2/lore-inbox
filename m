Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266736AbUFRSzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266736AbUFRSzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUFRSx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:53:26 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:50818 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266353AbUFRSwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:52:51 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <20040618193544.48b88771.spyro@f2s.com>
References: <1087582845.1752.107.camel@mulgrave> 
	<20040618193544.48b88771.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 13:52:46 -0500
Message-Id: <1087584769.2134.119.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 13:35, Ian Molton wrote:
> Thats all well and good for devices which have their own drivers, but
> thats not the case always.
> 
> the device I described is an OHCI controller, and in theory, it should
> be able to use the OHCI driver in the kernel without any modification,
> *as long as* the DMA API returns valid device and virtual addresses,
> which, at present, it does not.

Yes, this sounds similar to the Q720 problem.  I wanted to use the
generic ncr53c8xx driver (being lazy) but I wanted to persuade the
driver to use my onboard memory.  This sounds like your issue because
the ncr driver has been sliced apart to become simply a chip driver and
I supply a small skeleton NCR_Q720.c to glue it on to the bus.

You still haven't explained what you want to do though.  Apart from the
occasional brush with usbstorage, I don't have a good knowledge of the
layout of the USB drivers.  I assume you simply want to persuade the
ohci driver to use your memory area somehow, but what do you actually
want the ohci driver to do with it?  And how much leeway do you get to
customise the driver.

The reason I'm asking is beause it's still unclear whether this is a DMA
API issue or an ohci one.  I could solve my Q720 issue simply by
exporting an interface from the ncr driver to supply alternative memory
allocation use and descriptors.

James


