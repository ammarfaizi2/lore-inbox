Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWASRFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWASRFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWASRFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:05:15 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:15005 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S932483AbWASRFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:05:13 -0500
Subject: Re: PXA2xx SPI controller updated for 2.6.16-rc1?
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43CF6F25.9070704@arcom.com>
References: <43CF6F25.9070704@arcom.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Thu, 19 Jan 2006 09:05:09 -0800
Message-Id: <1137690309.4623.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 10:51 +0000, David Vrabel wrote:
> Stephen,
> 
> Do you have a version of the PXA2xx SPI contoller driver more recent
> that the one posted at the end of October 2005?  There are some SPI (and
> other) API changes required for 2.6.16-rc1.
> 
I'm working on it now.  I expect to have something with in the week.  I
had some user space problems bringing up 2.6.15 which has cause some
delay.

> I've attached my attempt (PIO works but DMA doesn't) if it's of any use.
> 
> The patch also:
>   - includes support for the different clock on the PXA27x
>   - calculates the correct clock divisor (at least on the PXA27x...)
>   - allows null_cs_control for PIO transfer.
> 
I will review and integrate you changes. THANKS!

> I'm currently using SSP3 on the PXA27x with the slave chip select GPIO
> line configured as SSPSFRM3 instead of a GPIO.  This works fine provided
> that each spi_message consists of a single spi_transfer.  With more than
>  one transfer they're not back-to-back and SSPSFRM3 is deasserted
> between transfers.
I believe this is the correct SSP in SPI mode behavior for PXA2xx.

> 
> It looks like you're waiting for the transmit buffer in the controller
> to empty before switching to the next transfer.  Is it possible to
> switch to the next transfer immediatly upon exhausting the transfer's
> tx_buf?  Perhaps (in the DMA case) by chaining several DMA descriptors
> together?
DMA descriptor chaining the next optimization for the driver.  I want to
get the driver cleaned up, tested and posted before starting this.

> 
> At the higher SPI clock rates available on the PXA27x (up to 13 MHz with
> the internal clock) PIO mode doesn't seem to feed the transmit buffer
> fast enough resulting in gaps between each byte/word of the transfer.  I
> would assume using DMA would not show this?
Correct, I think the PXA2xx even states this in the docs.

Thanks your input, I really appreciate it.  I will send you my updates
ASAP.  Most likely a 2.6.15 version quickly follow by a 2.6.16-rc
version.

Stephen

