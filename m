Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSE0I4d>; Mon, 27 May 2002 04:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSE0I4c>; Mon, 27 May 2002 04:56:32 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:33036 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S314670AbSE0I4c>;
	Mon, 27 May 2002 04:56:32 -0400
Message-ID: <3CF1F4C0.5080201@epfl.ch>
Date: Mon, 27 May 2002 10:56:32 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alessandro Morelli <alex@alphac.it>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: memory corruption with i815 chipset variant
In-Reply-To: <fa.mm4ng1v.vmenaj@ifi.uio.no> <fa.gciunnv.cnaf99@ifi.uio.no> <3CF1EA3F.4070608@epfl.ch> <1022493086.11859.191.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 
> It certainly could be. If bits 29-31 maybe control things like memory
> timings then it could do quite horrible things. Fixing it to leave the
> ERRSTS register alone and keep bits 29-31 is definitely worth trying. If
> that fixes it then its going to be easy enough to drop a fix into the
> mainstream code
> 

OK, I have a patch almost ready to do that except, I am not sure about 
what to do for those 3 bits...

The *usual* call is :
	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE,
			       agp_bridge.gatt_bus_addr);

Where 'gatt_bus_addr' is returned from a 'virt_to_phys' on 
'gatt_table_real'.

Should I mask those three bits out when writing or write
'gatt_bus_addr >> 3' instead ? I am not too sure about the assumptions 
that can be made about what returns 'virt_to_phys' ...

Thanks in advance.

Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

