Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTICMrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbTICMrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:47:22 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:33218 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262074AbTICMrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:47:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: b.zolnierkiewicz@elka.pw.edu.pl
Date: Wed, 3 Sep 2003 14:46:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: LBA48 on PDC20265 (again and again...)
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <BFC117A6765@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  during last year there was couple of complaints that pdc202xx_old
driver does not allow LBA48 on first channel, and couple of confirmations
that just removing these two lines which do:

  if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
      hwif->no_lba48 = (hwif->channel) ? 0 : 1;
      
fixes problem, and both channels run with lba48 drives just fine...

  Yesterday I bring home two nice 160GB seagates, hooked them up to
the Promise, and booted. And to my surprise we still do not enable
lba48 on primary channel...

  Is there some reason for doing that? I removed this, and I was able
to copy contents of my old 120GB disk to the 160GB one, with 40G offset
(so lba48 has to work, otherwise first 40GB holding an VFAT partition with
some gzipped test files gets corrupted). Currently these two drives
are unused (they just hold backup copy of dying 120GB wd), so I can do
any experiments you may want to confirm/decline idea that we should
remove this no_lba48 hack. Of course unless you have datasheet which says
that it cannot work. But as Promise BIOS happily says that two 149GB disks
(149 * 2^30 == 160 * 10^9) running UDMA5 are attached, I assume that it 
is willing to handle LBA48 on both channels.
                                              Thanks,
                                                  Petr Vandrovec
                                                  

