Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSCWN1D>; Sat, 23 Mar 2002 08:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCWN0y>; Sat, 23 Mar 2002 08:26:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:34322 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293119AbSCWN0q>; Sat, 23 Mar 2002 08:26:46 -0500
Message-ID: <3C9C823D.3080705@evision-ventures.com>
Date: Sat, 23 Mar 2002 14:25:17 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: John Langford <jcl@cs.cmu.edu>
CC: Dave Zarzycki <dave@zarzycki.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <200203222046.g2MKkt200348@gs176.sp.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Langford wrote:
> I did a small tweak and "it seems to work".  I have no idea whether or
> not this breaks other configs.
> 
> -John
> 
> --- linux/drivers/ide/alim15x3.c        Sun Jul 15 19:22:23 2001
> +++ linux-2.4.18-hack/drivers/ide/alim15x3.c    Fri Mar 22 12:31:28 2002
> @@ -574,17 +574,7 @@
>                  * set south-bridge's enable bit, m1533, 0x79
>                  */
>                 pci_read_config_byte(isa_dev, 0x79, &tmpbyte);
> -               if (m5229_revision == 0xC2) {
> -                       /*
> -                        * 1543C-B0 (m1533, 0x79, bit 2)
> -                        */
> -                       pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
> -               } else if (m5229_revision >= 0xC3) {
> -                       /*
> -                        * 1553/1535 (m1533, 0x79, bit 1)
> -                        */
> -                       pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
> -               }
> +               pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
>                 /*
>                  * Ultra66 cable detection (from Host View)
>                  * m5229, 0x4a, bit0: primary, bit1: secondary 80 pin

According to the fact that this is setting the enable bit
of the south bridge on this host, the issue appears to be
not tactile. (If your fix where wrong, your system would simply
not work at all.) I will therefore just simply take this patch as
it is... And then I couldn't find any other places
where the 0x02 bit would be used on register 0x79.

Possibly someone just misscounted the bits reading some
errate for different reviaions... or just the errata was wrong.

But before could you just tell the m5229_revision value
on your system?

