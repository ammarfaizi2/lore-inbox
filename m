Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290783AbSARTXF>; Fri, 18 Jan 2002 14:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290784AbSARTWz>; Fri, 18 Jan 2002 14:22:55 -0500
Received: from host155.209-113-146.oem.net ([209.113.146.155]:9206 "EHLO
	tibook.netx4.com") by vger.kernel.org with ESMTP id <S290783AbSARTWn>;
	Fri, 18 Jan 2002 14:22:43 -0500
Message-ID: <3C4875DB.9080402@embeddededge.com>
Date: Fri, 18 Jan 2002 14:22:03 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.11-pre6-ben0 ppc; en-US; 0.8) Gecko/20010419
X-Accept-Language: en
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        Gerard Roudier <groudier@free.fr>, mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <20020118130209.J14725@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Benjegerdes wrote:

> Somehow the docs in DMA-mappings.txt say pci_alloc_consistent is allowed from 
> interrupt, but this is a "bad thing" on at least arm and PPC non-cache 
> coherent cpus.

This isn't unique to PowerPC or ARM, and has nothing to do with allocating
page tables.

I don't understand how pci_alloc_consistent could ever be claimed to work
from an interrupt function because it actually allocates pages of memory
for all architectures.  Anytime you call alloc_pages() (or friends) you could
potentially block or return an error (out of memory) condition.

Either option is undesirable for an interrupt function.  If your software can
handle the case of not being able to allocate memory, then why not remove the
complexity and do it that way all of the time?

Thanks.


	-- Dan

