Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRCOVwH>; Thu, 15 Mar 2001 16:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRCOVv5>; Thu, 15 Mar 2001 16:51:57 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:47513 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131365AbRCOVvu>;
	Thu, 15 Mar 2001 16:51:50 -0500
Date: Thu, 15 Mar 2001 22:50:06 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200103152150.WAA14187@harpo.it.uu.se>
To: adilger@turbolinux.com, lars@larsshack.org
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Cc: amnet@amnet-comp.com, hch@caldera.de, jjasen1@umbc.edu,
        linux-kernel@vger.kernel.org, util-linux@math.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001 12:34:06 -0700 (MST), Andreas Dilger wrote in LKML:

>Lars writes:
>> > Put LABEL=<label set with e2label> in you fstab in place of the device name.
>> 
>> Which is great, for filesystems that support labels.  Unfortunately,
>> this isn't universally available -- for instance, you cannot mount
>> a swap partition by label or uuid, so it is not possible to completely
>> isolate yourself from the problems of disk device renumbering.
>
>There is room for a LABEL and/or UUID in the swap superblock, if you
>would want to implement support for this.

Despair no more! I've implemented a patch for util-linux-2.11a
which adds LABEL support to mkswap(8) and swapon/swapoff(8).

- I shrunk the padding field in the new-style swap_header to make
  room for 16 bytes worth of volume label (same as ext2)
- mkswap -L label also sets the volume label
- swapon -L label looks for a swap partition with the given label
  (using a clone of mount(8)'s LABEL/UUID= support code)
- swapon/swapoff -a also handles swap fstab entries where the
  device is specified as LABEL=<label>

The patch is available at http://www.csd.uu.se/~mikpe/linux/swap-label/

/Mikael
