Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbRBJAt5>; Fri, 9 Feb 2001 19:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbRBJAtt>; Fri, 9 Feb 2001 19:49:49 -0500
Received: from quattro.sventech.com ([205.252.248.110]:16400 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130916AbRBJAtj>; Fri, 9 Feb 2001 19:49:39 -0500
Date: Fri, 9 Feb 2001 19:49:34 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: John Cavan <johnc@damncats.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mucho timeouts on USB
Message-ID: <20010209194934.J23514@sventech.com>
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org>; from John Cavan on Fri, Feb 09, 2001 at 07:22:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001, John Cavan <johnc@damncats.org> wrote:
> Just got a D-Link USB radio (R100) and I'm seeing lots of timeouts with
> it. I've seen this through the last few 2.4.1+ and -ac+ kernels.
> 
> Current config:
> 
> Dual P3-500 w/ 512mb of RAM
> Tyan Tiger 133 mobo with VIA chipset, onboard USB
> Kernel 2.4.1-ac9 compiled with egcs-1.1.2
> 
> The only thing funky is that three devices are sharing an interrupt:
> 
>            CPU0       CPU1       
>   0:     216690     219652    IO-APIC-edge  timer
>   1:       3564       3816    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          7         20    IO-APIC-edge  serial
>   5:       1017       1135   IO-APIC-level  EMU10K1
>   8:          0          1    IO-APIC-edge  rtc
>  11:      22978      22756   IO-APIC-level  aic7xxx, eth0, usb-uhci
>  12:      64220      63272    IO-APIC-edge  PS/2 Mouse
>  14:      12132      12810    IO-APIC-edge  ide0
>  15:          3         10    IO-APIC-edge  ide1
> NMI:     436327     436327 
> LOC:     436151     436128 
> ERR:          0
> 
> The ethernet card is a 3Com 3c905, the SCSI card is Adaptec 7892B (19160
> card). No problems with either as far as I can tell, but one of these
> modules may not be playing nice with interrupt sharing.
> 
> The messages:
> 
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.251 $ time 17:33:47 Feb  9 2001
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=2 (error=-110)
> usb.c: USB device 3 (vend/prod 0x4b4/0x1002) is not claimed by any
> active driver.
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout

Looks like an IRQ routing problem. We've seen a lot of these and I'm not
sure why the current IRQ routing code doesn't work correctly on some
systems but works fine on others.

Does anyone have any idea why it's not working for him?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
