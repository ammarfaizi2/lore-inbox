Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbTATSwy>; Mon, 20 Jan 2003 13:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTATSwx>; Mon, 20 Jan 2003 13:52:53 -0500
Received: from havoc.daloft.com ([64.213.145.173]:33691 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266682AbTATSv4>;
	Mon, 20 Jan 2003 13:51:56 -0500
Date: Mon, 20 Jan 2003 14:00:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_set_mwi() ... why isn't it used more?
Message-ID: <20030120190055.GA4940@gtf.org>
References: <3E2C42DF.1010006@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2C42DF.1010006@pacbell.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 10:41:35AM -0800, David Brownell wrote:
> I was looking at some new hardware and noticed that it's
> got explicit support for the PCI Memory Write and Invalidate
> command ... enabled (in part) under Linux by pci_set_mwi().
> 
> However, very few Linux drivers use that routine.  Given
> that it can lead to improved performance, and that devices
> don't have to implement that enable bit, I'm curious what
> the story is...
> 
>  - Just laziness or lack-of-education on the part of
>    driver writers?
> 
>  - Iffy upport in motherboard chipsets or CPUs?  If so,
>    which ones?
> 
>  - Flakey support in PCI devices, so that enabling it
>    leads to trouble?
> 
>  - Something else?
> 
>  - Combination of all the above?

You missed the reason entirely ;-)

pci_set_mwi() is brand new, I just added it.  Hasn't filtered down to
drivers yet.  The few drivers that cared prior to its addition, like
drivers/net/acenic.c, just hand-coded the workarounds needed for proper
MWI support on all chipsets.

pci_set_mwi() would not exist at all, were it not for the existing
hardware quirks.  (if hardware were sane, drivers would just
individually twiddle the _INVALIDATE bit in PCI_COMMAND, and never call
functions other than pci_{read,write}_config_word.

	Jeff



