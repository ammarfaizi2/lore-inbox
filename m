Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbTFEMFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTFEMFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:05:17 -0400
Received: from users.linvision.com ([62.58.92.114]:45203 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S264646AbTFEMFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:05:12 -0400
Date: Thu, 5 Jun 2003 14:18:40 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Fwd: VFAT performance.
Message-ID: <20030605141840.C22252@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

For the performance freaks: We're copying some data off a VFAT32
partition. We've opened the drive. (Yes I know, you're not supposed to
do that. "Don't do this at home folks!" :-)

When copying /dev/hda, we were able to achieve 11Mbyte per second: Our
100mpbs ethernet throughput. 

When copying large files off /mnt, we see a performance of about 7Mb
per second. We see the head seek to the FAT about twice per second. This
fits in with: 

	4K bytes of FAT contains 1024 fat entries. 
with a 4K clustersize, that would describe about 4Mbytes worth of data. 
So, at 7Mbytes per second we require a new FAT block twice per second. 

I think that we're loosing the 4Mbytes per second of performance due
to the 4 seeks per second that the drive has to perform. 

The way to fix this would be to be able to assign a higher cache
priority (*) to the blocks in the FAT, and to read more than just 4k
per seek to the FAT.

Just something to keep in mind when fiddling with the code again....

			Roger.




(*) i.e. expire them from the buffer cache less easily than normal
blocks.


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
