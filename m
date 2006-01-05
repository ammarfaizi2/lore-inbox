Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWAESDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWAESDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWAESDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:03:12 -0500
Received: from webapps.arcom.com ([194.200.159.168]:14088 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932109AbWAESDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:03:11 -0500
Message-ID: <43BD5F5E.1070108@arcom.com>
Date: Thu, 05 Jan 2006 18:03:10 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [DRIVER CORE] platform_get_irq*(): return   NO_IRQ on error
References: <43BD534E.8050701@arcom.com> <20060105173717.GA11279@suse.de>
In-Reply-To: <20060105173717.GA11279@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2006 18:06:49.0640 (UTC) FILETIME=[CC89AA80:01C61222]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jan 05, 2006 at 05:11:42PM +0000, David Vrabel wrote:
> 
>>platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
>>platforms, return NO_IRQ (-1) instead.
>>
>>Signed-off-by: David Vrabel <dvrabel@arcom.com>
>>
>>--- linux-2.6-working.orig/drivers/base/platform.c	2006-01-05 16:49:23.000000000 +0000
>>+++ linux-2.6-working/drivers/base/platform.c	2006-01-05 17:10:18.000000000 +0000
>>@@ -59,7 +59,7 @@
>> {
>> 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>> 
>>-	return r ? r->start : 0;
>>+	return r ? r->start : NO_IRQ;
> 
> 
> No, I think the whole NO_IRQ stuff has been given up on, see the lkml
> archives for details.

Now that you mention it I remember that thread[1].

How about returning -ENXIO (or similar) then?

I went through all the users of platform_get_irq*() and some of them
assume < 0 is an error, some of them think 0 is an error, some of them
think 0 means there's no IRQ available, some of them use NO_IRQ, and
some don't even check and just pass the result to request_irq().

[1] http://lkml.org/lkml/2005/11/21/200
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
