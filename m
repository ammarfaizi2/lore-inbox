Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbTHZEiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbTHZEiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:38:55 -0400
Received: from main.gmane.org ([80.91.224.249]:6294 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262615AbTHZEix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:38:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Warner <lists@consulting.net.nz>
Subject: 2.4.22: ymfpci module segfaults
Date: Tue, 26 Aug 2003 16:38:50 +1200
Message-ID: <pan.2003.08.26.04.38.45.393191@consulting.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

It is extremely likely that you missed this reported segmentation fault as
the original poster tried to inform the LKML via Google Groups:
<http://groups.google.com/groups?selm=3084ded.0307120145.7977806a%40posting.google.com>

2.4.22 has been a wonderful success--up to the point that my last box to
be upgraded hung when booting. I isolated it to the loading of the ymfpci
module. In a subsequent web search I was fortunate to come across the
above reply.

So I reverted the change:

--- drivers/sound/ymfpci.c.original     2003-08-26 15:41:11.000000000 +1200
+++ drivers/sound/ymfpci.c      2003-08-26 15:52:36.000000000 +1200
@@ -2472,7 +2472,7 @@
        }
 
        eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
-       if (eid==0xFFFF) {
+       if (eid==0xFFFFFF) {
                printk(KERN_WARNING "ymfpci: no codec attached ?\n");
                goto out_kfree;
        }


Now I can load the ymfpci, soundcore and ac97_codec modules as before and
sound works fine. The kernel messages are:
ymfpci: YMF724F at 0xda000000 IRQ 19
ac97_codec: AC97 Audio codec, id: 0x8384:0x7605 (SigmaTel STAC9704)

lspci lists the sound card as:
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1Audio Controller] (rev 03)

I'd suggest Pete Zaitcev's advice is sound for 2.4:
<http://groups.google.com/groups?selm=fa.mdqtrfv.j44t8t%40ifi.uio.no>

"...for 2.4 I just removed the check. Consider that it was not working for
the whole life time of the driver, and not a single soul complained."

Regards,
Adam

