Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRLHN2M>; Sat, 8 Dec 2001 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280467AbRLHN2B>; Sat, 8 Dec 2001 08:28:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41384 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280448AbRLHN1f> convert rfc822-to-8bit;
	Sat, 8 Dec 2001 08:27:35 -0500
Date: Sat, 8 Dec 2001 08:27:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [FIX] Re: [2.5.1-pre7] VFS: Cannot open root device "341" or 03:41
In-Reply-To: <20011208141517.7bc86a0e.sebastian.droege@gmx.de>
Message-ID: <Pine.GSO.4.21.0112080826410.7302-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Dec 2001, Sebastian [ISO-8859-1] Dröge wrote:

> Hi,
> When booting a virgin 2.5.1-pre7 kernel I get this panic:
> VFS: Cannot open root device "341" or 03:41
> Please append a correct "root=" boot option
> Kernel Panic: VFS: Unable to mount root fs on 03:41

--- C1-pre7/init/do_mounts.c	Fri Dec  7 20:48:43 2001
+++ linux/init/do_mounts.c	Sat Dec  8 06:29:20 2001
@@ -351,8 +351,9 @@
 		mount("devfs", ".", "devfs", 0, NULL);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
-		err = mount(name,"/root",p,root_mountflags,root_mount_data);
-		switch (err) {
+		errno = 0;
+		mount(name,"/root",p,root_mountflags,root_mount_data);
+		switch (-errno) {
 			case 0:
 				goto done;
 			case -EACCES:

