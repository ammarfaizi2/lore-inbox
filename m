Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTIJENR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTIJENQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:13:16 -0400
Received: from smtp3.us.dell.com ([143.166.148.134]:26636 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP id S264504AbTIJENP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:13:15 -0400
Date: Tue, 9 Sep 2003 18:12:48 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@localhost.localdomain
To: Greg KH <greg@kroah.com>, <rmk@arm.linux.org.uk>
cc: Dave Jones <davej@redhat.com>, Anatoly Pugachev <mator@gsib.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable
 data
In-Reply-To: <20030910033524.GD9760@kroah.com>
Message-ID: <Pine.LNX.4.44.0309091752320.17200-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > agp_serverworks_probe() is marked __init.  Thus the static lookup
> Ah, Russell just got a patch for this into the tree today.

Thanks Russell.  However, I believe your patch only fixes the
pci_device_id tables marked __initdata, not the probe functions (or
anything they call) being marked __init, which is what Anatoly tripped up.  

At least these have probe functions marked __init in -test5.

drivers/net/irda/via-ircc.c:static int __init via_init_one
drivers/net/tokenring/abyss.c:static int __init abyss_attach
drivers/net/tokenring/tmspci.c:static int __init tms_pci_attach
drivers/pcmcia/i82092.c:static int __init i82092aa_pci_probe
sound/oss/ali5455.c:static int __init ali_probe
sound/oss/ali5455.c:ali_ac97_init
sound/oss/ali5455.c:ali_configure_clocking
sound/oss/i810_audio.c:static int __init i810_probe
sound/oss/i810_audio.c:i810_ac97_init
sound/oss/i810_audio.c:i810_configure_clocking
sound/oss/maestro3.c:static int __init m3_probe
sound/oss/maestro3.c:m3_codec_install
sound/oss/trident.c:static int __init trident_probe
sound/oss/trident.c:trident_ac97_init
sound/oss/via82cxxx_audio.c:static int __init via_init_one
   (and some related functions)
drivers/char/agp/*.c


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

