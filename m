Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWGGPCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWGGPCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWGGPCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:02:05 -0400
Received: from igw1.zrnko.cz ([81.31.45.160]:18914 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S932176AbWGGPCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:02:04 -0400
Date: Fri, 7 Jul 2006 17:02:29 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.6.17-git14 and PCI suspend/resume
Message-ID: <20060707150229.GB2689@mail.muni.cz>
References: <20060703231121.GB2752@mail.muni.cz> <20060703232109.GA18605@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060703232109.GA18605@suse.de>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 03, 2006 at 04:21:09PM -0700, Greg KH wrote:
> When suspending, pci_save_state() would have saved off those values (all
> 1s) which is what it is restoring.  That function gets called if there
> is no driver specific suspend function to call.  On suspend, is there
> any driver loaded for the device?

I was playing a little with various versions to see what has changed.
It looks that somewhere after 2.6.17-rc6 just printk message was added and
pci_save/restore_state newer worked for me.

The strange is that only some of devices are unable to save pci config.

According to lspci -t my PCI tree looks like this:

(Devices marked with * do not save config correctly. The others are OK. None of marked devices is claimed by any driver in kernel, as well as IPW2915ABG device is not claimed by any driver, but this device is restored correctly.)

# lspci -t
-[0000:00]-+-00.0
           +-01.0-[0000:03]--
           +-02.0
           +-02.1
           +-1b.0
           +-1d.0
           +-1d.1
           +-1d.2
           +-1d.3
           +-1d.7
           +-1e.0-[0000:01-02]--+-00.0
           |                    +-01.0 *
           |                    +-01.1 *
           |                    +-01.2 *
           |                    +-01.3 *
           |                    +-01.4 *
           |                    \-02.0
           +-1f.0
           \-1f.1

This is plain lspci:
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Gr aphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) US B UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) US B UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) US B UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) US B UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) US B2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04)
01:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
01:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
01:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08)
01:01.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 17)
01:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter (rev 08)
01:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 03)
01:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG Network Connection (rev 05)


-- 
Luká¹ Hejtmánek
