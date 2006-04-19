Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWDSPlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWDSPlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWDSPlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:41:13 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:15240 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750913AbWDSPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:41:12 -0400
Date: Wed, 19 Apr 2006 17:41:06 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: =?iso-8859-1?B?THVr4T8/?= Turek <turek.lukas@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange ACPI bug after resume
Message-ID: <20060419154106.GA13102@rhlx01.fht-esslingen.de>
References: <200604191727.01688.turek.lukas@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604191727.01688.turek.lukas@centrum.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 19, 2006 at 04:27:01PM +0100, Luká?? Turek wrote:
> I recently upgraded kernel on my Asus M6V notebook, and found a strange 
> problem:
> If I do suspend to RAM and then suspend to disk (swsusp or suspend2), after 
> resume every proces which tries to read from /proc/acpi/* freezes, starts to 
> take 100% of CPU and can't be killed (even with kill -9). Repeated suspend to 
> ram or suspend to disk is OK, only this combination triggers it.

Please enable CONFIG_MAGIC_SYSRQ, go to a text console and press Alt-SysRq-T
to see where exactly in the kernel code this process is trapped.

> It worked fine in 2.6.14. I used git-bisect and found commit 
> 89fbb69c4f285019ba5e029963dc11cc6beb078a. It is a 300kB patch, but luckily 
> most of it are drivers i don't use. And in drivers/pci/quirks.c my notebook 
> was directly mentioned:
> 
> if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB) {
>   switch (dev->subsystem_device) {
>   case 0x1882: /* M6V notebook */
>     asus_hides_smbus = 1;
>   }
> }
> 
> When i simply changed it to "asus_hides_smbus = 0;" the problem goes away - 
> but it isn't a real solution, because hardware sensors obviously go away too. 
> The problem might be somewhere in SMBus - but it happens also when no I2C and 
> Hardware Monitoring modules are loaded at all! 

Perhaps ASUS hides SMBus since they know that they have incomplete/buggy BIOS
support for it, thus an activated SMBus would cause crashes during
power management stuff? Just a horrible thought, but it might actually be true.

Andreas Mohr
