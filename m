Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUIANUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUIANUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUIANUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:20:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55680 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266508AbUIANUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:20:03 -0400
Message-ID: <4135CC6E.3050508@pobox.com>
Date: Wed, 01 Sep 2004 09:19:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE class driver with SATA controllers
References: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> The reason I'm asking is because it would seem like a good thing to have
> SATA controllers that are broadly compatible with IDE to be usable
> without having to modify the core kernel drivers.  This would at least
> allow a user to perform a Linux install on a SATA drive even if that
> kernel doesn't have explicit support for the SATA controller.  A
> kernel/driver update can then take place after the install.
> 
> Also, are there plans for libata to take over the IDE class driver
> functionality in the future?


Once ATAPI is complete, then I will green-light PATA support in libata.

Since libata already supports the standard bmdma stuff, and can even 
work in PIO-only mode without DMA (or even without interrupts, in 100% 
polling mode), it is definitely possible to drive the hardware.

If you want to play, and don't care about lack of ATAPI support (i.e. 
just disks), then it is possible today to do this.  #define 
ATA_FORCE_PIO and play away :)

With regards to libata being the default, making that an _option_ is 
feasible, but we will probably default to the IDE driver for quite some 
time.  There are issues of /dev/hda versus /dev/sda, keeping existing 
user setups working, etc.

	Jeff


