Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVD1U0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVD1U0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVD1U0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:26:54 -0400
Received: from mail4.utc.com ([192.249.46.193]:2211 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262151AbVD1U0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:26:47 -0400
Message-ID: <427146F3.5060605@cybsft.com>
Date: Thu, 28 Apr 2005 15:26:27 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.12-rc3 won't boot from aic7899
References: <4269C60C.3070700@cybsft.com> <1114716611.5022.6.camel@mulgrave>	 <4271413F.70809@cybsft.com> <1114719624.5022.14.camel@mulgrave>
In-Reply-To: <1114719624.5022.14.camel@mulgrave>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2005-04-28 at 15:02 -0500, K.R. Foley wrote:
> 
>>I am attaching the relevant part of the successful boot log from 
>>2.6.12-rc2. I don't have a 2.6.11 boot log handy. I can boot it when I 
>>get home if it will help. I don't know if it is worth mentioning or not, 
>>but I have had to compile in the SCSI drivers since 2.6.12-rc1. Don't 
>>know if it's related to this or not.
>>
>>One other note: I spent enough time tracing this to find that the 
>>message "target1:0:0: Beginning Domain Validation" seems to be generated 
>>by code that is in aic79xx_osm. Is this common code or should this code 
>>not be getting executed for aic7899 cards?
> 
> 
> Actually, the code is in the scsi_transport_spi class.  aic79xx still
> has its own internal domain validation.
> 
> 
>>I'll be happy to try this when I get home.
> 
> 
> Thanks ... it may not work; I don't have access to any drives with the
> problem yours exhibits.
> 
> 
>>Apr 24 23:23:30 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>>Apr 24 23:23:30 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
>>Apr 24 23:23:30 porky kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
>>Apr 24 23:23:30 porky kernel: 
>>Apr 24 23:23:30 porky kernel: (scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
>>Apr 24 23:23:31 porky kernel:   Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
> 
> 
> Yes, that's what I suspected.  Here the internal aic7xxx DV has silently
> configured the drive to be narrow.  Probably because of cable damage or
> something else.
> 
Sorry I missed this before. The reason it is doing this is because this 
drive is connected using an adapter that converts an LC/LV (is this 
correct, off the top of my head) interface into a standard SCSI (narrow) 
interface. Could this be HELPING me here? :)

> James
> 
> 
> 


-- 
    kr
