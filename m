Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbTGUPYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbTGUPYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:24:36 -0400
Received: from dhcp065-024-128-253.columbus.rr.com ([65.24.128.253]:10137 "EHLO
	doug.hunley.homeip.net") by vger.kernel.org with ESMTP
	id S269641AbTGUPYd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:24:33 -0400
From: Douglas J Hunley <doug@hunley.homeip.net>
Organization: Linux StepByStep
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: illegal context call in slab.c
Date: Mon, 21 Jul 2003 11:28:55 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307211129.02337.doug@hunley.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Went downstairs this morning to find that X had to be completely restarted 
(everything I tried to do was giving a sig 11). These entries were in the 
system logs:
Jul 21 11:09:04 doug kernel: Debug: sleeping function called from illegal 
context at mm/slab.c:1811
Jul 21 11:09:04 doug kernel:  [<c011abc0>] __ioremap+0xc0/0x120
Jul 21 11:09:04 doug kernel:  [<c011ac4f>] ioremap_nocache+0x2f/0xd0
Jul 21 11:09:04 doug kernel:  [<c011f57f>] __might_sleep+0x5f/0x70
Jul 21 11:09:04 doug kernel:  [<c0144fe7>] kmem_cache_alloc+0x77/0x80
Jul 21 11:09:04 doug kernel:  [<c015666c>] get_vm_area+0x2c/0x160
Jul 21 11:09:04 doug kernel:  [<c015da05>] get_empty_filp+0x75/0x100
Jul 21 11:09:04 doug kernel:  [<c0166ff0>] chrdev_open+0x0/0x290
Jul 21 11:09:04 doug kernel:  [<c0167110>] chrdev_open+0x120/0x290
Jul 21 11:09:04 doug kernel:  [<c017980f>] iget_locked+0xaf/0xf0
Jul 21 11:09:04 doug kernel:  [<c018c701>] proc_get_inode+0x121/0x150
Jul 21 11:09:04 doug kernel:  [<c018c851>] proc_root_lookup+0x31/0x80
Jul 21 11:09:04 doug kernel:  [<f8a27e70>] nv_kern_open+0x16f/0x28b [nvidia]
Jul 21 11:09:04 doug kernel:  [<f8a2b138>] os_map_kernel_space+0x68/0x6c 
[nvidia]
Jul 21 11:09:04 doug kernel:  [<f8a3cfa7>] __nvsym00517+0x1f/0x2c [nvidia]
Jul 21 11:09:04 doug kernel:  [<f8a3ee7e>] __nvsym00711+0x6e/0xdc [nvidia]
Jul 21 11:09:04 doug kernel:  [<f8a3ef0a>] __nvsym00718+0x1e/0x184 [nvidia]
Jul 21 11:09:04 doug kernel:  [<f8a3ff38>] rm_init_adapter+0xc/0x10 [nvidia]
Jul 21 11:09:04 doug kernel: Call Trace:
Jul 21 11:09:05 doug kernel: 
Jul 21 11:09:05 doug kernel:  [<c010946b>] syscall_call+0x7/0xb
Jul 21 11:09:05 doug kernel:  [<c011f57f>] __might_sleep+0x5f/0x70
Jul 21 11:09:05 doug kernel:  [<c0145081>] __kmalloc+0x91/0xa0
Jul 21 11:09:05 doug kernel:  [<c015bb37>] filp_open+0x67/0x70
Jul 21 11:09:05 doug kernel:  [<c015bc95>] dentry_open+0x155/0x230
Jul 21 11:09:05 doug kernel:  [<c015c0ab>] sys_open+0x5b/0x90
Jul 21 11:09:05 doug kernel:  [<c015da05>] get_empty_filp+0x75/0x100
Jul 21 11:09:05 doug kernel:  [<c0166ff0>] chrdev_open+0x0/0x290
Jul 21 11:09:05 doug kernel:  [<c0167110>] chrdev_open+0x120/0x290
Jul 21 11:09:05 doug kernel:  [<f8a27e70>] nv_kern_open+0x16f/0x28b [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8a2a8bc>] os_alloc_mem+0x5c/0x87 [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8a3d0b4>] __nvsym00041+0x10/0x24 [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8a3ea88>] __nvsym00709+0x1c/0x60 [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8a3effd>] __nvsym00718+0x111/0x184 [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8a3ff38>] rm_init_adapter+0xc/0x10 [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8add34f>] __nvsym03752+0x1af/0x250 [nvidia]
Jul 21 11:09:05 doug kernel:  [<f8b3e72d>] __nvsym00717+0x11d/0x224 [nvidia]
Jul 21 11:09:05 doug kernel: Call Trace:
Jul 21 11:09:07 doug kernel: 
Jul 21 11:09:07 doug kernel:  [<c010946b>] syscall_call+0x7/0xb
Jul 21 11:09:07 doug kernel:  [<c011abc0>] __ioremap+0xc0/0x120
Jul 21 11:09:07 doug kernel:  [<c011ac4f>] ioremap_nocache+0x2f/0xd0
Jul 21 11:09:07 doug kernel:  [<c011f57f>] __might_sleep+0x5f/0x70
Jul 21 11:09:07 doug kernel:  [<c0144fe7>] kmem_cache_alloc+0x77/0x80
Jul 21 11:09:07 doug kernel:  [<c0145081>] __kmalloc+0x91/0xa0
Jul 21 11:09:07 doug kernel:  [<c015666c>] get_vm_area+0x2c/0x160
Jul 21 11:09:07 doug kernel:  [<c015bb37>] filp_open+0x67/0x70
Jul 21 11:09:07 doug kernel:  [<c015bc95>] dentry_open+0x155/0x230
Jul 21 11:09:07 doug kernel:  [<c015c0ab>] sys_open+0x5b/0x90
Jul 21 11:09:07 doug kernel:  [<c015da05>] get_empty_filp+0x75/0x100
Jul 21 11:09:07 doug kernel:  [<c0166ff0>] chrdev_open+0x0/0x290
Jul 21 11:09:07 doug kernel:  [<c0167110>] chrdev_open+0x120/0x290
Jul 21 11:09:07 doug kernel:  [<f8a27e70>] nv_kern_open+0x16f/0x28b [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a2a8bc>] os_alloc_mem+0x5c/0x87 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a2b138>] os_map_kernel_space+0x68/0x6c 
[nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3cfa7>] __nvsym00517+0x1f/0x2c [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3d0b4>] __nvsym00041+0x10/0x24 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3ea88>] __nvsym00709+0x1c/0x60 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3ee7e>] __nvsym00711+0x6e/0xdc [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3ef0a>] __nvsym00718+0x1e/0x184 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3effd>] __nvsym00718+0x111/0x184 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8a3ff38>] rm_init_adapter+0xc/0x10 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8add34f>] __nvsym03752+0x1af/0x250 [nvidia]
Jul 21 11:09:07 doug kernel:  [<f8b3e72d>] __nvsym00717+0x11d/0x224 [nvidia]

Issues with the kernel? Or is it the nvidia module? Thanks.
- -- 
Douglas J Hunley (doug at hunley.homeip.net) - Linux User #174778
http://doug.hunley.homeip.net && http://www.linux-sxs.org

How do you know when you're out of invisible ink?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HAa62MO5UukaubkRAhJQAJ4tLGRoPQOQzdZ564E8k59ltTD3fACeK6Vu
F9hKVINoteFpI49U2g9b31Y=
=SNqA
-----END PGP SIGNATURE-----

