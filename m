Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293349AbSCEPnl>; Tue, 5 Mar 2002 10:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293390AbSCEPn3>; Tue, 5 Mar 2002 10:43:29 -0500
Received: from elin.scali.no ([62.70.89.10]:8203 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S293349AbSCEPnM>;
	Tue, 5 Mar 2002 10:43:12 -0500
Message-ID: <3C84E785.1D102FF9@scali.com>
Date: Tue, 05 Mar 2002 16:43:01 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13win4lin i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
In-Reply-To: <200203051112.DAA03159@adam.yggdrasil.com> <20020305.031636.63129004.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: "Adam J. Richter" <adam@yggdrasil.com>
>    Date: Tue, 5 Mar 2002 03:12:52 -0800
> 
>    If not, then I guess I can use
>    pci_alloc_consistent and pci_map_single as necessary, since they
>    should can potentially know that I am using a device that
>    only understands 32-bit addresses, from my earlier call to
>    pci_set_dma_mask.  However, I assume that it is considered
>    simpler and therefore better to avoid these routines when possible.
> 
> Just use pci_alloc_consistent, it never gives you
> anything larger than 32-bit addresses, please read the
> documentation :-)
> 

What about memory for streaming mappings. I know pci_map_single (and _sg) will
use bounce buffers on platforms without an IOMMU, but wouldn't it be nice if
this could also be ensured by the device driver to avoid uneccessary copying.
It could for example be solved with a GFP_32BIT flag or something (on IA64 I
know GFP_DMA is used in pci_alloc_consistent() to get memory below 4GB but that
can't be used on all platforms).


> On 64-bit platforms without CONFIG_HIGHMEM, kmalloc can return any
> pointer, but that is fine since your DMA mask will instruct the
> IOMMU layer of the platform to map it in the low 32-bits of DMA
> address space.
> 
> If you follow DMA-mapping.txt to the letter, it will just work, trust
> us. :-)

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
