Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTA3Nox>; Thu, 30 Jan 2003 08:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbTA3Nox>; Thu, 30 Jan 2003 08:44:53 -0500
Received: from dp.samba.org ([66.70.73.150]:28849 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267505AbTA3Now>;
	Thu, 30 Jan 2003 08:44:52 -0500
Date: Fri, 31 Jan 2003 00:52:15 +1100
From: Anton Blanchard <anton@samba.org>
To: David Brownell <david-b@pacbell.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: pci_set_mwi() ... why isn't it used more?
Message-ID: <20030130135215.GF6028@krispykreme>
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org> <3E2C4FFA.1050603@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2C4FFA.1050603@pacbell.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I suppose the potential for broken PCI devices is exactly why MWI
> isn't automatically enabled when DMA mastering is enabled, though
> I don't understand why the cacheline size doesn't get fixed then
> (unless it's that same issue).  Devices can use the cacheline size
> to get better Memory Read Line/Read Multiple" throughput; setting
> it shouldn't be tied exclusively to enabling MWI.

There are a number of cases where we cant enable MWI either because
the PCI card doesnt support the CPU cacheline size or we have to set the
PCI card cacheline size to something smaller due to various bugs.

eg I understand earlier versions of the e100 dont support a 128 byte
cacheline (and the top bits are read only so setting it up for 128 bytes
will result in it it being set to 0). Not good for read multiple/line
and even worse if we decide to enable MWI :)

Anton
