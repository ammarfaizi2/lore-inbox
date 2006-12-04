Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936857AbWLDNsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936857AbWLDNsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936858AbWLDNsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:48:31 -0500
Received: from mpemail.mpe-garching.mpg.de ([130.183.137.110]:22934 "EHLO
	mpemail.mpe.mpg.de") by vger.kernel.org with ESMTP id S936857AbWLDNsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:48:30 -0500
From: "Martin A. Fink" <fink@mpe.mpg.de>
Organization: MPE
To: linux-kernel@vger.kernel.org
Subject: SATA-performance with AHCI
Date: Mon, 4 Dec 2006 14:48:20 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612041448.20176.fink@mpe.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

now I was able to do a performance test with an Intel ICH6R chipset.

Basic hardware data:
- Intel Pentium 4 Xeon at 3.2 GHz
- Intel ICH6R chipset, AHCI enabled
- Intel Hyperthreading On and Off
- 1 GB SDDR RAM
- SATA controller onboard (4x)
- SATA harddisks 250 GB

I used SuSE Linux 9.3 with Linux kernel 2.6.11.4-21.14-smp.

I tried to put data from memory to harddisk by writing blocks of 1 MB size 
with 2 GB overall filesize. And I got the following results:

SuSE 9.3 - 32-bit Installation - Hyperthreading Off:
 - CPU time 16% (sys, approx. 0% user) - Write speed 40-45 MB/s
SuSE 9.3 - 64-bit Installation - Hyperthreading Off:
 - CPU time 14% (sys, approx. 0% user) - Write speed 50-60 MB/s
SuSE 9.3 - 64-bit Installation - Hyperthreading ON:
 - CPU time 16% (sys, approx. 0% user) - Write speed 40-50 MB/s

Compared to ICH6R with AHCI OFF the only difference I can see is that with 
AHCI the system seems to reac much faster on keyboard events and screen 
redraw seems to be as fast as normal. It looks like that CPU usage has not 
decreased that dramatically as I would have expected it.

Thus I did a small calculation:
Assuming that the processor gives workloads of (a) 1B (b) 1kB (c) 64kB to the 
DMA controller in AHCI mode to write 45 MB/s to disk, I calculate for 10% CPU 
time usage of the 3.2 GHz Pentium
(a) 10% * 3.2GHz / 45M calls = 7.3 CPU cycles per 1B call to DMA
(b) 10% * 3.2GHz / 45k calls = 7.4E+03 CPU cycles per 1kB call to DMA
(c) 10% * 3.2GHz / 720 calls = 4.8E+05 CPU cycles per 64kB call to DMA

For me (a) looks reasonable (some overhead per byte), but stupid - if 
implemented. Giving bigger packages like (b) and (c) looks better to me, but 
then I can't understand that huge overhead (1E3 to 1E5 cpu cycles per 
package) for one package.

Is this normal or do I still have something wrong in my system?

Thank you for your help,

Martin
