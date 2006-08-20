Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWHTKEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWHTKEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWHTKEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:04:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:50420 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750701AbWHTKEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:04:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Date: Sun, 20 Aug 2006 12:03:14 +0200
User-Agent: KMail/1.9.1
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       ens Osterkamp <Jens.Osterkamp@de.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <200608190109.15129.arnd@arndb.de> <1156055509.5803.77.camel@localhost.localdomain>
In-Reply-To: <1156055509.5803.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201203.15645.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 08:31, Benjamin Herrenschmidt wrote:
> > card->low_watermark->next->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
> > mb();
> > card->low_watermark->dmac_cmd_status &= ~SPIDER_NET_DESCR_TXDESFLG;
> > card->low_watermark = card->low_watermark->next;
> > 
> > when we queue another frame for TX.
> 
> I would have expected those to be racy vs. the hardware... what if the
> hardware is updating dmac_cmd_status just as your are trying to and the
> bit out of it ?

Right, that doesn't work. It is the only bit we use in that byte though,
so maybe it can be done with a single byte write.

	Arnd <><
