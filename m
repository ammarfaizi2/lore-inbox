Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTFZVqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTFZVq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:46:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:23766 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262874AbTFZVqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:46:20 -0400
Date: Fri, 27 Jun 2003 00:01:52 +0200
From: Arne Brutschy <abrutschy@xylon.de>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Arne Brutschy <abrutschy@xylon.de>
Organization: Xylon
X-Priority: 3 (Normal)
Message-ID: <1461514129.20030627000152@xylon.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re[4]: [PATCH] ide driver 2.4.21-rc6
In-Reply-To: <Pine.SOL.4.30.0306040131330.26979-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0306040131330.26979-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as I promised, I'm back at home and investigated the problem with the
CONFIG_PDC202XX_FORCE setting further.

The special cas with my setup is, that I have an ICH4 onboard, an
PDC20276 onboard and an PCI SCSI controller. The root filesystem is on
the SCSI disks. I can not boot from the SCSI disks directly, as the
BIOS enables the PDC first. So I have to boot from the IDE disks
connected to the PDC. This didn't work, so I replaced the simple
Promise RAID bios with an normal UDMA bios thats allows you to use the
controller as normal IDE controller. The result is, I can boot from
the IDE disks and I can use the IDE disks as normal disks (used it in
times the CONFIG_PDC202XX_FORCE wasn't in the linux kernel).

I do not know if the PDC 20276 is being sold with such a normal bios.
I think so, as there are serveral users reporting the same error.

The problem is, that the driver thinks the bios/drives didn't get enabled
by the bios end disables the whole controller. I patched the driver to
skip this step. I still have to use the CONFIG_PDC202XX_FORCE setting-
without it the second channel gets disabled.

This is the reason for my patch. I'm not sure, but I this it shouldn't
be a problem for the driver...

Regards,
Arne

PS: please write me if you see any problems related to that patch

Bartlomiej Zolnierkiewicz wrote:
BZ> It MUST work.

BZ> Clean your kernel source with 'make mrproper' (just in case) and compile
BZ> again with Special FastTrak Feature enabled (CONFIG_PDC202XX_FORCE=y).

BZ> If it really won't work contact me.
BZ> --
BZ> Bartlomiej

BZ> On Tue, 3 Jun 2003, Arne Brutschy wrote:

>> Bartlomiej Zolnierkiewicz wrote:
>> BZ> What about turning on "Special FastTrak Feature" instead...
>> Didn't work for me, don't know why.
>>
>> Arne

