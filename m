Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVD1UUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVD1UUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVD1UUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:20:38 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:4293 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261784AbVD1UU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:20:28 -0400
Subject: Re: 2.6.12-rc3 won't boot from aic7899
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4271413F.70809@cybsft.com>
References: <4269C60C.3070700@cybsft.com> <1114716611.5022.6.camel@mulgrave>
	 <4271413F.70809@cybsft.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 13:20:24 -0700
Message-Id: <1114719624.5022.14.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 15:02 -0500, K.R. Foley wrote:
> I am attaching the relevant part of the successful boot log from 
> 2.6.12-rc2. I don't have a 2.6.11 boot log handy. I can boot it when I 
> get home if it will help. I don't know if it is worth mentioning or not, 
> but I have had to compile in the SCSI drivers since 2.6.12-rc1. Don't 
> know if it's related to this or not.
> 
> One other note: I spent enough time tracing this to find that the 
> message "target1:0:0: Beginning Domain Validation" seems to be generated 
> by code that is in aic79xx_osm. Is this common code or should this code 
> not be getting executed for aic7899 cards?

Actually, the code is in the scsi_transport_spi class.  aic79xx still
has its own internal domain validation.

> I'll be happy to try this when I get home.

Thanks ... it may not work; I don't have access to any drives with the
problem yours exhibits.

> Apr 24 23:23:30 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
> Apr 24 23:23:30 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
> Apr 24 23:23:30 porky kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
> Apr 24 23:23:30 porky kernel: 
> Apr 24 23:23:30 porky kernel: (scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
> Apr 24 23:23:31 porky kernel:   Vendor: SEAGATE   Model: SX118273LC        Rev: 6679

Yes, that's what I suspected.  Here the internal aic7xxx DV has silently
configured the drive to be narrow.  Probably because of cable damage or
something else.

James


