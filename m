Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUHUTZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUHUTZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUHUTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:25:40 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:41614 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267685AbUHUTZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:25:27 -0400
Subject: Re: 2.6.8.1-mm3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040821191417.GA3402@beaverton.ibm.com>
References: <200408211838.i7LIcUdl025108@harpo.it.uu.se> 
	<20040821191417.GA3402@beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 21 Aug 2004 15:24:56 -0400
Message-Id: <1093116298.2092.388.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 15:14, Patrick Mansfield wrote:
> Looks like it will be hit for any scsi removable media, the removable
> media check in sd.c sd_media_changed() uses SCSI_IOCTL_TEST_UNIT_READY.

Yes, I'm in two minds about this one.

Either we could provide a helper routine to do it and convert all the
internal uses over, or we could define a new ioctl that is correctly
unique, something like

#define SCSI_TEST_UNIT_READY	_IOR('S', 8, int)
or perhaps just 0x5388

and convert the internal users over to it.

Opinions?

James


