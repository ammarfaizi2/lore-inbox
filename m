Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSHDNS7>; Sun, 4 Aug 2002 09:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSHDNS6>; Sun, 4 Aug 2002 09:18:58 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:35090 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S314395AbSHDNS6>; Sun, 4 Aug 2002 09:18:58 -0400
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
In-Reply-To: <20020626145741.GD4611@kroah.com>
To: Greg KH <greg@kroah.com>
Date: Sun, 4 Aug 2002 15:22:04 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, marcelo@conectiva.com.br,
       mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17bLKe-0001p2-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Heh, send this to me again after 2.4.19-final is out, and I'll
> reconsider it :)

Over a month later, here it is - this drivers/usb/storage/unusual_devs.h
entry appears to be sufficient to make my Sagatek DCS-CF work:

/* aka Sagatek DCS-CF */
UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
		"Datafab",
		"KECF-USB",
		US_SC_SCSI, US_PR_BULK, NULL,
		US_FL_FIX_INQUIRY ),

Not even US_FL_MODE_XLATE or US_FL_START_STOP is necessary as far as
I can tell, but I guess that may depend on the chip revision.
US_FL_FIX_INQUIRY is required, or the device does not work at all...

Boot messages (with a 64MB == ~61 MiB CF card) look like this:

scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Datafab   Model: KECF-USB          Rev: 0113
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 125185 512-byte hdwr sectors (64 MB)
sda: test WP failed, assume Write Enabled
 sda: sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2

The "test WP failed" message appears to be harmless - I have tested
reading and writing, and it works for me.

Marek

