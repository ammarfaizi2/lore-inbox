Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUHCV2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUHCV2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUHCV2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:28:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65225 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266876AbUHCV2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:28:32 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Tue, 3 Aug 2004 14:28:25 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040803211948.59456.qmail@web14921.mail.yahoo.com>
In-Reply-To: <20040803211948.59456.qmail@web14921.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031428.25853.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 2:19 pm, Jon Smirl wrote:
> This is saying that my AGP bridge chip has a ROM right?
>
> 00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev
> 02) (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, fast devsel, latency 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: fe900000-feafffff
>         Prefetchable memory behind bridge: f0000000-f7ffffff
>         Expansion ROM at 0000d000 [disabled] [size=4K]
>
> Each of my video controllers has one too:
>
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If
> [Radeon 9000] (rev 01) (prog-if 00 [VGA])
>         Subsystem: C.P. Technology Co. Ltd RV250 If [Radeon 9000 Pro
> "Evil Commando"]
>         Flags: stepping, 66Mhz, medium devsel, IRQ 177
>         Memory at f4000000 (32-bit, prefetchable) [disabled]
> [size=fea00000]
>         I/O ports at de00 [disabled] [size=256]
>         Memory at fe9e0000 (32-bit, non-prefetchable) [disabled]
> [size=64K]
>         Expansion ROM at 00020000 [disabled]
>         Capabilities: <available only to root>
>
> 02:02.0 VGA compatible controller: ATI Technologies Inc Rage 128 PD/PRO
> TMDS (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Rage 128 AIW
>         Flags: bus master, stepping, medium devsel, latency 64, IRQ 209
>         Memory at f8000000 (32-bit, prefetchable) [size=fe800000]
>         I/O ports at ce00 [size=256]
>         Memory at fe7dc000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at 00020000 [disabled]
>         Capabilities: <available only to root>
>
> Both of the video ROMs are at 00020000, won't they end up on top of
> each other when enabled?

Yeah, it doesn't look like they've been properly assigned addresses.  But then 
I've also seen lspci lie, you can check /sys/devices/.../config for the 
actual resource values.  If they're sane then things are more likely to work.

Jesse
