Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280766AbRKOICZ>; Thu, 15 Nov 2001 03:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280773AbRKOICF>; Thu, 15 Nov 2001 03:02:05 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:9988 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S280769AbRKOIB4>;
	Thu, 15 Nov 2001 03:01:56 -0500
Message-ID: <3BF37672.50006@epfl.ch>
Date: Thu, 15 Nov 2001 09:01:54 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniele Venzano <venza@iol.it>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: Re: Problem with i820 AGP patch
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano wrote:

> Your patch to add AGP support for i820 chipset doesn't work for me, if I
> load agpgart module with agp_try_unsupported=1 I get:
> 
> -
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 262M
> agpgart: Trying generic Intel routines for device id: 2501
> 						^^^^^^^^^^^^^
> agpgart: AGP aperture is 256M @ 0xd0000000
> -


Here is what I have in 'drivers/pci/pci.ids' :

         2500  82820 820 (Camino) Chipset Host Bridge (MCH)
                 1043 801c  P3C-2000 system chipset
         2501  82820 820 (Camino) Chipset Host Bridge (MCH)
                 1043 801c  P3C-2000 system chipset
         250b  82820 820 (Camino) Chipset Host Bridge
         250f  82820 820 (Camino) Chipset PCI to AGP Bridge

So I guess that 0x2500 and 0x2501 should be initialized in the same way, 
through the same routines. Unfortunately, I dont have such a machine to 
test... Can you send what 'lspci -ev' shows ?


> That device id is different from the corresponding line in apg.h:174
> #define PCI_DEVICE_ID_INTEL_820_0       0x2500
> 
> I tried to change that line in:
> #define PCI_DEVICE_ID_INTEL_820_0       0x2501
> 
> And it worked! But I don't know why the id for your chip is different
> from mine... 
> 


It worked, but in which way ? Did you test X+OpenGL apps to see whether 
it did the trick ? The fact that the module loads itself is not always 
sufficient to say that it works (believe me :-)


> My motherboard is an Asus P3C2000 with a P3 500 running kernel 2.4.14
> 
> 
> I've also another problem (I think AGP related) with DRI/DRM ang XFree
> 4.1.0, but I'm still working on it.
> If I try running some OpenGL app with more than 256Mb of RAM, the system hangs
> (need hard reset, no SysReq works). This happens with 2.4.13 and 2.4.14,
> before I hadn't tried since I had only 128Mb...)
> Someone can please tell me if this problem has something to do with
> having a "Maximum main memory to use for agp memory" value grater than
> AGP aperture value ?
> 

With your custom patch, or with the 'generic' stuff ?

Regards.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)


