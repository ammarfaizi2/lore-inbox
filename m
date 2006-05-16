Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWEPIp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWEPIp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWEPIp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:45:56 -0400
Received: from hera.kernel.org ([140.211.167.34]:61874 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750716AbWEPIpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:45:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-rc4-mm1 panic on boot
Date: Tue, 16 May 2006 01:45:38 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e4c3fi$utm$1@terminus.zytor.com>
References: <20060516001501.GA7528@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1147769138 31671 127.0.0.1 (16 May 2006 08:45:38 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 16 May 2006 08:45:38 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060516001501.GA7528@localhost>
By author:    lgouv@tele2.be
In newsgroup: linux.dev.kernel
>
> Just upgraded from rc3-mm4.
> Panic on boot with this message (copied by hand ):
> 	kinit:do_mount
> 	kinit: name_to_dev_t(/dev/hda8) = dev (0,0)
> 	kinit:rot_dev = dev (0,0)
> 	kinit root_dev = dev (0,0)
> 	kinit trying to mount /dev/root on /root
> 	...........
> /dev/hda8 is my root partition but I suppose dev (0,0) is the first
> partition on hda which is FAT.
> I tried vanilla rc4 with the same result.
> 

This means kinit couldn't find a name-to-number mapping for the string
/dev/hda8.  However, you said you tried vanilla rc4 with the same
result, and vanilla rc4 doesn't use klibc.

This means hda8 simply isn't discovered on your system, which probably
means hda isn't discovered.  This typically is an issue with your
kernel configuration, but it's not always.

There should be somewhere in your boot messages a message such as the
following:

Probing IDE interface ide0...
hda: WDC WD2500JB-00EVA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4

Does this show up in your successful boots?  Failing boots?

	-hpa
