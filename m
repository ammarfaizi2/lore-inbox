Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291713AbSBNPda>; Thu, 14 Feb 2002 10:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291717AbSBNPdV>; Thu, 14 Feb 2002 10:33:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9746 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291713AbSBNPdD>;
	Thu, 14 Feb 2002 10:33:03 -0500
Message-ID: <3C6BD897.7090704@evision-ventures.com>
Date: Thu, 14 Feb 2002 16:32:39 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} 2.5.5-pre1 VESA fb
In-Reply-To: <E16bNc9-0000GD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>This adjusts the VESA fb driver to the new bus mapping API.
>>I think that this time this is providing the right replacement.... but 
>>who knows
>>
>
>The VESA fb window will be higher than the ISA window as its a linear
>frame buffer
>
>>-		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
>>+		pmi_base  = (unsigned short*)isa_bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
>>
>
>I don't think it actually matters on x86 but phys_to_virt() is probably
>more correct
>

Well I think this is only the BIOS register gateway which we deal with 
here and I was therefore assuming
(without reading the doc's about the *isa*pci*bus*phys*virt* ) that this 
can be expected to reside in
the low memmory area < 1M of the physical address space. And then there 
are no pci references in the vesa driver
at all. Perhaps becouse they ignore the actual frame-buffer mapping 
games for non intel archs entierly.
Anyway I think that the isa_variant is correct. But please feel free to 
consider me a bit
arrogant for not reading the doc's about the address mapping functions. 
If I'm mistaken here, you could
alternatively consider it as a test for the fact that the API isn't 
"obvious" in first place, becouse it's not
easy to figure out what to do without sudying the docu for something 
such trivial like IO address range mapping ;-).

Regards

