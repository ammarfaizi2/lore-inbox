Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUHSNeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUHSNeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUHSNen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:34:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11907 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266136AbUHSNef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:34:35 -0400
Subject: Re: serialize access to ide device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408191514.13022.bzolnier@elka.pw.edu.pl>
References: <20040802131150.GR10496@suse.de>
	 <200408191514.13022.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092918716.28141.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 13:32:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 14:14, Bartlomiej Zolnierkiewicz wrote:
> What about adding new kind of REQ_SPECIAL request and converting 
> set_using_dma(), set_xfer_rate(), ..., to be callback functions for this 
> request?

Definitely the right direction but it doesn't ultimately fix the bigger
problem which is that in some cases you need to issue multiple commands
in order to set up the drive and cannot do that in one sequence if the
drive is active. This could also be done with some kind of ATA_IO SG_IO
like functionality for the most part (the drive side).

The reset() logic also has the same problem when it occurs from process
context. The newer 2.4 code in 2.6 as well is only a bandaid that
normally works.

Serialization is indeed needed for some controllers (CMD64x in some
cases, RZ1000 and others). Certain controllers have drive pair
constraints and in some cases BIOSes know a lot about DMA suitability of
their configurations. Thats more an argument that using hdparm -d1 at
random is playing with fire.

Alan

