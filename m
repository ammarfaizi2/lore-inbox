Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270532AbTGNFil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270535AbTGNFik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:38:40 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:18960 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270532AbTGNFib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:38:31 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Yenta_socket lsPCI IRQ reads incorrect
Date: Mon, 14 Jul 2003 13:41:44 +0800
User-Agent: KMail/1.5.2
Cc: Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307141333.03911.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[mhf@mhfl2 13:40:27 mhf]$ cat /proc/interrupts
           CPU0
  0:    1242348          XT-PIC  timer
  1:       5253          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:         88          XT-PIC  Toshiba America Info ToPIC95 PCI to Cardb, serial
  8:          0          XT-PIC  rtc
  9:        162          XT-PIC  acpi
 10:       1003          XT-PIC  eth0
 12:      23967          XT-PIC  i8042
 14:       8698          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          5
MIS:          0


lspci shows that IRQ level: byte 3C is FF, it should be 5

00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
00: 79 11 17 06 00 00 90 04 32 00 07 06 00 40 82 00
10: 00 10 00 10 80 00 80 04 00 01 04 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

When this value is used by pci_restore_state, interrupt 
obviously dies.

Dunno if this is hardware readback fault or driver issue.

Regards
Michael


-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

