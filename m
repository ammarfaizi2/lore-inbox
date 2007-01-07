Return-Path: <linux-kernel-owner+w=401wt.eu-S932464AbXAGJz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbXAGJz5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbXAGJz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:55:56 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:60680 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932464AbXAGJzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:55:55 -0500
Message-ID: <45A0C3A7.2040506@gmail.com>
Date: Sun, 07 Jan 2007 10:55:28 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Sascha Sommer <saschasommer@freenet.de>
Cc: LKML <linux-kernel@vger.kernel.org>, rmk+mmc@arm.linux.org.uk
Subject: Re: Experimental driver for Ricoh Bay1Controller SD Card readers
References: <200701070032.27234.saschasommer@freenet.de>
In-Reply-To: <200701070032.27234.saschasommer@freenet.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Sommer wrote:
> Hi,
> 
> Attached is a very experimental driver for a Ricoh SD Card reader that can be 
> found in some notebooks like the Samsung P35.
> 
> Whenever a sd card is inserted into one of these notebooks, a virtual pcmcia 
> card will show up:
> 
> Socket 0:
>   product info: "RICOH", "Bay1Controller", "", ""
>   manfid: 0x0000, 0x0000
> 
> In order to write this driver I hacked qemu to have access to the cardbus 
> bridge containing this card. I then logged the register accesses of the 
> windows xp driver and tryed to analyse them.
> 
> As the meanings of most of the register are still unknown to me, I consider 
> this driver very experimental. It is possible that this driver might destroy 
> your data or your hardware. Use at your own risk! 
> 
> Other problems:
> - I only implemented reading support
> - I only tested with a 128 MB SD card, no idea what would be needed to support
>   other card types
> - irqs are not supported
> - dma is not supported
> - it is very slow
> - the registers can be found on the cardbus bridge and not on the virtual 
>   pcmcia card. The cardbus bridge is already claimed by yenta_socket. 
>   Therefore the driver currently uses pci_find_device to find the cardbus

- pci_find_device is no go today. Use pci_get_device (+ pci_dev_get, _put).
- ioremap->pci_iomap
- iobase should be __iomem.
- codingstyle (char* buffer, for(loop, if(data){, ...)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
