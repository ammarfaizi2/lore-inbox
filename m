Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161539AbWHDWaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539AbWHDWaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbWHDWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:30:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:44475 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161539AbWHDWaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:30:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qik2HiGEzRj5lyXvJBNluAJBp3F4ahDxI3zbtiLBi5sFChTyawk8+BdGMLVYpiPaLwUW6vRHgJq07Xgec7f+4zJMpoPzmNgqVjX7fLHx9ndT+0gbYj9PSQaqnAxeLwkHC5ofxuUn68okAIkdkTCbV29nhxnNtZLd77rlN9zm6ag=
Message-ID: <3df49b7b0608041529k274c3c38labe52259cee555db@mail.gmail.com>
Date: Sat, 5 Aug 2006 00:29:59 +0200
From: koko <citizenr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: hda=none hda=noprobe is ignored by <=2.6.15-26
Cc: citizenr@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First some old Ignored(sadly) links to the same bug :
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132708
http://lkml.org/lkml/2003/6/16/29
http://www.gatago.com/linux/kernel/6116284.html

This bug is ASUS VIA MB specific. Asus A7V133, hda hdb empty.

>From Alan Cox (alan@redhat.com) 	on 2005-04-07 04:41 EST	[reply]	 	
>BIOS problem I believe not kernel. We only probe hda/hdb because the BIOS
>claims the slot may have a drive on it.

So why kernel probes IDE channel I just ordered him to IGNORE?

[snip]
[17179569.184000] Kernel command line: root=/dev/hdc3 ro quiet splash
hda=noprobe hdb=noprobe
[17179569.184000] ide_setup: hda=noprobe
[17179569.184000] ide_setup: hdb=noprobe
[snip]
[17179573.696000] VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100
controller on pci0000:00:04.1
[17179573.696000]     ide0: BM-DMA at 0xd800-0xd807, BIOS settings:
hda:pio, hdb:pio
[17179573.696000]     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings:
hdc:DMA, hdd:pio
[17179573.696000] Probing IDE interface ide0...
[snip]
 Here we go, and ....
[snip]
[17179577.060000] Probing IDE interface ide0...
[17179611.848000] ide0: Wait for ready failed before probe !
[snip]

almost a minute here :/

Heres how it looks without noprobe :
[17179572.788000] VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100
controller on pci0000:00:04.1
[17179572.788000]     ide0: BM-DMA at 0xd800-0xd807, BIOS settings:
hda:pio, hdb:pio
[17179572.788000]     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings:
hdc:DMA, hdd:pio
[17179572.788000] Probing IDE interface ide0...
[17179578.248000] hda: IRQ probe failed (0xfffffcf8)
[17179583.472000] hda: IRQ probe failed (0xfffffcf8)
[17179583.472000] hda: no response (status = 0x0a), resetting drive
[17179588.808000] hda: IRQ probe failed (0xfffffcf8)
[17179588.808000] hda: no response (status = 0x0a)
[17179594.312000] hdb: IRQ probe failed (0xfffffcf8)
[17179599.536000] hdb: IRQ probe failed (0xfffffcf8)
[17179599.536000] hdb: no response (status = 0x0a), resetting drive
[17179604.872000] hdb: IRQ probe failed (0xfffffcf8)
[17179604.872000] hdb: no response (status = 0x0a)
[17179604.928000] Probing IDE interface ide1...
[snip]
[17179608.240000] Probing IDE interface ide0...
[17179643.028000] ide0: Wait for ready failed before probe !
[17179648.476000] hda: IRQ probe failed (0xffff7cf0)
[17179653.700000] hda: IRQ probe failed (0xffff7cf0)
[17179653.700000] hda: no response (status = 0x0a), resetting drive
[17179659.036000] hda: IRQ probe failed (0xffff7cf0)
[17179659.036000] hda: no response (status = 0x0a)
[17179664.540000] hdb: IRQ probe failed (0xffff7cf0)
[17179669.764000] hdb: IRQ probe failed (0xffff7cf0)
[17179669.764000] hdb: no response (status = 0x0a), resetting drive
[17179675.100000] hdb: IRQ probe failed (0xffff7cf0)
[17179675.100000] hdb: no response (status = 0x0a)
[17179675.156000] Probing IDE interface ide2...

That one takes almost 3 minutes.

Why kernel probes IDE channels twice? Why it ignores noprobe in the
second probe? How is Asus A7V133 Bios broken (how can I check how its
broken) and how can I fix it?
Please dont ignore this message like kernel noprobe :)

PS:distro Ubuntu 6.06 and 2 random liveCD ones so its not distro specific.

-- 
Who logs in to gdm? Not I, said the duck.
