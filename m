Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWGIQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWGIQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWGIQ31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:29:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:185 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751323AbWGIQ30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:29:26 -0400
Message-ID: <44B12ED6.10000@garzik.org>
Date: Sun, 09 Jul 2006 12:29:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       rdunlap@xenotime.net, greg@kroah.com, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@muc.de>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>	 <44B0E6E6.6070904@reub.net>  <20060709052252.8c95202a.akpm@osdl.org> <1152449805.27368.57.camel@localhost.localdomain>
In-Reply-To: <1152449805.27368.57.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The old drivers/ide code uses much longer delays than the spec for some
> ATAPI commands, and it looks as if there is a good reason for doing
> so ...


FWIW, the code that ATADRVR (http://www.ata-atapi.com/) uses to issue 
commands does something like

	write Command register to start command
	if (device == ATAPI)			# i.e. not ATA
		delay(150 msec)
	pound Status / AltStatus, kick DMA engine, whatever else

ATADRVR is open code (for an MS-DOS-level driver), and really worth a 
read.  Between ATADRVR and drivers/ide, you get a pretty good idea about 
what __field experience__ has shown is needed for ATAPI devices.

	Jeff



