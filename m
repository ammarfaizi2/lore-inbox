Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUESJ3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUESJ3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 05:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUESJ3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 05:29:23 -0400
Received: from zero.aec.at ([193.170.194.10]:8196 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262488AbUESJ3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 05:29:21 -0400
To: Jan Kasprzak <kas@informatics.muni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile -EOVERFLOW on AMD64
References: <1XuW9-3G0-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 19 May 2004 11:29:18 +0200
In-Reply-To: <1XuW9-3G0-23@gated-at.bofh.it> (Jan Kasprzak's message of
 "Wed, 19 May 2004 10:50:13 +0200")
Message-ID: <m3d650wys1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> writes:
>
> The image (FC2-i386-DVD.iso) has 4370640896 bytes. The FTP server is native
> x86_64 binary, not a 32-bit one.

sys_sendfile limits itself dumbly to 2GB even on 64bit architectures.
This patch should fix it on x86-64, although other 64bit ports may 
need a similar patch. Just removing the limit in read_write 
is not easy, because it would need fixes in all the 32bit emulation
layers.

-Andi

diff -u linux-2.6.6-amd64/include/asm-x86_64/unistd.h-o linux-2.6.6-amd64/include/asm-x86_64/unistd.h
--- linux-2.6.6-amd64/include/asm-x86_64/unistd.h-o	2004-05-09 14:30:09.000000000 +0200
+++ linux-2.6.6-amd64/include/asm-x86_64/unistd.h	2004-05-19 11:27:00.000000000 +0200
@@ -98,7 +98,7 @@
 __SYSCALL(__NR_getpid, sys_getpid)
 
 #define __NR_sendfile                           40
-__SYSCALL(__NR_sendfile, sys_sendfile)
+__SYSCALL(__NR_sendfile, sys_sendfile64)
 #define __NR_socket                             41
 __SYSCALL(__NR_socket, sys_socket)
 #define __NR_connect                            42

