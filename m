Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUDYSNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUDYSNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 14:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUDYSNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 14:13:00 -0400
Received: from p15112047.pureserver.info ([217.160.169.118]:21444 "EHLO
	mail.wim-media.de") by vger.kernel.org with ESMTP id S262205AbUDYSM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 14:12:57 -0400
From: Roessner Christian <info@roessner-net.com>
Organization: Roessner Network Solutions
To: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: APIC probs with kernel 2.6.6-rc1-bk2 and usb, bttv
Date: Sun, 25 Apr 2004 20:13:34 +0200
User-Agent: KMail/1.6.2
References: <A6974D8E5F98D511BB910002A50A6647615F9864@hdsmsx403.hd.intel.com> <1082862426.3163.30.camel@dhcppc4>
In-Reply-To: <1082862426.3163.30.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404252013.34704.info@roessner-net.com>
X-Sagator-Scanner: clamd()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>
> Tagged where?  These flags apply equally to both architectures.

Okay, sorry. I did not read the leading text inside kernel-parameters.txt. 
Just did a grep acpi and looked for the listed lines.

>           CPU0
>   0:     345800          XT-PIC  timer
>   1:       1452    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          0    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:         50    IO-APIC-edge  i8042
>  14:       6155    IO-APIC-edge  ide0
>  15:         42    IO-APIC-edge  ide1
>  16:        678   IO-APIC-level  bttv0, nvidia
>  17:        147   IO-APIC-level  aic7xxx, libata
>  18:        227   IO-APIC-level  eth0, b1pci-9c00
>  19:          7   IO-APIC-level  eth1
>  20:          0   IO-APIC-level  ohci_hcd
>  21:          0   IO-APIC-level  ehci_hcd
>  22:       1806   IO-APIC-level  NVidia nForce3, ohci_hcd
>
> If you run the latest -mm patch, you can fix the XT-PIC timer
> by passing "acpi_skip_timer_override" on the cmdline.
>

I will try this later, What does this timer-fix mean for my system?

> RE: USB is totally dead.
> you've got a number of controllers, are they all dead.
> hard to tell if the last one if taking the interrupts,
> or if that is your sound.  perhaps you can disable sound
> and see if IRQ22 becomes quiescent.
>

I have stopped the sound and have removed all sound modules (Init-script did 
this for me ;-) ) I have checked, if the modules had been removed (lsmod). I 
did a cat /proc/interrupts and: IRQ22 had ohci_hcd for itself. After that I 
tried to do a hotplug restart, but the init-script was unable to restart it. 
It did nothing, just waiting. I could not break it with CTRL+C.
So, USB does not work, even when sound is not running.

I also tested my SCSI-controller, but that seems to work okay, although it had 
some problems aborting a command (I copied a 400MB file and pressed CTRL+C 
after about 230MB). Here is the output:

Apr 25 19:49:34 [kernel] ISOFS: changing to secondary root
Apr 25 19:52:43 [kernel] scsi1:0:4:0: Attempting to queue an ABORT message
                - Last output repeated 3 times -
Apr 25 19:53:28 [kernel] Recovery code awake
Apr 25 19:53:28 [kernel] scsi1 (4:0): rejecting I/O to offline device

> Re: TV station change freezes system.
> Does it also freeze the system if you boot with "noapic"?
>

I have booted the system without specifying apic (Seems to be noapic, because 
of XT-PIC in /proc/interrupts) and with lapic. In both cases, TV is working 
without any problems. Only specifying apic explicitly, freezes the system.

Regards

Christian
