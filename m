Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272855AbRILPLo>; Wed, 12 Sep 2001 11:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272857AbRILPLe>; Wed, 12 Sep 2001 11:11:34 -0400
Received: from cm038.32.234.24.lvcm.com ([24.234.32.38]:15232 "EHLO osafo.com")
	by vger.kernel.org with ESMTP id <S272855AbRILPLX>;
	Wed, 12 Sep 2001 11:11:23 -0400
Message-ID: <3B9F7B06.9060600@osafo.com>
Date: Wed, 12 Sep 2001 08:11:02 -0700
From: Colin Frank <kernel@osafo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Eric.VanBuggenhaut@AdValvas.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PCMCIA_APA1480 not linked to any code ?
In-Reply-To: <20010911021342.A2682@eric.ath.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This card is now handled by the the (aic7xxx) HOTPLUG PCI interface.
It is not at all clear on the docs, but do NOT use the apa1480_cb dirver.
It crashes my 2.4.x system.

Configure the kernel 2.4.9 with:
    CONFIG_HOTPLUG=y
    CONFIG_CARDBUS=y
    CONFIG_SCSI_AIC7XXX=m

# modprobe aic7xxx
Sep 12 07:56:36 localhost kernel: PCI: Enabling device 05:00.0 (0006 -> 
0007)
Sep 12 07:56:36 localhost kernel: ahc_pci:5:0:0: Host Adapter Bios 
disabled.  Using default SCSI device parameters
Sep 12 07:56:36 localhost kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI 
SCSI HBA DRIVER, Rev 6.2.1
Sep 12 07:56:36 localhost kernel:         <Adaptec 1480A Ultra SCSI 
adapter>
Sep 12 07:56:36 localhost kernel:         aic7860: Ultra Single Channel 
A, SCSI Id=7, 3/255 SCBs
Sep 12 07:56:36 localhost kernel:

card "Adaptec APA-1480 SCSI Host Adapter"
  manfid 0x012f, 0xcb01
  bind "aic7xxx"
  bind "apa1480_cb"

To keep pcmcia from autoloading apa1480_cb when the card is inserted,
Edit: /etc/pcmcia/config
comment out the "apa1480_cb" stuff or try to replace it with aic7xxx

Ref: Kernel help on HOTPLUG, and
Colin Frank


Eric Van Buggenhaut wrote:

>I'm with 2.4.9 source tree.
>
>Documentation/Configure.help documents a CONFIG_PCMCIA_APA1480 but this option
>doesn't lead to any code ?!
>
>femto:/usr/src/linux-2.4.9[0]# grep -r CONFIG_PCMCIA_APA1480 *
>Documentation/Configure.help:CONFIG_PCMCIA_APA1480
>femto:/usr/src/linux-2.4.9[0]#
>
>Am I missing something ?
>
>Thanks.
>
>Please CC me any answer/comment.
>


