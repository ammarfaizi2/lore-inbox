Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbTCKKSX>; Tue, 11 Mar 2003 05:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262891AbTCKKSX>; Tue, 11 Mar 2003 05:18:23 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:27340 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262888AbTCKKSW>; Tue, 11 Mar 2003 05:18:22 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Date: Mon, 10 Mar 2003 13:43:57 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303101343.57545.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
+asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
+                unsigned long arg)
+{
+        mm_segment_t old_fs;
+        struct flock f;
+        long ret;
+
+        switch (cmd) {
+        case F_GETLK:
+        case F_SETLK:
+        case F_SETLKW:
+                ret = get_compat_flock(&f, (struct compat_flock *)arg);

and

-asmlinkage long sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-       switch (cmd) {
-       case F_GETLK:
-               {
-                       struct flock f;
-                       mm_segment_t old_fs;
-                       long ret;
-                       
-                       if(get_compat_flock(&f, (struct compat_flock *)A(arg)))
                                                                   ^^^^^^^^

Did you notice the use of the address conversion macro? Maybe I missed 
something myself, but I suppose this will fail on s390 if the msb of arg 
is not cleared.

	Arnd <><
