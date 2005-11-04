Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVKDXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVKDXKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVKDXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:10:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40205 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750933AbVKDXKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:10:54 -0500
Date: Fri, 4 Nov 2005 23:10:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Message-ID: <20051104231048.GD12026@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, bzolnier@gmail.com
References: <1131029686.18848.48.camel@localhost.localdomain> <20051103144830.GF28038@flint.arm.linux.org.uk> <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com> <m3oe51zc2e.fsf@defiant.localdomain> <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com> <1131058464.18848.94.camel@localhost.localdomain> <20051104013054.GF3469@ime.usp.br> <1131111667.26925.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131111667.26925.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:41:06PM +0000, Alan Cox wrote:
> While writing the new sl82c05 driver I noticed a real nasty lurking in
> the old code. According to the errata docs you have to reset the DMA
> engine every transfer to work around chip errata. It also says that this
> resets any other ATA transfer in progress.
> 
> If both channels are in use there is no locking between the channels to
> stop a reset on one channel as DMA begins making a mess of the other
> channel. Looks like serialize should be set on the driver ?

Possibly, though benh needs to comment.  (I think benh has the only
hardware which has the possibility of both channels - the NetWinder
only has one channel with one disk.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
