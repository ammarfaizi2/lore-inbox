Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWEBQLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWEBQLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWEBQLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:11:05 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:22535 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S964907AbWEBQLE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:11:04 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [openib-general] Re: [PATCH 5 of 13] ipath - use proper
 address translation routine
Date: Tue, 2 May 2006 09:10:21 -0700
Message-ID: <54AD0F12E08D1541B826BE97C98F99F143B391@NT-SJCA-0751.brcm.ad.broadcom.com>
Thread-Topic: [openib-general] Re: [PATCH 5 of 13] ipath - use proper
 address translation routine
Thread-Index: AcZt9uEMyUn62ZeUT4yCqsSSPt7aqgAC0PEA
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Roland Dreier" <rdreier@cisco.com>
cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       "Arjan van de Ven" <arjan@infradead.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006050204; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34343537383243322E303034452D412D;
 ENG=IBF; TS=20060502161055; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006050204_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68495B054I85126963-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

openib-general-bounces@openib.org wrote:
> proper address translation routine
> 
> On Tue, May 02, 2006 at 07:24:18AM -0700, Roland Dreier wrote:
>>     Christoph> Or stop doing the dma mapping in the IB upper level
>>     Christoph> drivers.  I told you that we'll get broken hardware
>>     Christoph> that doesn't want dma mapping in the upper level
>>     Christoph> driver, and pathscale created exactly that :)
>> 
>> But see my earlier mail to Arjan about RDMA -- what address can a
>> protocol (eg SRP initiator) put in a message that the other side will
>> use to initiate a remote DMA operation?  It seems to me it has to be
>> a bus address, and that means that the protocol has to do the DMA
>> mapping. 
> 
> Then we're back to the discussion on why RDMA is a
> fundamentally flawed approach, but we already knew that.  The
> usual workaround is to only allow RDMA operations to
> registered memory windows for which we can use the normal dma
> operation.  There's also the *dac* pci dma operations that
> can avoid iommu overhead if you support 64bit addressing.
> But for all this to work dma mapping fundamentally needs to
> be handled by the low level driver.

This is not a flaw in the RDMA model. All the RDMA Model requires
is exposing virtual addresses that the device can translate back
to host memory for remote operations. The protocols do not specify
what the backing of an R-Key or STag is.

And the local interface only requires that a L-Key / MR Stag be
backed by translations from Key/TAG and Address to a memory
reference that the hardware is capable of using immediately.

So the problem here is that the upper layer driver does not properly
understand what type of address the specific driver requires (and/or
of the driver/device to understand what type of addresses it will be
given). That's a failure to document interface requirements, not a
failure of the RDMA model.

