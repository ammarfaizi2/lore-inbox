Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTI0MQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 08:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTI0MQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 08:16:03 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:27654 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262427AbTI0MP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 08:15:59 -0400
Date: Sat, 27 Sep 2003 13:15:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] helper for device list traversal
Message-ID: <20030927131558.A22592@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200309270508.h8R58tHE015032@hera.kernel.org> <Pine.GSO.4.21.0309271330460.6768-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0309271330460.6768-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sat, Sep 27, 2003 at 01:34:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 01:34:15PM +0200, Geert Uytterhoeven wrote:
> On Thu, 25 Sep 2003, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1217.10.16, 2003/09/25 12:10:17-05:00, hch@lst.de
> > 
> > 	[PATCH] helper for device list traversal
> > 	
> > 	This patch adds shost_for_each_device().  It's used to abstract out
> > 	scsi_host.my_devices traversal.  The next step will be to replace
> > 	the current simple implementation with one that's fully locked down
> > 	an reference counted.
> 
> Is this what we should use to fix the currently broken list traversal[*] in
> drivers/scsi/{a2091,gvp11,53c7xx}.c?
> 
> Currently ut uses
> 
>     struct Scsi_Host *instance;
>     for (instance = first_instance; instance &&
> 	 instance->hostt == xxx_template; instance = instance->next)
> 
> bust Scsi_Host.next was removed a while ago...

Urgg.  This is totally hosed.  The drivers should be fixed up to
pass the right host to request_irq and the only handle the right
one in the isr instead of walking a lits of all hosts of that template..

