Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268101AbTB1Tlw>; Fri, 28 Feb 2003 14:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbTB1Tlw>; Fri, 28 Feb 2003 14:41:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53517 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268101AbTB1Tlv>; Fri, 28 Feb 2003 14:41:51 -0500
Date: Fri, 28 Feb 2003 19:52:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Deepak Saxena <dsaxena@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
       linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228195210.C10968@flint.arm.linux.org.uk>
Mail-Followup-To: Deepak Saxena <dsaxena@mvista.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	"Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
	linux-kernel@vger.kernel.org
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su> <20030228155841.GA4678@gtf.org> <20030228181729.GA8366@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030228181729.GA8366@xanadu.az.mvista.com>; from dsaxena@mvista.com on Fri, Feb 28, 2003 at 11:17:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 11:17:29AM -0700, Deepak Saxena wrote:
> This discussion raises an issue that I've been meaning to bring up for
> a bit.  Currently, the DMA-API is defined as returning a cpu physical
> address [1]

The DMA-API should reflect the same as the PCI-DMA API, namely:

|  pci_alloc_consistent returns two values: the virtual address which you
|  can use to access it from the CPU and dma_handle which you pass to the
|  card.

Translated: not a physical address.  "Physical" address to me means
the address that appears on the outside of the CPU after it has passed
through the MMU and is heading for the local CPUs system RAM.

So yes, I think this is a bug that exists in the DMA-API document.

It must be an offsetable cookie that the card on its own bus knows how
to deal with to access the memory associated with the mapping.  In plain
speak, the bus address for that device.

> One easy answer is to provide bus-specific bus_map/unmap/etc functions
> such as is done with PCI, but this seems rather ugly to me as now every
> custom bus needs a new set of functions which IMNHO defeats the purpose
> of a Generic DMA API.

You can do this today with the API - test dev->bus_type to determine
the type of the bus, convert to the correct device type and grab the
bus information.

The API hasn't really changed - its just that bugs exist in the
documentation that need fixing before 2.6 comes out.  Submit a
patch. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

