Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSCWNpS>; Sat, 23 Mar 2002 08:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSCWNpJ>; Sat, 23 Mar 2002 08:45:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293131AbSCWNow>;
	Sat, 23 Mar 2002 08:44:52 -0500
Message-ID: <3C9C868D.5030406@mandrakesoft.com>
Date: Sat, 23 Mar 2002 08:43:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com, dave@zarzycki.org,
        ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <200203221956.g2MJuhK32671@gs176.sp.cs.cmu.edu> <3C9C7EF9.8020307@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> John Langford wrote:
>
>> I went nuts with printk statements and managed to isolate the hang to
>> one particular line of code.  The final printk in this code fragment
>> never gets executed. 
>>                 } else if (m5229_revision >= 0xC3) {
>>                 /*
>>                          * 1553/1535 (m1533, 0x79, bit 1)
>>                          */
>>                         printk("ata66_ali15x3           } else if 
>> (m5229_revisi\on >= 0xC3) {\n");
>>                         pci_write_config_byte(isa_dev, 0x79, tmpbyte 
>> | 0x02);
>
>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
>
>
> pci_write_config to isa_dev???? This looks at least suspicious.
> You may very well check whatever isa_dev is trully a PCI device
> handle or just some random IO base for ISA bus!


Nope, look at the code and comments around "isa_dev"   :)

isa_dev is the PCI device structure for the ALi ISA bridge... very 
definitely a PCI device.

some background:
It is normal in some situations that you need to examine or set PCI 
config registers for the ISA bridge, when dealing with some IDE 
motherboards.  The southbridge is typically the chip that actually 
implements IDE on your motherboard.  Even though IDE is normally 
exported as a separate PCI device, you still have to deal with the ATA 
register blocks at hardcoded legacy ISA addresses 0x1f0 and 0x170.  So, 
when you write the ATA registers for channel 0 or channel 1, you are 
writing to 0x1f? or 0x17?, the ISA bridge is most likely the portion of 
the southbridge chip actually decoding those addresses for you.

    Jeff



