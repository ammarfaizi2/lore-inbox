Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932967AbWF3TKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbWF3TKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933095AbWF3TKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:10:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932967AbWF3TKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:10:50 -0400
Date: Fri, 30 Jun 2006 12:10:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alessio Sangalli <alesan@manoweb.com>
cc: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru, dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <449B0B3C.2020904@manoweb.com>
Message-ID: <Pine.LNX.4.64.0606301200400.12404@g5.osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
 <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org> <20060622093606.2b3b1eb7.akpm@osdl.org>
 <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org> <449B0B3C.2020904@manoweb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Alessio Sangalli wrote:
> 
> # /sbin/lspci -vvx
> 00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
>         Subsystem: Compaq Computer Corporation: Unknown device 000d
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 64
> 00: 86 80 94 71 06 00 00 22 01 00 00 06 00 40 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Ok. We don't actually have any quirks at all for the 82440MX, and that's 
almost certainly _not_ because it doesn't do something strange (all Intel 
host bridges have magic IO ranges), but simply because we haven't hit it 
yet.

And I can't find the docs for the PCI config space for that dang thing.

I bet that there's some magic SMBus IO-range that the 440MX decodes using 
a special magic config setting.

Has anybody found the config space docs for the 82440MX? 

		Linus
