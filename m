Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVHANLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVHANLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 09:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVHANLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 09:11:20 -0400
Received: from pop-knobcone.atl.sa.earthlink.net ([207.69.195.64]:30127 "EHLO
	pop-knobcone.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261914AbVHANLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 09:11:18 -0400
Message-ID: <42EE1F75.6080605@earthlink.net>
Date: Mon, 01 Aug 2005 09:11:17 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13rc4 hang
References: <42E6C8DB.4090608@earthlink.net>	<s5hr7dklko4.wl%tiwai@suse.de>	<42E7A8D8.1030809@earthlink.net> <20050729014150.6e97dfd2.akpm@osdl.org> <42EAF070.5050001@earthlink.net> <42EBA31F.9080703@earthlink.net>
In-Reply-To: <42EBA31F.9080703@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I am having a problem 2.6.13rc4 described below on a HP Pavilion N5430 
laptop.


1) If I cold boot with only 'lacpi' to run level 3 - shortly after I get
the login prompt the laptop freezes.

2) If I cold boot with 'lacpi  acpi=off  pci=noacpi,usepirqmask'  the
system boots and does not freeze but  when I try to play sound I get no
interrupts from my sound card.

3) If I now warm boot from step  2 with only 'lacpi' my  laptop seems to
be stable  and I have sound.

I did this several times to try and really verify the above scenarios.

Diff between dmesg output from step 1 and step 3
$ diff dmesg104550 dmesg105029
43,45c43,44
< CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
00000000 00000000 00000000
< CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
00000000 00000000 00000000
< Enabling disabled K7/SSE Support.
---
> CPU: After generic identify, caps: 0383f9ff c1c7f9ff 00000000 
00000000 00000000 00000000 00000000
> CPU: After vendor identify, caps: 0383f9ff c1c7f9ff 00000000 00000000 
00000000 00000000 00000000
55c54
< ACPI: setting ELCR to 0200 (from 0800)
---
> ACPI: setting ELCR to 0200 (from 0820)
92c91
< audit(1122734733.300:1): initialized
---
> audit(1122735011.179:1): initialized
161c160
< Detected 849.810 MHz processor.
---
> Detected 850.192 MHz processor.
163c162
< powernow: Minimum speed 299 MHz. Maximum speed 849 MHz.
---
> powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.

What is the best way to debug a hang? I there a way to turn on verbose
debugging at boot? Also why would
the hardware capabilities be different between a cold boot and a warm boot?

Thanks for any advice,
Steve

