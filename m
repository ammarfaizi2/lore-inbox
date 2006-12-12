Return-Path: <linux-kernel-owner+w=401wt.eu-S1751157AbWLLFKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWLLFKl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 00:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWLLFKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 00:10:41 -0500
Received: from c-68-45-158-148.hsd1.nj.comcast.net ([68.45.158.148]:54248 "EHLO
	lorien.middle--earth.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751157AbWLLFKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 00:10:40 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <FCD18869-724B-4E5B-B682-2E39578C36B4@middle--earth.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Chris Zubrzycki <chris@middle--earth.org>
Subject: 2.6.19.1 GFS2_FS_LOCKING_DLM bug still lurking
Date: Tue, 12 Dec 2006 00:10:29 -0500
X-Pgp-Agent: GPGMail 1.1 (Tiger)
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I tried building the new kernel and ran into this bug:

WARNING: "kernel_sendmsg" [fs/dlm/dlm.ko] undefined!
WARNING: "sock_release" [fs/dlm/dlm.ko] undefined!
WARNING: "config_item_put" [fs/dlm/dlm.ko] undefined!
WARNING: "sock_create_kern" [fs/dlm/dlm.ko] undefined!
WARNING: "config_item_init_type_name" [fs/dlm/dlm.ko] undefined!
WARNING: "config_group_init_type_name" [fs/dlm/dlm.ko] undefined!
WARNING: "configfs_register_subsystem" [fs/dlm/dlm.ko] undefined!
WARNING: "config_group_find_obj" [fs/dlm/dlm.ko] undefined!
WARNING: "configfs_unregister_subsystem" [fs/dlm/dlm.ko] undefined!
WARNING: "kernel_recvmsg" [fs/dlm/dlm.ko] undefined!
WARNING: "config_item_get" [fs/dlm/dlm.ko] undefined!
WARNING: "config_group_init" [fs/dlm/dlm.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2



I found the solution here: http://www.spinics.net/lists/kernel/ 
msg535532.html
I only changed the one file, fs/gfs2/Kconfig, and added

+	depends on GFS2_FS && INET && (IPV6 || IPV6=n)
+	select IP_SCTP if DLM_SCTP
+	select CONFIGFS_FS

It seems to work fine now. Please CC me on any replies, thank you.

- -chris zubrzycki
- - --
PGP public key: http://homepage.mac.com/beren/publickey.txt
ID: 0xA2ABC070
Fingerprint: 26B0 BA6B A409 FA83 42B3  1688 FBF9 8232 A2AB C070
========================================================

Remember: it's a "Microsoft virus", not an "email virus",
a "Microsoft worm", not a "computer worm".



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)
Comment: Please sign reply-http://www.gnupg.org

iEYEARECAAYFAkV+OckACgkQ+/mCMqKrwHBE4gCgr6imhZykVHdTSKvNXF65IPdK
noMAn3ZipJc04zWA3NhzxFbZ84OCLMFt
=8DB0
-----END PGP SIGNATURE-----
