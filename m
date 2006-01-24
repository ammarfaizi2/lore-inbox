Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWAXMMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWAXMMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWAXMMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:12:34 -0500
Received: from webapps.arcom.com ([194.200.159.168]:9737 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1030458AbWAXMMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:12:34 -0500
Message-ID: <43D6196A.5040209@arcom.com>
Date: Tue, 24 Jan 2006 12:11:22 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stephen@streetfiresound.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PXA2xx SPI controller updated for 2.6.16-rc1?
References: <43CF6F25.9070704@arcom.com> <1137690309.4623.24.camel@localhost.localdomain>
In-Reply-To: <1137690309.4623.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2006 12:15:44.0890 (UTC) FILETIME=[E6D125A0:01C620DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Street wrote:
> On Thu, 2006-01-19 at 10:51 +0000, David Vrabel wrote:
> 
>>Do you have a version of the PXA2xx SPI contoller driver more recent
>>that the one posted at the end of October 2005?  There are some SPI (and
>>other) API changes required for 2.6.16-rc1.
> 
> I'm working on it now.  I expect to have something with in the week.

Cool.

>>I've attached my attempt (PIO works but DMA doesn't) if it's of any use.
>>
>>The patch also:
>>  - includes support for the different clock on the PXA27x
>>  - calculates the correct clock divisor (at least on the PXA27x...)
>>  - allows null_cs_control for PIO transfer.
>>
> 
> I will review and integrate you changes. THANKS!

When you have a version that works with 2.6.16-rc1 I can produce new
patches including just these changes if that's more convinient.

>>I'm currently using SSP3 on the PXA27x with the slave chip select GPIO
>>line configured as SSPSFRM3 instead of a GPIO.  This works fine provided
>>that each spi_message consists of a single spi_transfer.  With more than
>> one transfer they're not back-to-back and SSPSFRM3 is deasserted
>>between transfers.
> 
> I believe this is the correct SSP in SPI mode behavior for PXA2xx.

I agree.  However, this isn't the behavior I need.

On the board I have here the chip select of the SPI slave (a CAN
controller) is connected to GPIO83 which is also SSPSFRM3.  GPIO83 must
be configured as SSPSFRM3 otherwise the SPI controller doesn't work at
all.  These means I need to use the SSPSFRM3 signal as the chipselect.
This works fine at the moment for single transfer messages and it could
be made for multiple transfer messages if after exhausting a tx_buf the
SPI controller driver switches to the next transfer instead of waiting
for a transmit empty interrupt.

I'll take a look at implementing this once you've produced a updated
version of the driver. (I've worked around it for now by only using
single transfer messages.)

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
