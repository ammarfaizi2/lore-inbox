Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUCGNsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUCGNsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:48:37 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19387 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261981AbUCGNsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:48:33 -0500
Date: Sun, 7 Mar 2004 14:48:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
Message-ID: <20040307134827.GA8506@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031028013013.GA3991@kroah.com> <200310280300.h9S30Hkw003073@napali.hpl.hp.com> <3FA12A2E.4090308@pacbell.net> <16289.29015.81760.774530@napali.hpl.hp.com> <16289.55171.278494.17172@napali.hpl.hp.com> <3FA28C9A.5010608@pacbell.net> <16457.12968.365287.561596@napali.hpl.hp.com> <404959A5.6040809@pacbell.net> <16457.38721.119739.816533@napali.hpl.hp.com> <404A0AB7.5020603@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404A0AB7.5020603@pacbell.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Mar 2004, David Brownell wrote:

> That's really the only place the HCD does anything
> that could corrupt the ED queues, which is what looks
> to be happening.

I have a situation that may or may not be related, but it makes 2.6 USB
unusable, so I'll just report it.

I have USB lockups with various 2.6.3 variants, including 2.6.4-rc2, on
a VIA KT600 (Via 8237 south bridge). Linux 2.4.25 and newer (BitKeeper version)
behave well, so does FreeBSD 5-CURRENT on the same computer (dual boot), and
apparently the 2.6.3 kernels are fine on a VIA KT133 (Via 82C686 south bridge -
older variant with UDMA66 only).

During a scan attempt with an Epson 1650 (USB 1.1, hence UHCI) I caught these
logs in dmesg, the USB subsystem is dead now (2.6.4-rc2). I don't have
USB 2.0 hardware so I cannot check if EHCI would be fine.

usb 3-2: usb_disable_device nuking non-ep0 URBs
usb 3-2: unregistering interface 3-2:1.0
drivers/usb/core/usb.c: usb_hotplug
usb 3-2: registering 3-2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usb 3-2: usb_disable_device nuking non-ep0 URBs
usb 3-2: unregistering interface 3-2:1.0
drivers/usb/core/usb.c: usb_hotplug
usb 3-2: registering 3-2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
uhci_hcd 0000:00:10.1: uhci_result_control: failed with status 440000
[ccdc8270] link (0cdc81e2) element (0ced4140)
  0: [cced4140] link (0ced4180) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0c446380)
  1: [cced4180] link (0ced41c0) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=06997000)
  2: [cced41c0] link (0ced4200) e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=06997008)
  3: [cced4200] link (0ced4240) e3 SPD Active Length=0 MaxLen=1 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=06997010)
  4: [cced4240] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 18 ret -110
uhci_hcd 0000:00:10.1: uhci_result_control: failed with status 500000
[ccdc82a0] link (0cdc81e2) element (0ced4300)
 Element != First TD
  0: [cced4280] link (0ced42c0) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0c446b00)
  1: [cced42c0] link (0ced4300) e3 Length=7 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=03235000)
  2: [cced4300] link (0ced4340) e3 Stalled Babble Length=0 MaxLen=0 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=03235008)
  3: [cced4340] link (0cdc82d2) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
--Queued QH's:
[ccdc82d0] link (0cdc81e2) element (0ced4380)
  0: [cced4380] link (0ced43c0) e3 Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0c446380)
  1: [cced43c0] link (0ced4400) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=06997000)
  2: [cced4400] link (0ced4440) e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=06997008)
  3: [cced4440] link (0ced4480) e3 SPD Active Length=0 MaxLen=1 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=06997010)
  4: [cced4480] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -75
usb 3-2: control timeout on ep0in
usb 3-2: control timeout on ep0in
usb 3-2: control timeout on ep0in
usb 3-2: bulk timeout on ep1out


-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
