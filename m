Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTIVMSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTIVMSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:18:00 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:35045 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263121AbTIVMR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:17:59 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test5-mm4
Date: Mon, 22 Sep 2003 13:17:42 +0100
User-Agent: KMail/1.5.9
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
In-Reply-To: <20030922013548.6e5a5dcf.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309221317.42273.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 09:35, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2
>.6.0-test5-mm4/
>
>
> . A series of patches from Al Viro which introduce 32-bit dev_t support
>
> . Various new fixes
>
>

Hi Andrew,

-mm4 won't mount my ext3 root device whereas -mm3 will. Presumably this is 
some byproduct of the dev_t patches.

VFS: Cannot open root device "302" or hda2.
Please append correct "root=" boot option.
Kernel Panic: VFS: Unable to mount root fs on hda2.

One possible explanation is that I have devfs compiled into my kernel. I do 
not, however, have it automatically mounting on boot. It overlays /dev (which 
is populated with original style device nodes) after INIT has loaded.

Perhaps there is some other procedure I must complete before I can use 32bit 
dev_t?

[alistair] 01:15 PM [/usr/src/linux-2.6] egrep -e "DEVFS" -e "EXT3_FS" .config
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set

[alistair] 01:16 PM [/usr/src/linux-2.6] dmesg | grep p2
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p4

Cheers,
Alistair.
