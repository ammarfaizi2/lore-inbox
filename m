Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUETK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUETK2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 06:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUETK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 06:28:21 -0400
Received: from smtp2.libero.it ([193.70.192.52]:47002 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S265080AbUETK2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 06:28:18 -0400
Date: Thu, 20 May 2004 12:30:16 +0200
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.6-mm4 - unknown symbol __log_start_commit
Message-Id: <20040520123016.0bd36f95.buffer@antifork.org>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I saw it few minutes ago while compiling kernel 2.6.6-mm4. 

root@mintaka:/usr/src/linux-2.6.6-mm4# depmod -ae -F System.map 2.6.6-mm4
WARNING: /lib/modules/2.6.6-mm4/kernel/fs/ext3/ext3.ko needs unknown symbol __log_start_commit

root@mintaka:~# modprobe ext3
FATAL: Error inserting ext3 (/lib/modules/2.6.6-mm4/kernel/fs/ext3/ext3.ko): Unknown symbol in module, or unknown parameter (see dmesg)
root@mintaka:~# dmesg | tail -n 1
ext3: Unknown symbol __log_start_commit
root@mintaka:~# lsmod | grep jbd
jbd                    52760  0
root@mintaka:/proc# grep __log_start_commit /proc/kallsyms
dfcb9170 t __log_start_commit   [jbd]

.config relevant section is reported below

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set


Note : this doesn't happen on kernel 2.6.6-mm3.

Regards.

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArIi4pONIzxnBXKIRAlJAAJ9gDRqciQtk8pdI3w6QKMDKi9XIKQCgufkZ
lJeiDgjRzROrQwfw2P43XtQ=
=tckk
-----END PGP SIGNATURE-----
