Return-Path: <linux-kernel-owner+w=401wt.eu-S964987AbWLMOky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWLMOky (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWLMOky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:40:54 -0500
Received: from homer.mvista.com ([63.81.120.155]:13832 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964974AbWLMOkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:40:53 -0500
X-Greylist: delayed 1541 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 09:40:52 EST
Message-ID: <45800B4D.8000906@ru.mvista.com>
Date: Wed, 13 Dec 2006 17:16:45 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
References: <200612130148.34539.sshtylyov@ru.mvista.com> <20061212234145.557cb035@localhost.localdomain>
In-Reply-To: <20061212234145.557cb035@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan wrote:

>>+ * We work around this by initiating dummy, zero-length DMA transfer on
>>+ * a DMA timeout expiration. I found no better way to do this with the current

> Novel workaround and probably better than resetting the chip as the
> winbong does.

    I didn't try resetting however the datasheet suggests it just won't do.

>>+static int tc86c001_busproc(ide_drive_t *drive, int state)
>>+{

> Waste of space having a busproc routine. The maintainer removed all the
> usable hotplug support from old IDE so this might as well be dropped.

    Don't know what you mean, ioctl is still there...

>>@@ -1407,6 +1407,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);

>>+/*
>>+ * Toshiba TC86C001 IDE controller reports the standard 8-byte BAR0 size
>>+ * but PIO transfer won't work if BAR0 falls at the odd 8 bytes.
>>+ * Re-allocate the region if needed.
>>+ */

> NAK. I think this fixup should be testing if the device port 0 is in
> native mode before doing the fixup. In comaptibility mode bar 0 is

    The chip is native mode only.

> "Close but no cookie": please fix the PCI quirk to match the current -mm
> behaviour with the ATA resource tree. Otherwise - nice driver.

    Ugh, I should've expected some backstab from -mm tree...

> Alan

WBR, Sergei
