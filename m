Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSLKQH7>; Wed, 11 Dec 2002 11:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSLKQH7>; Wed, 11 Dec 2002 11:07:59 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:57282
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267200AbSLKQH6>; Wed, 11 Dec 2002 11:07:58 -0500
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fedor Karpelevitch <fedor@apache.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>,
       alsa-devel@lists.sourceforge.net,
       Debian-Laptops <debian-laptop@lists.debian.org>
In-Reply-To: <200212110715.20617.fedor@apache.org>
References: <200212110715.20617.fedor@apache.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 16:48:18 +0000
Message-Id: <1039625298.18087.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 15:15, Fedor Karpelevitch wrote:
> I have ALi M5451 souncard in my laptop (Compaq Presario 900z for those 
> searching) and it hangs the machine with any kernel I tried 
> (currently 2.4.20-ac1 + hirofumi patch). I traced it down to the line 
> where it hangs - that is drivers/sound/trident.c:3379 which says:
> pci_write_config_byte(pci_dev, 0xB8, ~temp);

Looking at the docs it looks like the code Matt Wu added may have 
been meant to do

	pci_read_config_byte(pci_dev, 0x59, temp)
	temp &= ~0x80
	pci_write...

and similarly for the other port

(Ditto with fixing setup_multi_cannnels)

Does it work sanely with those fixd ?

