Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUJGPpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUJGPpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUJGPpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:45:49 -0400
Received: from mail.aei.ca ([206.123.6.14]:50891 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267410AbUJGPo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:44:29 -0400
Subject: VP and Promise dma_timer_expiry: dma status == 0x24 error
From: Shane Shrybman <shrybman@aei.ca>
To: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Cc: svetljo@gmx.de, alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Message-Id: <1097163851.5796.65.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 11:44:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Alan, Svetoslav,

I have finally made a bit of progress in narrowing down the source of
the Promise ide controller dma_timer_expiry errors in recent -mm/VP
kernels.

I have copied Svetoslav Slavtchev because he was also experiencing the
problem, (What is your current status re this issue Svetoslav?). And
Alan because he was responding to other folks regarding this error
message.

hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt
[..many repeats..never recovers..]

I got side tracked when recent -mm started spontaneously rebooting
during bootup. I resolved that by switching from gcc 2.95 to 3.2.3.

Now, 2.6.9-rc3mm2T1 with acpi=off (with the ivtv driver) has been
running OK for 24 hours.

<wild guess>
kernel: ** PCI interrupts are no longer routed automatically.  If this
kernel: ** causes a device to stop working, it is probably because the
kernel: ** driver failed to call pci_enable_device().  As a temporary
kernel: ** workaround, the "pci=routeirq" argument restores the old
kernel: ** behavior.  If this argument makes the device work again,
kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
kernel: ** so I can fix the driver.

I see the above in the logs and a quick grep of pdc202xx_new.c shows no
call to pci_enable_device. Could this possibly be the source of the
problem?

Regards,

Shane




