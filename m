Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266605AbUGPRVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266605AbUGPRVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUGPRVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:21:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:15079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266605AbUGPRTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:19:43 -0400
X-Authenticated: #689055
Message-ID: <40F41D22.5080603@gmx.de>
Date: Tue, 13 Jul 2004 19:34:26 +0200
From: Torsten Scheck <torsten.scheck@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PIIX4 ACPI device - hardwired IRQ9
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends:

Please excuse my ignorance: Does the indicated line below have any other 
purpose apart from making me comment it and recompile the kernel to get 
my soundcard working? ;-)

kernel-source-2.4.26/arch/i386/kernel/pci-pc.c
static void __devinit pci_fixup_piix4_acpi(struct pci_dev *d)
         /* PIIX4 ACPI device: hardwired IRQ9 */
  ===>   d->irq = 9;

$ isapnp /etc/isapnp.conf
/etc/isapnp.conf:167 -- Fatal - resource conflict allocating IRQ9
(see pci)
/etc/isapnp.conf:167 -- Fatal - Error occurred executing request
'IRQ 9' --- further action aborted

My soundcard is a Terratec EWS64 XL. I successfully use the 
sam9407-1.0.4 driver after a proper isapnp configuration, i.e. comment 
the hardwired IRQ9 line, compile the kernel, run isapnp.


If there should be really no other purpose I recommend to comment the 
line, so I can use a precompiled kernel from now on. :-)

kernel-source-2.4.26/arch/i386/kernel/pci-pc.c
static void __devinit pci_fixup_piix4_acpi(struct pci_dev *d)
         /* PIIX4 ACPI device: hardwired IRQ9 */
         /* d->irq = 9; */


Or maybe there is some method to deactivate hardwired irqs with boot 
parameters? My first experiments (without a clue about kernel internals) 
using kernel boot parameters like 'acpi=', 'pci=irqmask=0xMMMM' failed, 
though.


Please CC me, if you want me to read your reply asap.

All the best-
Torsten Scheck


