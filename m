Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268164AbTAKWkA>; Sat, 11 Jan 2003 17:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTAKWkA>; Sat, 11 Jan 2003 17:40:00 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:12968 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S268164AbTAKWj7>;
	Sat, 11 Jan 2003 17:39:59 -0500
Date: Sat, 11 Jan 2003 23:48:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sl82c105 driver update
Message-ID: <20030111234819.A17524@ucw.cz>
References: <1042302798.525.66.camel@zion.wanadoo.fr> <20030111223231.B21505@flint.arm.linux.org.uk> <1042325055.525.153.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1042325055.525.153.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Sat, Jan 11, 2003 at 11:44:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:44:15PM +0100, Benjamin Herrenschmidt wrote:

> On Sat, 2003-01-11 at 23:32, Russell King wrote:
> > On Sat, Jan 11, 2003 at 05:33:19PM +0100, Benjamin Herrenschmidt wrote:
> > > Enclosed is an update to the sl82c105 driver against 2.4.21-pre3, I'll
> > > produce a 2.5 version once this is accepted by Alan.
> > 
> > Its still broken - if it uses DMA, the ide core will call ide_dma_on,
> > which will call config_for_dma(), which will call ide_config_drive_speed,
> > which will then call ide_dma_on, etc.
> > 
> > Sorry, I don't have a solution off hand for this.  I just wish that
> > the IDE core didn't change in these incompatible ways during a stable
> > kernel release.
> 
> No this problem is not here, at least not in 2.4, I did test it ;)
> 
> ide_config_drive_speed will call ide_dma_host_on, not ide_dma_on. 
> 
> Note that I think sl82c105 and ide-pmac are the only ones to redo the
> DMA config on ide_dma_on. Most chipsets only do it on ide_dma_check, but
> I chosed to do it in ide_dma_on too mostly because I found no way to
> re-trigger ide_dma_check from hdparm (well, this might have changed
> since, I have to dbl check).

Correct, and it seems that if you have automatic DMA disabled in the
kernel and then use hdparm -d1, this leads to a lot of trouble.

-- 
Vojtech Pavlik
SuSE Labs
