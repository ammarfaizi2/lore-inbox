Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbUKJXLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUKJXLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUKJXLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:11:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:20434 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262146AbUKJXLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:11:24 -0500
Subject: Re: IT8212 in 2.6.9-ac6 no raid 0 or raid 1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Toole <robert.toole@kuehne-nagel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <419286A2.3060706@kuehne-nagel.com>
References: <418FE1B3.8020203@kuehne-nagel.com>
	 <1099956451.14146.4.camel@localhost.localdomain>
	 <4192308C.3060100@kuehne-nagel.com>
	 <1100110612.20556.6.camel@localhost.localdomain>
	 <419286A2.3060706@kuehne-nagel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100124468.20794.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 22:07:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 21:22, Robert Toole wrote:
> /dev/hde:
>   multcount    =  0 (off)
>   IO_support   =  0 (default 16-bit)
>   unmaskirq    =  0 (off)
>   using_dma    =  0 (off)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
>   readahead    = 256 (on)
>   geometry     = 4998/255/63, sectors = 41110141952, start = 0
> 
> hdparm -d 1 -A 1 -m 16 -u 1 -a 64 /dev/hde
> 
> - it does not like the multicount setting, saying HDIO_SET_MULTCOUNT 

Thats correct - in raid mode the controller emulates an IDE controller
but is doing all the work (its actually hardware raid) and it doesn't
support multisector PIO stuff (not that this matters for DMA). The -u1
and -d1 are the two that matter

> Is there any more info you could use? My lspci, .config is in my first 
> post. This is a pure test box, so I can do pretty much anything you want 
> to it :)

No this makes sense - I need to adjust the fixup handling slightly. I
fix up the IT8212 misreporting of DMA a little too late for the generic
code to decide to turn DMA on.

