Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292971AbSCWNNN>; Sat, 23 Mar 2002 08:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSCWNND>; Sat, 23 Mar 2002 08:13:03 -0500
Received: from [195.63.194.11] ([195.63.194.11]:25618 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292971AbSCWNMu>; Sat, 23 Mar 2002 08:12:50 -0500
Message-ID: <3C9C7EF9.8020307@evision-ventures.com>
Date: Sat, 23 Mar 2002 14:11:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: John Langford <jcl@cs.cmu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        ahaas@neosoft.com, dave@zarzycki.org, ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <200203221956.g2MJuhK32671@gs176.sp.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Langford wrote:
> I went nuts with printk statements and managed to isolate the hang to
> one particular line of code.  The final printk in this code fragment
> never gets executed.  
> 
>                 } else if (m5229_revision >= 0xC3) {
> 		        /*
>                          * 1553/1535 (m1533, 0x79, bit 1)
>                          */
>                         printk("ata66_ali15x3           } else if (m5229_revisi\on >= 0xC3) {\n");
>                         pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

pci_write_config to isa_dev???? This looks at least suspicious.
You may very well check whatever isa_dev is trully a PCI device
handle or just some random IO base for ISA bus!

>                 }
>                 printk("ata66_ali15x3 endif\n");
> 
> Art, Dave, and Ben may or may not have the same problem.  It would be
> interesting to know if they get a hang here.
> 
> Any ideas for fixing?

See above :-)

