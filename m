Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbUK3VAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbUK3VAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUK3U7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:59:38 -0500
Received: from ida.rowland.org ([192.131.102.52]:33796 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262323AbUK3U6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:58:18 -0500
Date: Tue, 30 Nov 2004 15:58:17 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Fabio Coatti <cova@ferrara.linux.it>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: 2.6.10-rc2-mm2 usb storage still oopses
In-Reply-To: <200411302027.56951.cova@ferrara.linux.it>
Message-ID: <Pine.LNX.4.44L0.0411301555260.1423-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Fabio Coatti wrote:

> The only small issue is that if i leave plugged the usb flash key and 
> power-cycle my box, at boot the device is not detected and it fails in the 
> same way it happens when usbcore old_scheme_first is not set (it's present in 
> modprobe.conf)
> 
> If I unplug/plug the device, all works just fine.

> Now, rebooting the box leaving the device inserted, with old_scheme_first=1 in 
> modprobe.conf
> 
> Nov 30 20:03:40 kefk kernel: usb 4-0:1.0: hotplug
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: usb_probe_interface
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: usb_probe_interface - got id
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: USB hub found
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: 2 ports detected
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: standalone hub
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: no power switching (usb 1.0)
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: individual port over-current 
> protection
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: power on to power good time: 2ms
> Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: local power source is good
> Nov 30 20:03:40 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
> 100ms status 0x101
> Nov 30 20:03:40 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
> and address 2
> Nov 30 20:03:40 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
> failed with status 440000
> Nov 30 20:03:40 kefk kernel: [f7ab5240] link (37ab51b2) element (37ab4040)
> Nov 30 20:03:40 kefk kernel:   0: [f7ab4040] link (37ab4080) e0 Stalled 
> CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37998f20)
> Nov 30 20:03:40 kefk kernel:   1: [f7ab4080] link (00000001) e3 IOC Active 
> Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
> Nov 30 20:03:40 kefk kernel:
> Nov 30 20:03:40 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
> failed with status 440000
> Nov 30 20:03:40 kefk kernel: [f7ab5240] link (37ab51b2) element (37ab4040)
> Nov 30 20:03:40 kefk kernel:   0: [f7ab4040] link (37ab4080) e0 Stalled 
> CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=378ef180)
> Nov 30 20:03:40 kefk kernel:   1: [f7ab4080] link (00000001) e3 IOC Active 
> Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
> Nov 30 20:03:40 kefk kernel:
> Nov 30 20:03:40 kefk kernel: usb 2-1: device not accepting address 2, error 
> -71
> Nov 30 20:03:40 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
> and address 3
> Nov 30 20:03:40 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
> failed with status 440000
> Nov 30 20:03:40 kefk kernel: [f7ab5240] link (37ab51b2) element (37ab4040)
> Nov 30 20:03:40 kefk kernel:   0: [f7ab4040] link (37ab4080) e0 Stalled 
> CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=378ef180)
> Nov 30 20:03:40 kefk kernel:   1: [f7ab4080] link (00000001) e3 IOC Active 
> Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
> 
> After this, if I remove and plug again the device, all works just fine.

This log shows that the device was operating at full speed, not at high 
speed.  Probably your boot-up sequence involves loading the uhci-hcd 
driver before ehci-hcd.

It may be that the device wants old_scheme_first to be set when it's 
operating at high speed and not set when operating at full speed!  You can 
test this guess by unloading one driver or the other and then plugging in 
the device.

Alan Stern

