Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWGGBPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWGGBPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGGBPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:15:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751136AbWGGBPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:15:12 -0400
Date: Thu, 6 Jul 2006 18:14:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Scott J. Harmon" <harmon@ksu.edu>
Cc: vsu@altlinux.ru, linux-kernel@vger.kernel.org, cw@f00f.org
Subject: Re: acpi gets wrong interrupt for via sata in 2.6.16.17
Message-Id: <20060706181453.3ce5a1c5.akpm@osdl.org>
In-Reply-To: <44ADAB1F.6040208@ksu.edu>
References: <449DE6BA.2050206@ksu.edu>
	<20060625132457.4b0922b4.vsu@altlinux.ru>
	<44A1C78C.4090401@ksu.edu>
	<44ADAB1F.6040208@ksu.edu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 19:30:23 -0500
"Scott J. Harmon" <harmon@ksu.edu> wrote:

> Scott J. Harmon wrote:
> > 
> > Sergey Vlasov wrote:
> >> On Sat, 24 Jun 2006 20:28:26 -0500 Scott J. Harmon wrote:
> >>
> >>> The short: something that came in 2.6.16.17 has caused my sata to no
> >>> longer work correctly (by work correctly, I mean actually be able to
> >>> detect any drives).  I'm no expert, but it seems that it is getting the
> >>> wrong interrupt.  In 2.6.16.16 it works fine with the exact same config.
> >>>  It also works fine if I append 'pci=noacpi'.  This has still happens in
> >>> 2.6.17.
> >> I assume that your root filesystem is on a SATA disk, and therefore you
> >> don't have an easy way to extract dmesg from a broken kernel?
> >>
> >>> Here is the output of lspci:
> >>>
> >>> scott@amdg:~$ /sbin/lspci
> >>> 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
> >>> Host Bridge (rev 80)
> >>> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> >>> 00:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
> >>> Gigabit Ethernet (rev 03)
> >>> 00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> >>> Controller (rev 46)
> >>> 00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> >>> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
> >>> Controller (rev 80)
> >>> 00:0f.1 IDE interface: VIA Technologies, Inc.
> >>> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> >>> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> >>> Controller (rev 81)
> >>> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> >>> Controller (rev 81)
> >>> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> >>> Controller (rev 81)
> >>> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> >>> Controller (rev 81)
> >>> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> >>> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
> >>> [KT600/K8T800/K8T890 South]
> >>> 01:00.0 VGA compatible controller: nVidia Corporation NV15DDR [GeForce2
> >>> Ti] (rev a4)
> >> Try to revert these patches:
> >>
> >> http://kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=commitdiff_plain;h=dc0f369552b491d1578e8a8c6f6512e17246241c
> >>
> >> http://kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=commitdiff_plain;h=c72493379d4aaac49ad3366987db1e118bb4f5ba
> >>
> >> (revert in the above order - these are two patches which depend on each
> >> other, you need to revert both).  You can try it both with 2.6.16.17
> >> and 2.6.17.
> > 
> > Ok, reverting these two patches caused ACPI to function again here.  Let
> > me know if there is anything else you need from me to get this fixed in
> > mainline.
> > 
> >> Chris: seems that the SATA subdevice (1106:3149) also needs the quirk,
> >> like EHCI, sound and builtin network.
> > 
> > Thanks,
> > 
> > Scott.
> 
> Is this going to be merged into 2.6.16.x and 2.6.17.x?
> 

I have both reversion patches queued up but haven't heard from anyone about
anything.  I don't know if anyone's working on this bug.

Thursday is my subsystem-maintainer-spamming day, so the reverts will be
heading Gregwards today.

