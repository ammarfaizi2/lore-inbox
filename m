Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264834AbUD1Pnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264834AbUD1Pnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264840AbUD1Pnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:43:39 -0400
Received: from mail.skule.net ([216.235.14.165]:34730 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S264834AbUD1Pnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:43:37 -0400
Date: Wed, 28 Apr 2004 11:43:37 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: root cause of VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
Message-ID: <20040428154337.GC26897@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Bender: Want me to smack the corpse around a little?
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'make install' on the Fedora systems will set grub up to use an initrd.
If you do this with a Linus 2.6 kernel, you will often see this error
when trying to use the initrd:

VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

The most common advice given is to change your grub entry to something
like root=/dev/hda2.

What most of the other posts on this topic don't include is the
preceeding messages:
kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
kernel: Freeing initrd memory: 98k freed
kernel: RAMDISK: Compressed image found at block 0
kernel: RAMDISK: incomplete write (-28 != 32768) 4194304

The root of the problem is that the default ramdisk size of 4096 is not
big enough for the initrd used on Fedora.  I presume the same problem
exists on other systems.

Perhaps the default ramdisk size (CONFIG_BLK_DEV_RAM_SIZE) on the linus
kernels could be increased to 8192.

cheers
-mark
-- 
Drugs are for losers. And hypnosis is for losers with big weird
eyebrows. - Fry
