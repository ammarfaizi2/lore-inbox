Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUHSNOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUHSNOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUHSNOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:14:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20697 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266073AbUHSNOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:14:37 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: serialize access to ide device
Date: Thu, 19 Aug 2004 15:14:13 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040802131150.GR10496@suse.de>
In-Reply-To: <20040802131150.GR10496@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191514.13022.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 15:11, Jens Axboe wrote:
> Hi Bart,

Hi,

Late reply follows...

> 2.6 breaks really really easily if you have any traffic on a device and
> issue a hdparm (or similar) command to it. Things like set_using_dma()
> and ide_set_xfer_rate() just stomp all over the drive regardless of what
> it's doing right now.

Yep, known problem.

> I hacked something up for the SUSE kernel to fix this _almost_, it still
> doesn't handle cases where you want to serialize across more than a
> single channel. Not a common case, but I think there is such hardware
> out there (which?).
>
> Clearly something needs to be done about this, it's extremely
> frustrating not to be able to reliably turn on dma on a drive at all.
> I'm just tossing this one out there to solve 99% of the case, I'd like
> some input from you on what you feel we should do.

What about adding new kind of REQ_SPECIAL request and converting 
set_using_dma(), set_xfer_rate(), ..., to be callback functions for this 
request?

This should be a lot cleaner and will cover 100% cases.

Bartlomiej
