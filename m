Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272966AbRIMKRx>; Thu, 13 Sep 2001 06:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272970AbRIMKRn>; Thu, 13 Sep 2001 06:17:43 -0400
Received: from t2.redhat.com ([199.183.24.243]:12030 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272966AbRIMKRY>; Thu, 13 Sep 2001 06:17:24 -0400
Message-ID: <3BA087CA.3BD1D557@redhat.com>
Date: Thu, 13 Sep 2001 11:17:46 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6.4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA wrote:
> 
> Hi. Below is a modified printout of lspci -vvvxxx
> made on VIA KT133A based mainboard with BIOS version 3R flashed in
> (this system is exhibiting Athlon bug) and on the same system
> with BIOS version YH (which do not trigger bug).
> Each chipset config register which is changed between these two BIOSes
> is underlined with carets "^" with programming details immediately below.
> Each register is then commented with:
> *** 3R BIOS: settings made by 3R BIOS
> *** YH BIOS: settings made by YH BIOS
> *** TODO: is this relevant and what to do
> 
> Anyone interested in trying to pin down the bug might
> try to reprogram this chipset along the lines:
>     ...
>     struct pci_dev *dev;
>     dev = pci_find_device(PCI_VENDOR_ID_VIA, 0x0305, NULL);
>     if(dev) {
>         printk("Trying to stomp on Athlon bug...\n");
>         u8 v;
>         pci_read_config_byte(dev, 0x52, &v);
>         /* set 52.7: Disconnect Enable When STPGNT Detected */
>         v |= 0x80;
>         pci_write_config_byte(dev, 0x52, v);
>         ...
>     }
>     ...
> I'm not sure where exactly this piece of code should go.
> Anyway, compile K7 optimized kernel with this fix
> and give it a try.

Interesting; This is exactly the bit that the athlon cool thingy that
popped up
here a while ago changed; everybody agreed that it was WAAAAY too
dangerous
back then, because PSU's and voltage regulators wouldn't be able to
cope......
