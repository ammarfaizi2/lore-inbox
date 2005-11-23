Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVKWS5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVKWS5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVKWS5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:57:42 -0500
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:14596 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932175AbVKWS5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:57:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] 2.6.14.2  Support for 1K I/O space granularity on the Intel P64H2
Date: Wed, 23 Nov 2005 13:57:36 -0500
Message-ID: <94C8C9E8B25F564F95185BDA64AB05F6028E120C@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.14.2  Support for 1K I/O space granularity on the Intel P64H2
Thread-Index: AcXwWq5obGxyb4O6SqmDYN5Sq17hjgABHgMQ
From: "Yeisley, Dan P." <dan.yeisley@unisys.com>
To: "Greg KH" <gregkh@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Nov 2005 18:57:37.0718 (UTC) FILETIME=[C5923560:01C5F05F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with implementing this with a quirk is this line:
	res->end = limit + 0xfff;

That hard coded value of 0xfff is the problem.  I suppose I could make
it a variable and initialize it to 0xfff and then set it to 0x3ff in the
quirk.

I'll take a look at doing it that way (and try to fix my line wrap
problem).

Thanks,
Dan


-----Original Message-----
From: Greg KH [mailto:gregkh@suse.de] 
Sent: Wednesday, November 23, 2005 13:18
To: Yeisley, Dan P.
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14.2 Support for 1K I/O space granularity on
the Intel P64H2

On Wed, Nov 23, 2005 at 01:02:52PM -0500, Yeisley, Dan P. wrote:
> The Intel P64H2 PCI bridge has the ability to allocate I/O space with
> 1KB granularity.  I've written a patch against 2.6.14.2 to take
> advantage of this option.  I've tested it on the latest Unisys
> ES7000-600.  

Shouldn't this be made into a pci quirk somehow?

> linux-2.6.14.2-en1k/drivers/pci/probe.c
> --- linux-2.6.14.2/drivers/pci/probe.c	2005-11-11
00:33:12.000000000
> -0500

Your patch is linewrapped and can't be applied :(

thanks,

greg k-h
