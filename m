Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTJXTJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTJXTJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:09:34 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:12550 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262491AbTJXTJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:09:34 -0400
Date: Fri, 24 Oct 2003 23:08:30 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031024230830.A2362@jurassic.park.msu.ru>
References: <3F987E18.9080606@pobox.com> <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org> <20031024165718.GA4972@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031024165718.GA4972@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Fri, Oct 24, 2003 at 06:57:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 06:57:18PM +0200, Petr Vandrovec wrote:
> We need something more sophisticated. Matrox's hardware has bits
> 31-16 readable/writable only if bit 0 is set to 1 (ROM enabled; you can
> (obviously) set bits 31-16 & 0 in one write). When ROM is disabled, 
> bits 31-1 are always read as 0.

Hmm, I believe it's not true at least for Mystique, Millennium II
and G400. Otherwise we wouldn't be able to determine ROM size/alignment
as we do probe with ROM disabled (probe.c, line 125):

		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
		pci_read_config_dword(dev, rom, &sz);


Ivan.
