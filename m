Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTKPPIH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKPPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:08:07 -0500
Received: from ns.suse.de ([195.135.220.2]:28086 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262888AbTKPPIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:08:04 -0500
Date: Sun, 16 Nov 2003 16:08:02 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] missing padding in cpio_mkfile in usr/gen_init_cpio.c
Message-ID: <20031116150802.GA17141@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add this line to main() and booting will fail with panic:

        cpio_mkfile("t", "/sbin/init", 0700, 0, 0);


olaf@nectarine:~/kernel/pineapple/linuxppc-2.5> echo > t
olaf@nectarine:~/kernel/pineapple/linuxppc-2.5> gcc -o foo usr/gen_init_cpio.c.kaputt.c && ./foo | tee bar | cpio -vt
drwxr-xr-x   2 root     root            0 Nov 16 16:06 /dev
crw-------   1 root     root       5,   1 Nov 16 16:06 /dev/console
drwx------   2 root     root            0 Nov 16 16:06 /root
-rwx------   1 root     root            1 Nov 16 16:05 /sbin/init
cpio: premature end of file
olaf@nectarine:~/kernel/pineapple/linuxppc-2.5> gcc -o foo usr/gen_init_cpio.c && ./foo | tee bar | cpio -vt
drwxr-xr-x   2 root     root            0 Nov 16 16:06 /dev
crw-------   1 root     root       5,   1 Nov 16 16:06 /dev/console
drwx------   2 root     root            0 Nov 16 16:06 /root
-rwx------   1 root     root            1 Nov 16 16:05 /sbin/init
2 blocks
olaf@nectarine:~/kernel/pineapple/linuxppc-2.5> diff -pu usr/gen_init_cpio.c.kaputt.c usr/gen_init_cpio.c
--- usr/gen_init_cpio.c.kaputt.c        2003-11-16 16:03:27.000000000 +0100
+++ usr/gen_init_cpio.c 2003-11-16 16:02:12.000000000 +0100
@@ -197,6 +197,7 @@ void cpio_mkfile(const char *filename, c
 
        for (i = 0; i < buf.st_size; ++i)
                fputc(filebuf[i], stdout);
+       offset += buf.st_size;
        close(file);
        free(filebuf);
        push_pad();

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
