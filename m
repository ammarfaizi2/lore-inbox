Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRDXQtt>; Tue, 24 Apr 2001 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDXQtk>; Tue, 24 Apr 2001 12:49:40 -0400
Received: from mailgw2a.lmco.com ([192.91.147.7]:20241 "EHLO mailgw2a.lmco.com")
	by vger.kernel.org with ESMTP id <S132571AbRDXQtT>;
	Tue, 24 Apr 2001 12:49:19 -0400
Date: Tue, 24 Apr 2001 11:46:20 -0500
From: "Tom Brusehaver (N-Sysdyne Corporation)" <Thomas.Brusehaver@lmco.com>
Subject: shm_open doesn't work (fix maybe).
To: linux-kernel@vger.kernel.org
Message-id: <3AE5ADDC.A7AA6F51@lmco.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been chasing all around trying to find out why
shm_open always returns ENOSYS. It is implemented
in glibc-2.2.2, and seems the 2.4.3 kernel knows about
shmfs.

It seems the file linux/mm/shmem.c has:
    #define SHMEM_MAGIC 0x01021994

And the glibc-2.2.2/sysdeps/unix/sysv/linux/linux_fsinfo.h has:
    #define SHMFS_SUPER_MAGIC 0x02011994

Well, which is correct?

Looking for (trouble?) the reason, I found a patch
 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg16996.html

where there seems to be a typo, the remove line is correct:
   -#define SHM_FS_MAGIC 0x02011994

but the insert line has the 0201 reversed:
   +#define SHMEM_MAGIC    0x01021994

Has anyone else run into this? (It seems the documentation on shmfs
is sparse, so I don't think too many folks are even messing with it).

Initially I thought, hey simple, just fix the kernel source, and
everyone will be happy. But, then I thought, ooof! code I build
for someone without a patched kernel will surely break. So then
I thought simple I'll fix glibc and statically link. Of course, then
someone will fix this, and all my binaries will be broken.

Help! what is the "right" fix.



