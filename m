Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUE3Du7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUE3Du7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 23:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUE3Du7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 23:50:59 -0400
Received: from ums.usu.ru ([194.226.236.116]:55721 "EHLO ums.usu.ru")
	by vger.kernel.org with ESMTP id S261648AbUE3Du5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 23:50:57 -0400
Message-ID: <40B95A67.3000807@ums.usu.ru>
Date: Sun, 30 May 2004 09:52:07 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version and NPTL
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is one more place except the r8169 driver where gcc 2.95.3 is bad. 
To reproduce the problem:

(you will need HJL Binutils >= 2.14.90.0.8 and gcc 3.3.x)

Check out a known good glibc from CVS:

cvs -z 3 -d :pserver:anoncvs@sources.redhat.com:/cvs/glibc \
     export -d glibc-2.3.4-20040510 -D "14:45:00 2004-05-10 UTC" libc
sed -i -e "s/stable/2004-05-10/" -e "s/2\.3\.3/2.3.4/" \
     glibc-2.3.4-20040510/version.h

Alternatively, there is a tarball available (created with these 
instructions) which you can download from the following location: 
ftp://gaosu.rave.org/pub/linux/lfs/packages/conglomeration/glibc-2.3.4-20040510.tar.bz2

Build glibc:

cd glibc-2.3.4-20040510
mkdir ../glibc-build
cd ../glibc-build
../glibc-2.3.4-20040510/configure --prefix=/usr \
     --disable-profile --enable-add-ons=nptl --with-tls \
     --without-cvs \
     --with-headers=/usr/src/linux/include
make
(we will not install anything)

Back up the glibc-build directory for future reference, but don't remove 
it now.

Issue the "make ckeck" command when running linux-2.6.6 compiled with 
gcc 3.3.3. If you get a failure, make a note of it and reissue the "make 
check" command.

Once you know all failures, remove the glibc-build directory and restore 
it from the backup you made previously.

Reboot into linux-2.6.6 compiled with gcc-2.95.3 published by Free 
Software Foundation. Redo the tests. You will notice several additional 
errors in NPTL testsuite. That's why I think that linux-2.6.6 should 
never be compiled with gcc-2.95.3.

-- 
Alexander E. Patrakov
I am not subscribed to LKML, so please CC: me
