Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWAUDpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWAUDpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWAUDpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:45:16 -0500
Received: from mail.host.bg ([85.196.174.5]:54422 "EHLO mail.host.bg")
	by vger.kernel.org with ESMTP id S932272AbWAUDpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:45:14 -0500
Subject: Re: OOM Killer killing whole system
From: Anton Titov <a.titov@host.bg>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1137806248.4122.11.camel@mulgrave>
References: <1137337516.11767.50.camel@localhost>
	 <1137793685.11771.58.camel@localhost>
	 <20060120145006.0a773262.akpm@osdl.org>
	 <200601201819.58366.chase.venters@clientec.com>
	 <20060120165031.7773d9c4.akpm@osdl.org> <1137806248.4122.11.camel@mulgrave>
Content-Type: text/plain
Organization: Host.bg
Date: Sat, 21 Jan 2006 05:45:09 +0200
Message-Id: <1137815109.11771.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 19:17 -0600, James Bottomley wrote:
> There's another curiosity about this: the linux command stack is pretty
> well counted per scsi device (it's how we control queue depth), so if a
> driver leaks commands we see it not by this type of behaviour, but by
> the system hanging (waiting for all the commands the mid-layer thinks
> are outstanding to return).  So, the only way we could leak commands
> like this is in the mid-layer command return logic ... and I can't find
> anywhere this might happen.

Additionaly I've looked into Chase's dmesg and we seem to use pretty
much the same motherboard (at least Marvell NIC and ICH6 controller), so
it may be ICH6 issue? Or sk98lin (I have another sk98lin patched server,
which works well)?

just in case, here is lspci:

00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor
to I/O Controller (rev 0e)
00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL
Express Chipset Family Graphics Controller (rev 0e)
00:02.1 Display controller: Intel Corporation 82915G Express Chipset
Family Graphics Controller (rev 0e)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 2 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC
Interface Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW)
SATA Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
01:04.0 Mass storage controller: <pci_lookup_name: buffer too small>
(rev 13)
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E
Gigabit Ethernet Controller (rev 15)


