Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268161AbTAKWfM>; Sat, 11 Jan 2003 17:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268162AbTAKWfM>; Sat, 11 Jan 2003 17:35:12 -0500
Received: from AMarseille-201-1-3-87.abo.wanadoo.fr ([193.253.250.87]:12144
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268161AbTAKWfK>; Sat, 11 Jan 2003 17:35:10 -0500
Subject: Re: [PATCH] sl82c105 driver update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20030111223231.B21505@flint.arm.linux.org.uk>
References: <1042302798.525.66.camel@zion.wanadoo.fr>
	 <20030111223231.B21505@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042325055.525.153.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Jan 2003 23:44:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 23:32, Russell King wrote:
> On Sat, Jan 11, 2003 at 05:33:19PM +0100, Benjamin Herrenschmidt wrote:
> > Enclosed is an update to the sl82c105 driver against 2.4.21-pre3, I'll
> > produce a 2.5 version once this is accepted by Alan.
> 
> Its still broken - if it uses DMA, the ide core will call ide_dma_on,
> which will call config_for_dma(), which will call ide_config_drive_speed,
> which will then call ide_dma_on, etc.
> 
> Sorry, I don't have a solution off hand for this.  I just wish that
> the IDE core didn't change in these incompatible ways during a stable
> kernel release.

No this problem is not here, at least not in 2.4, I did test it ;)

ide_config_drive_speed will call ide_dma_host_on, not ide_dma_on. 

Note that I think sl82c105 and ide-pmac are the only ones to redo the
DMA config on ide_dma_on. Most chipsets only do it on ide_dma_check, but
I chosed to do it in ide_dma_on too mostly because I found no way to
re-trigger ide_dma_check from hdparm (well, this might have changed
since, I have to dbl check).

Ben.

