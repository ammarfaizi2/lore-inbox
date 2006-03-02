Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752016AbWCBRFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbWCBRFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWCBRFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:05:05 -0500
Received: from mail0.lsil.com ([147.145.40.20]:24059 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751390AbWCBRFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:05:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Question: how to map SCSI data DMA address to virtual address?
Date: Thu, 2 Mar 2006 10:04:57 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C2651420C2@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: how to map SCSI data DMA address to virtual address?
Thread-index: AcY+GoF8v0SEDptDR3Oj2x6OM6fFtwAACPEg
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 17:04:57.0082 (UTC) FILETIME=[6ED045A0:01C63E1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, March 02, 2006 11:58 AM Arjan van de Ven wrote:
> Why do you need to do this? It's generally bad for drivers to snoop
> data! 
I understood that is bad. I am trying to make sure the data written to disk drive are identical with the data from upper layer by comparing actual data in the driver.
This is a part of debugging only not for release driver, obviously.
So, is it completely unable to get this done?
Any tricky solution?

Thank you,

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjan@infradead.org] 
> Sent: Thursday, March 02, 2006 11:58 AM
> To: Ju, Seokmann
> Cc: Ju, Seokmann; linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org
> Subject: Re: Question: how to map SCSI data DMA address to 
> virtual address?
> 
> On Thu, 2006-03-02 at 09:53 -0700, Ju, Seokmann wrote:
> > Hi,
> > 
> > In the 'scsi_cmnd' structure, there are two entries holding address
> > information for data to be transferred. One is 
> 'request_buffer' and the
> > other one is 'buffer'.
> > In case of 'use_sg' is non-zero, those entries indicates 
> the address of
> > the scatter-gather table.
> 
> use_sg is never non-zero so that's easy
> 
> > 
> > Is there way to get virtual address (so that the data could 
> be accessed
> > by the driver) of the actual data in the case of 'use_sg' 
> is non-zero?
> 
> not really; unless you mapped it. The physical address may 
> already been
> translated by the iommu... at which point there is no direct 
> mapping to
> kernel memory.
> 
> Why do you need to do this? It's generally bad for drivers to snoop
> data! 
> 
> 
