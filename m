Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVANU6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVANU6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVANU56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:57:58 -0500
Received: from smtp08.web.de ([217.72.192.226]:54692 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262138AbVANU5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:57:07 -0500
Message-ID: <003d01c4fa7b$983b21b0$0c00a8c0@amd64>
From: "Enrico Bartky" <DOSProfi@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: lspci != scanpci !?
Date: Fri, 14 Jan 2005 21:57:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4942.400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Gigabyte GA-5AA Board with ALi Aladdin IV Chipset ( 1533, 1541 ). I
tried to get the smbus to work, but Gigabyte have disabled it and I can't
activate it in the BIOS. I use kernel 2.6.10 and looked at the m7101-hotplug
for kernel 2.4-module from lm_sensors. I added the following to
drivers/pci/quirks.c:

....
/* ALi 1533 fixup to enable the M7101 SMBus Controller
* ported from prog/hotplug of the lm_sensors
* package
*/
static void __devinit quirk_ali1533_smbus(struct pci_dev *dev)
{
u8 val = 0;

pci_read_config_byte ( dev, 0x5F, &val );
if ( val & 0x4 )
{
pci_write_config_byte ( dev, 0x5F, val & 0xFB );
}
}
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
quirk_ali1533_smbus );
....

Now the scanpci command shows the M7101 BUT lspci and /proc/pci,
/proc/bus/pci, /sys/bus/pci NOT. What can I do? Is there anything like a
"update_pci" command?

Thanx,
EnricoB

