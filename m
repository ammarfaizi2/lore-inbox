Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUI0AEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUI0AEi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 20:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUI0AEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 20:04:38 -0400
Received: from bianca.affordablehost.com ([216.46.192.8]:51640 "EHLO
	bianca.affordablehost.com") by vger.kernel.org with ESMTP
	id S265093AbUI0AEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 20:04:35 -0400
Date: Sun, 26 Sep 2004 17:02:39 -0700
From: "Randy.Dunlap" <rddunlap@xenotime.net>
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help Requested with patching "drivers/pci/quirks.c"
Message-Id: <20040926170239.1b5ba3ae.rddunlap@xenotime.net>
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C54@psexc03.nbnz.co.nz>
References: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C54@psexc03.nbnz.co.nz>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bianca.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 11:53:00 +1200 Roberts-Thomson, James wrote:

| Randy Dunlap wrote:
| 
| > Try "lspci -n".
| 
| OK, on the 2.4.27 machine, lspci displays an entry for the SMBus device
| (once the p4b_smbus module is loaded), thus:
| 
| 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
| Controller (rev 01)
| 
| which lspci -n identifies as 
| 
| 0000:00:1f.3 Class 0c05: 8086:24c3 (rev 01)
| 
| In pci_ids.h, 0x0c05 is "PCI_CLASS_SERIAL_SMBUS", and "24c3" is a
| "PCI_DEVICE_ID_INTEL_82801DB_3".  So, thanks to your help, I've found the
| dev->device entry I need; but where do I get the dev->subsystem_device value
| from?  I'm willing to believe I have the information and that I just don't
| recognise what it is - that is my problem.

Yes, lspci will show that also.

lspci -x -d 8086:24c3           (2443 in my case, below)

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00: 86 80 43 24 01 00 80 02 05 00 05 0c 00 00 00 00
    vv vv dd dd
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ef 00 00 00 00 00 00 00 00 00 00 86 80 54 50
                                        yy yy zz zz
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00

Vendor ID is vvvv.  Device ID is dddd.
Subsystem vendor ID is yyyy and subsystem device ID is zzzz.
All multi-byte fields are in low-high order (little endian)
(in the PCI header).

--
~Randy
