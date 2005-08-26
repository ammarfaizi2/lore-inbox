Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVHZBjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVHZBjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVHZBjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:39:22 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:29181 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S965044AbVHZBjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:39:22 -0400
Date: Thu, 25 Aug 2005 21:39:15 -0400 (EDT)
Message-Id: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13c
From: dwilson24@nyc.rr.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is in reference to Chris Wedgwood's patch.

Wouldn't it be better to put overmount_rootfs in initramfs.c
and call it only if there's a initramfs?

		printk(KERN_INFO "checking if image is initramfs...");
		err = unpack_to_rootfs((char *)initrd_start,
			initrd_end - initrd_start, 1);
		if (!err) {
			printk(" it is\n");
#ifdef CONFIG_EARLYUSERSPACE_ON_TMPFS
                        overmount_rootfs();
#endif /* CONFIG_EARLYUSERSPACE_ON_TMPFS */
			unpack_to_rootfs((char *)initrd_start,
				initrd_end - initrd_start, 0);
			free_initrd_mem(initrd_start, initrd_end);
			return;
