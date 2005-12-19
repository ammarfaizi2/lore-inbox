Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVLSWMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVLSWMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVLSWMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:12:33 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:39329 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S964858AbVLSWMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:12:33 -0500
Message-ID: <43A7304B.2070103@tlinx.org>
Date: Mon, 19 Dec 2005 14:12:27 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en, en_US
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de>
In-Reply-To: <20051219071959.GJ13985@lug-owl.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan-Benedict Glaw wrote:

>
>I've not really used out-of-tree building for Linux, so the tar*
>targets are probably not really tested with that regard. Though I'll
>check that and see if it works (of if a patch is needed.)
>
>The RPM targets have to be tested by somebody else :)
>
---
Thanks -- the error I got for the "tar"-based images started as:

ishtar:/usr/src/linux-2.6.14.3> make  V=1 INSTALL_ROOT= 
../build/ast-root O=../build/ast-26143/ tarbz2-pkg 
make -C /home/build/ast-26143 \
KBUILD_SRC=/usr/src/linux-2.6.14.3 \
KBUILD_EXTMOD="" -f /usr/src/linux-2.6.14.3/Makefile ../build/ast-root
make[1]: Nothing to be done for `/usr/src/linux-2.6.14.3/../build/ast-root'.
make -C /home/build/ast-26143 \
KBUILD_SRC=/usr/src/linux-2.6.14.3 \
KBUILD_EXTMOD="" -f /usr/src/linux-2.6.14.3/Makefile tarbz2-pkg
make -f /usr/src/linux-2.6.14.3/scripts/package/Makefile tarbz2-pkg
make
make -C /usr/src/linux-2.6.14.3 O=/home/build/ast-26143
Makefile:484: .config: No such file or directory
  Using /usr/src/linux-2.6.14.3 as source for kernel
if [ -f /usr/src/linux-2.6.14.3/.config ]; then \
        echo "  /usr/src/linux-2.6.14.3 is not clean, please run 'make 
mrproper'";\
        echo "  in the '/usr/src/linux-2.6.14.3' directory.";\
        /bin/false; \
fi;
if [ ! -d include2 ]; then mkdir -p include2; fi;
mkdir: cannot create directory `include2': Permission denied
make[4]: *** [prepare3] Error 1
make[3]: *** [all] Error 2
make[2]: *** [tarbz2-pkg] Error 2
make[1]: *** [tarbz2-pkg] Error 2
make: *** [tarbz2-pkg] Error 2
==========

Briefly, the make rpm-pagage options call "make install" and
"make modules_install".  Both attempt to install the kernel
for the "target" system onto the the "Build" system.  This isn't
desired as the "target" kernel won't even run on the "build"
system.

I could supply error listings, but it seems unneeded as it is
so easily reproduced.

I see JanB is on the making "tar" image, but how long ago was
building of the rpm stuff done?  Is it the case that the designer/writer
of that hasn't had time to make it work with the "O=" param?  Is
someone still actively maintaining those targets?

Ideally it would be good to be able to make an installable kernel
package as a non-root user.  The idea is to not need root-privs
except to install, right? :-)

Linda


 



