Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVANXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVANXHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVANXCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:02:14 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:27604 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S261965AbVANXBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:01:38 -0500
Date: Sat, 15 Jan 2005 00:01:28 +0100
Message-Id: <764381258@web.de>
MIME-Version: 1.0
From: "Enrico Bartky" <DOSProfi@web.de>
To: "MatthewDharm" <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lspci != scanpci !?
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel config I have aktivate the direct pci-access.


Matthew Dharm <mdharm-kernel@one-eyed-alien.net> schrieb am 14.01.05 23:37:23:

On Fri, Jan 14, 2005 at 09:57:00PM +0100, Enrico Bartky wrote:
> Hello,
> 
> I have a Gigabyte GA-5AA Board with ALi Aladdin IV Chipset ( 1533, 1541 ). I
> tried to get the smbus to work, but Gigabyte have disabled it and I can't
> activate it in the BIOS. I use kernel 2.6.10 and looked at the m7101-hotplug
> for kernel 2.4-module from lm_sensors. I added the following to
> drivers/pci/quirks.c:
> 
> ....
> /* ALi 1533 fixup to enable the M7101 SMBus Controller
> * ported from prog/hotplug of the lm_sensors
> * package
> */
> static void __devinit quirk_ali1533_smbus(struct pci_dev *dev)
> {
> u8 val = 0;
> 
> pci_read_config_byte ( dev, 0x5F, &val );
> if ( val & 0x4 )
> {
> pci_write_config_byte ( dev, 0x5F, val & 0xFB );
> }
> }
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
> quirk_ali1533_smbus );
> ....
> 
> Now the scanpci command shows the M7101 BUT lspci and /proc/pci,
> /proc/bus/pci, /sys/bus/pci NOT. What can I do? Is there anything like a
> "update_pci" command?

I think there is a kernel command-line parameter you can use to tell the
kernel to ignore the BIOS-supplied PCI map and generate it's own via
scanning (ala what scanpci does).

Matt

-- 
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.net 
Maintainer, Linux USB Mass Storage Driver

Department of Justice agent.  I have come to purify the flock.
					-- DOJ agent
User Friendly, 5/22/1998



__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201

