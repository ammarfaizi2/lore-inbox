Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272441AbTGZIhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272442AbTGZIhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:37:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:15521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272441AbTGZIhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:37:15 -0400
Date: Sat, 26 Jul 2003 01:53:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs_remove call when not using devfs 2.6.0-test1
Message-Id: <20030726015326.41b21ae4.akpm@osdl.org>
In-Reply-To: <20030724184301.GA7044@localhost.localdomain>
References: <20030724184301.GA7044@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balram Adlakha <b_adlakha@softhome.net> wrote:
>
> I get the following when I remove the OSS emu10k1 module:
>                                                                                 
>  Call Trace:
> [<c018e261>] devfs_remove+0x9e/0xa0
> [<c013898a>] unmap_vmas+0xcb/0x214
> [<d29e3e2d>] oss_cleanup+0x2b/0xed [sound]
> [<c0129c1e>] sys_delete_module+0x152/0x1a8
> [<c0130064>] generic_file_aio_write_nolock+0x8a7/0xa6a
> [<c013be3c>] sys_munmap+0x57/0x75
> [<c0108f81>] sysenter_past_esp+0x52/0x71
>                                                                                 
> I'm not using devfs so it should not happen.

Does this fix it?

diff -puN sound/oss/soundcard.c~soundcard-devfs-fix sound/oss/soundcard.c
--- 25/sound/oss/soundcard.c~soundcard-devfs-fix	2003-07-26 01:52:55.000000000 -0700
+++ 25-akpm/sound/oss/soundcard.c	2003-07-26 01:52:59.000000000 -0700
@@ -592,7 +592,7 @@ static void __exit oss_cleanup(void)
 	int i, j;
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		devfs_remove("snd/%s", dev_list[i].name);
+		devfs_remove("sound/%s", dev_list[i].name);
 		if (!dev_list[i].num)
 			continue;
 		for (j = 1; j < *dev_list[i].num; j++)

_

