Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWD1UWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWD1UWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWD1UWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:22:30 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:28838 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751406AbWD1UW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:22:29 -0400
Message-ID: <4452797F.70700@dgreaves.com>
Date: Fri, 28 Apr 2006 21:22:23 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Bad page state in process 'nfsd' with xfs
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This was with 2.6.16.9

There's an nfs export from an xfs on an lvm on a raid5 on some
libata/sata disks.
(cc'ing xfs since I recall rumoured(?) badness in old nfs/xfs/md/lvm
setups and xfs_sendfile is mentioned)

dmesg had:

Bad page state in process 'nfsd'
page:b1602060 flags:0x80000008 mapping:00000000 mapcount:0 count:16777216
Trying to fix it up, but a reboot is needed
Backtrace:
 [<b013bda2>] bad_page+0x62/0x90
 [<b013c1c8>] prep_new_page+0x78/0x80
 [<b013c6b6>] buffered_rmqueue+0xf6/0x1f0
 [<b013c8e2>] get_page_from_freelist+0x92/0xb0
 [<b013c956>] __alloc_pages+0x56/0x300
 [<b013f00c>] __do_page_cache_readahead+0xdc/0x120
 [<b013f1b9>] blockable_page_cache_readahead+0x59/0xd0
 [<b013f2aa>] make_ahead_window+0x7a/0xb0
 [<b013f39f>] page_cache_readahead+0xbf/0x1b0
 [<b0138b91>] do_generic_mapping_read+0x4b1/0x4c0
 [<b01390e2>] generic_file_sendfile+0x62/0x70
 [<f1097080>] nfsd_read_actor+0x0/0xd0 [nfsd]
 [<b021bab0>] xfs_sendfile+0xc0/0x190
 [<f1097080>] nfsd_read_actor+0x0/0xd0 [nfsd]
 [<b0217fe8>] linvfs_open+0x48/0x50
 [<b0217f97>] linvfs_sendfile+0x57/0x60
 [<f1097080>] nfsd_read_actor+0x0/0xd0 [nfsd]
 [<f109734f>] nfsd_vfs_read+0x1ff/0x370 [nfsd]
 [<f1097080>] nfsd_read_actor+0x0/0xd0 [nfsd]
 [<f1097933>] nfsd_read+0x103/0x120 [nfsd]
 [<f109e234>] nfsd3_proc_read+0xe4/0x170 [nfsd]
 [<f1093649>] nfsd_dispatch+0xd9/0x210 [nfsd]
 [<f10e4792>] svc_process+0x482/0x670 [sunrpc]
 [<f10933fc>] nfsd+0x18c/0x300 [nfsd]
 [<f1093270>] nfsd+0x0/0x300 [nfsd]
 [<b0101391>] kernel_thread_helper+0x5/0x14

more info on request but I have rebooted as suggested.

David

- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEUnl+8LvjTle4P1gRAip3AJ9izpp3+/6/fPgzSbJdxuc74Uus5wCZAWtF
QHY+xcDh9cf6bYhBCx+DzJE=
=XZDc
-----END PGP SIGNATURE-----

