Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030636AbVIBBjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbVIBBjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbVIBBjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:39:36 -0400
Received: from tornado.reub.net ([202.89.145.182]:32643 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030636AbVIBBjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:39:35 -0400
Message-ID: <4317AD4D.6030001@reub.net>
Date: Fri, 02 Sep 2005 13:39:25 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050830)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
References: <fa.hqupr0d.1u3af35@ifi.uio.no>
In-Reply-To: <fa.hqupr0d.1u3af35@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/09/2005 10:58 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> 
> - Included Alan's big tty layer buffering rewrite.  This breaks the build on
>   lots of more obscure character device drivers.  Patches welcome (please cc
>   Alan).
> 
> 
> 
> Changes since 2.6.13-rc6-mm2:
> 
> 
>  linus.patch
>  git-acpi.patch
>  git-arm.patch
>  git-cpufreq.patch
>  git-cryptodev.patch
>  git-ia64.patch
>  git-audit.patch
>  git-audit-ppc64-fix.patch
>  git-input.patch
>  git-jfs-fixup.patch
>  git-kbuild.patch
>  git-libata-all.patch
>  git-mtd.patch
>  git-netdev-all.patch
>  git-nfs.patch
>  git-ocfs2.patch
>  git-serial.patch
>  git-scsi-block.patch
>  git-scsi-iscsi.patch
>  git-scsi-misc.patch
>  git-watchdog.patch

This patch:

netlink-log-protocol-failures.patch

is causing lots of messages like this to be logged on my console:

Sep  2 11:52:41 tornado kernel: DEBUG: Failed to load PF_NETLINK protocol 9

It seems to be caused by audit support not being enabled in as if I rebuild 
with audit support the message goes away :)


I'm also observing some USB messages logged:

Sep  2 13:26:22 tornado kernel: usb 5-1: new full speed USB device using 
uhci_hcd and address 13
Sep  2 13:26:22 tornado kernel: drivers/usb/class/usblp.c: usblp0: USB 
Bidirectional printer dev 13 if 0 alt 0 proto 2 vid 0x03F0 pid 0x6204
Sep  2 13:26:23 tornado kernel: hub 5-0:1.0: port 1 disabled by hub (EMI?), 
re-enabling...
Sep  2 13:26:23 tornado kernel: usb 5-1: USB disconnect, address 13
Sep  2 13:26:23 tornado kernel: drivers/usb/class/usblp.c: usblp0: removed
Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
uhci_hcd and address 14
Sep  2 13:26:23 tornado kernel: usb 5-1: device descriptor read/64, error -71
Sep  2 13:26:23 tornado kernel: usb 5-1: device descriptor read/64, error -71
Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
uhci_hcd and address 15
Sep  2 13:26:23 tornado kernel: usb 5-1: device descriptor read/all, error -71
Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
uhci_hcd and address 16
Sep  2 13:26:23 tornado kernel: usb 5-1: can't set config #1, error -71
Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
uhci_hcd and address 17
Sep  2 13:26:24 tornado kernel: usb 5-1: unable to read config index 0 
descriptor/start
Sep  2 13:26:24 tornado kernel: usb 5-1: can't read configurations, error -71

[root@tornado kernel]# lsusb
Bus 005 Device 004: ID 050d:0105 Belkin Components
Bus 005 Device 003: ID 0451:2046 Texas Instruments, Inc. TUSB2046 Hub
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
[root@tornado kernel]#

Output of lsusb -v up at http://www.reub.net/kernel/lsusb-output

reuben


