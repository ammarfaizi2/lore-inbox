Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWERPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWERPPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWERPPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:15:23 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:54464 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751362AbWERPPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:15:22 -0400
Date: Thu, 18 May 2006 17:15:20 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net
Subject: Re: How to enable bios-disabled soundcard?
Message-ID: <20060518151520.GA32572@rhlx01.fht-esslingen.de>
References: <Pine.SOC.4.61.0605181650080.4469@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0605181650080.4469@math.ut.ee>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[CC'ing ALSA list]

On Thu, May 18, 2006 at 05:09:47PM +0300, Meelis Roos wrote:
> Context: IBM X20 laptop with integrated PCI CS4281 soundcard. Loading 
> snd_cs4281 gives these messages and registers no alsa device:
> 
> ACPI: PCI interrupt for device 0000:00:0b.0 disabled
> CS4281: probe of 0000:00:0b.0 failed with error -5
> 
> Error -5 seems to be -EIO.
> 
> There is no option ib bios to enable/disable the soundcard and the bios 
> is almost the latest (2.23, latest 2.25 fixes only unrelated things by 
> changelog).

The mail subject most likely is wrong, since the IRQ message above
doesn't suggest a BIOS issue at all,
since the message is most likely a result of calling snd_cs4281_free()
in failure path, which disables this IRQ again.

> lspci identifies the card as follows (pci ID is the same as in the 
> driver):
> 0000:00:0b.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI 
> Audio (rev 01)
> 
> I tried pci=routeirq. It distributed the interrupts differently but this 
> problem did remain.

I believe that it's a simple hardware mismatch failure in the main probe
function of this driver, nothing else.

> So how can I enable the soundcard?

The best way to find out is to edit snd_cs4281_probe() and add snd_printk()s
at all error paths to find the one which actually fails.

Andreas Mohr
