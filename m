Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUL3WHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUL3WHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUL3WHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:07:41 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:63319 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261728AbUL3WH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:07:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=GEZFbgIc4keamTbtKuKLz2SKxjOTqM+Rz4Ua9cZXGAnu7DLMn3DjnzUB96dCEdRO60OtxnOYvw6sWZj/8fumyupCWF9+ugDm4F8XIhu5jEJHDbNzdj66HT2Wlzlv//lF2bJoY5MlZS9rwIzTCjU9qcVQ8W0kM8ZPTRGtNVqrYHs=
Message-ID: <297f4e01041230140630691359@mail.gmail.com>
Date: Thu, 30 Dec 2004 23:06:19 +0100
From: Ikke <ikke.lkml@gmail.com>
Reply-To: Ikke <ikke.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-bk3 seems to break CIFS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling a 2.6.10-bk3 based kernel (with some more patches, none
of them touching CIFS or ipv6 AFAIK), CIFS fails to build due to some
ipv6 error, although I haven't got IPv6 selected in my configuration.

Error message:
gcc -Wp,-MD,fs/cifs/.connect.o.d -nostdinc -iwithprefix include
-D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -O2     -fomit-frame-pointer -pipe
-msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time
-march=i686 -mtune=pentium4 -Iinclude/asm-i386/mach-default
-Wdeclaration-after-statement   -DMODULE -DKBUILD_BASENAME=connect
-DKBUILD_MODNAME=cifs -c -o fs/cifs/connect.o fs/cifs/connect.c
In file included from fs/cifs/connect.c:27:
include/linux/ipv6.h: In function `inet6_sk':
include/linux/ipv6.h:278: error: structure has no member named `pinet6'
make[2]: *** [fs/cifs/connect.o] Error 1
make[1]: *** [fs/cifs] Error 2
make: *** [fs] Error 2


Using GCC 3.4.3, Gentoo system.

When looking at the -bk3 diff [1] the pinet6 field seems to be removed.


I did not try to revert this patch and compile it, will try later.


Regards, Ikke


[1] http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fsnapshots%2Fpatch-2.6.10-bk3.bz2;z=481
