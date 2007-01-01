Return-Path: <linux-kernel-owner+w=401wt.eu-S1755242AbXAARH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbXAARH5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 12:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbXAARH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 12:07:57 -0500
Received: from mx33.mail.ru ([194.67.23.194]:2915 "EHLO mx33.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242AbXAARH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 12:07:56 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] OHCI: disallow autostop when wakeup is not available
Date: Mon, 1 Jan 2007 20:07:51 +0300
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611141623380.6666-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611141623380.6666-100000@iolanthe.rowland.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701012007.52396.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 15 November 2006 00:28, Alan Stern wrote:
> This patch (as822) prevents the OHCI autostop mechanism from kicking in
> if the root hub is not able or not allowed to issue wakeup requests.
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>
> ---
>
> Greg:
>
> This patch should go into 2.6.19-rc ASAP.  It does solve a real problem.
> The larger-scale changes Dave and I have been discussing will be submitted
> separately, for inclusion in 2.6.20.
>

Is the original problem (OHCI constantly attempting and failing to suspend 
root hub) supposed to be fixed in 2.6.20? Currently in rc3 I have

ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.0: enabling initreset quirk
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3(3)
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.20-rc3-1avb ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
/home/bor/src/linux-git/drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.0: auto-stop root hub
ohci_hcd 0000:00:02.0: auto-wakeup root hub
ohci_hcd 0000:00:02.0: auto-stop root hub
ohci_hcd 0000:00:02.0: auto-wakeup root hub
...

and it goes on and on until I stop it manually by usual method:

usb usb1: remote wakeup needed for autosuspend

Welcome to new year :)

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFmT/oR6LMutpd94wRAtqLAJ4yNCupGqAC8G6hkAxvuXrW7Jr7KQCgrgyE
ZZ5Sd4qeeVy+NiGHjNZ6yR8=
=Gwng
-----END PGP SIGNATURE-----
