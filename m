Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSE0KJH>; Mon, 27 May 2002 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSE0KJG>; Mon, 27 May 2002 06:09:06 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:47120 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S316544AbSE0KJF>;
	Mon, 27 May 2002 06:09:05 -0400
Message-ID: <3CF205C1.6040408@epfl.ch>
Date: Mon, 27 May 2002 12:09:05 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alessandro Morelli <alex@alphac.it>, linux-kernel@vger.kernel.org,
        stilgar2k@wanadoo.fr
Subject: Re: [PATCH,CFT] Tentative fix for mem. corruption caused by intel
 815 AGP
In-Reply-To: <fa.mm4ng1v.vmenaj@ifi.uio.no> <fa.gciunnv.cnaf99@ifi.uio.no> <3CF1EA3F.4070608@epfl.ch> <1022493086.11859.191.camel@irongate.swansea.linux.org.uk> <3CF1F4C0.5080201@epfl.ch> <1022494620.11859.207.camel@irongate.swansea.linux.org.uk> <3CF1FD4B.8060608@epfl.ch> <1022497386.11859.232.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-05-27 at 10:32, Nicolas Aspert wrote:
> p to */
> 
>>+	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
>>+	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
>>+
>>+	/* attbase - aperture base */
>>+        /* the Intel 815 chipset spec. says that bits 29-31 in the
>>+         * ATTBASE register are reserved -> try not to write them */
>>+        if (agp_bridge.gatt_bus_addr & (~ INTEL_815_ATTBASE_MASK))
>>+		panic("gatt bus addr too high");
>>+	addr = agp_bridge.gatt_bus_addr & INTEL_815_ATTBASE_MASK;
> 
> 
> You need to add  + temp&~INTEL_815_ATTBASE_MASK ..
> 
> 

I am not sure to understand... Do you really mean mixing 'APBASE' which 
is the AGP base aperture adress along with the *gatt* which is the 
translation table adress ? If yes, I think I need a supplementary 
explanation...

Best regards.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)


