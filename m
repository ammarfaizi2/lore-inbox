Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSE0KAq>; Mon, 27 May 2002 06:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSE0KAp>; Mon, 27 May 2002 06:00:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9467 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316540AbSE0KAo>; Mon, 27 May 2002 06:00:44 -0400
Subject: Re: [PATCH,CFT] Tentative fix for mem. corruption caused by intel
	815 AGP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Alessandro Morelli <alex@alphac.it>, linux-kernel@vger.kernel.org,
        stilgar2k@wanadoo.fr
In-Reply-To: <3CF1FD4B.8060608@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 12:03:06 +0100
Message-Id: <1022497386.11859.232.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 10:32, Nicolas Aspert wrote:
p to */
> +	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
> +	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
> +
> +	/* attbase - aperture base */
> +        /* the Intel 815 chipset spec. says that bits 29-31 in the
> +         * ATTBASE register are reserved -> try not to write them */
> +        if (agp_bridge.gatt_bus_addr & (~ INTEL_815_ATTBASE_MASK))
> +		panic("gatt bus addr too high");
> +	addr = agp_bridge.gatt_bus_addr & INTEL_815_ATTBASE_MASK;

You need to add  + temp&~INTEL_815_ATTBASE_MASK ..


