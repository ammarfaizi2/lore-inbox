Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbTDOLhO (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbTDOLhO 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:37:14 -0400
Received: from dnvrdslgw14poolC198.dnvr.uswest.net ([63.228.86.198]:14425 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id S261206AbTDOLhN 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:37:13 -0400
Date: Tue, 15 Apr 2003 05:49:19 -0600 (MDT)
From: Benson Chow <blc+lkml@q.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: ac97, alc101+kt8235 sound
Message-ID: <Pine.LNX.4.44.0304150537330.28926-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess this ac97 stuff is pretty confusing.

Anyway, my motherboard has a kt8235 southbridge and an ALC101 AC97
decoder.  I read in some posting to hack the ALC101 into the
drivers/sound/ac97_codec.c with something like this:

        {0x414C4730, "ALC101",             &null_ops},

and then use the via82cxxx_audio driver.  It didn't do anything.  So, I
tried hacking the PCI device number in via82cxxx_audio.c by changing

static struct pci_device_id via_pci_tbl[] __initdata = {
        { PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
          PCI_ANY_ID, PCI_ANY_ID, },
        { 0, }
};

to

static struct pci_device_id via_pci_tbl[] __initdata = {
        { PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,
          PCI_ANY_ID, PCI_ANY_ID, },
        { 0, }
};

hoping that these via chips were pretty close.  Unfortunately no, it
still doesn't work.  It did, however, find the AC97 codec fine (I added
some printk's), but no sound is produced.  Any ideas on how to get this
vt8235-based motherboard sound working?  (and ALSA-0.9.2 seems to do
nothing but segfault it seems.)

Running the 2.4.20 kernel on an ecs p4vxasd2+ board (yeah, I know...)

Thanks,

-bc

WARNING: All HTML emails get deleted.  DO NOT SEND HTML MAIL.

