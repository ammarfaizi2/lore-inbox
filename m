Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUDFGaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbUDFGaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:30:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:43650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263631AbUDFGaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:30:20 -0400
Date: Mon, 5 Apr 2004 23:30:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] 2.6.5- es7000 subarch update
Message-Id: <20040405233010.00f551c5.akpm@osdl.org>
In-Reply-To: <452548B29F0CCE48B8ABB094307EBA1C04C55160@USRV-EXCH2.na.uis.unisys.com>
References: <452548B29F0CCE48B8ABB094307EBA1C04C55160@USRV-EXCH2.na.uis.unisys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> wrote:
>
> ES7000 was failing to boot since first couple revisions of 2.6. The patch fixes the boot problem. 
>  In the patch, some maintenance and cleanup was done for es7000 subarch, such as APIC destinations were corrected, missing initialization for the variable was added, extraneous file was removed, etc.
>  The patch was created against 2.6.5, compiled  cleanly, and tested on the ES7000 system.

This patch appears to cause the local-apic based time interrupts to run too
fast on my old 4-way Xeon server.  A `sleep 10' takes about five seconds.

Diffing the dmesg output shows the changes which your patch caused:

--- without	2004-04-05 22:18:41.061198208 -0700
+++ with	2004-04-05 22:17:15.000000000 -0700
@@ -1,4 +1,4 @@
- IO-APIC (apicid-pin) 4-0, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 4-24, 4-25, 4-26, 4-27, 4-28, 4-29, 4-30, 4-31, 4-32, 4-33, 4-34, 4-35, 4-36, 4-37, 4-38, 4-39, 4-40, 4-41, 4-42, 4-43, 4-44, 4-45, 4-46, 4-47, 4-48, 4-49, 4-50, 4-51, 4-52, 4-53, 4-54, 4-55, 4-56, 4-57, 4-58, 4-59, 4-60, 4-61, 4-62, 4-63 not connected.
-..TIMER: vector=0x31 pin1=2 pin2=-1
+ IO-APIC (apicid-pin) 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 4-24, 4-25, 4-26, 4-27, 4-28, 4-29, 4-30, 4-31, 4-32, 4-33, 4-34, 4-35, 4-36, 4-37, 4-38, 4-39, 4-40, 4-41, 4-42, 4-43, 4-44, 4-45, 4-46, 4-47, 4-48, 4-49, 4-50, 4-51, 4-52, 4-53, 4-54, 4-55, 4-56, 4-57, 4-58, 4-59, 4-60, 4-61, 4-62, 4-63 not connected.
+..TIMER: vector=0x31 pin1=0 pin2=-1


-number of MP IRQ sources: 15.
+number of MP IRQ sources: 16.


 .... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
- 00 000 00  1    0    0   0   0    0    0    00
+ 00 00F 0F  0    0    0   0   0    1    1    31
  01 00F 0F  0    0    0   0   0    1    1    39
  02 00F 0F  0    0    0   0   0    1    1    31
  03 00F 0F  0    0    0   0   0    1    1    41
@@ -368,7 +368,7 @@
  3e 000 00  1    0    0   0   0    0    0    00
  3f 000 00  1    0    0   0   0    0    0    00
 IRQ to pin mappings:
-IRQ0 -> 0:2
+IRQ0 -> 0:0-> 0:2
 IRQ1 -> 0:1
 IRQ3 -> 0:3
 IRQ4 -> 0:4

