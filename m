Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWD1Gei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWD1Gei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWD1Gei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:34:38 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:14227 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030275AbWD1Geh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:34:37 -0400
Message-ID: <4451B77D.7070000@tlinx.org>
Date: Thu, 27 Apr 2006 23:34:37 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: make O="<dir>" install; output not relocated; 2.6.16.11(kbuild) 
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From "make help", the "O=" param to make is said to
  'Locate all output files in "dir", including .config'

I first did:
    "make O=$PWD/root bzImage modules"   # (Note: PWD=/usr/src/ast-261611)

That worked w/no apparent problems.

I wanted the output of "make install modules_install" placed
in a working directory (for transfer to the target system).

Instead, it appears the "O=" parameter is _partially_ ignored.

It is used for the "input" to the "make install" and the
"make modules_install", but seems to be ignored for "output":

ishtar:/usr/src/ast-261611> make V=1 O=$PWD/root modules_install
  make -C /usr/src/ast-261611/root \
    KBUILD_SRC=/usr/src/ast-261611 \
    KBUILD_EXTMOD="" -f /usr/src/ast-261611/Makefile modules_install
  mkdir: cannot create directory `/lib/modules/2.6.16.11-astarte': 
Permission denied
  make[1]: *** [_modinst_] Error 1
  make: *** [modules_install] Error 2

ishtar:/usr/src/ast-261611> make V=1 O=$PWD/root install       
  make -C /usr/src/ast-261611/root \
    KBUILD_SRC=/usr/src/ast-261611 \
    KBUILD_EXTMOD="" -f /usr/src/ast-261611/Makefile install
    make -f /usr/src/ast-261611/scripts/Makefile.build 
obj=arch/i386/boot BOOTIMAGE=arch/i386/boot/bzImage install
      sh /usr/src/ast-261611/arch/i386/boot/install.sh 2.6.16.11-astarte 
arch/i386/boot/bzImage System.map "/boot"
      ln: cannot remove `/boot/vmlinuz': Permission denied
      rm: cannot remove `/boot/System.map': Permission denied
      cp: cannot create regular file `/boot/vmlinuz-2.6.16.11-astarte': 
Permission denied
      cp: cannot create regular file 
`/boot/System.map-2.6.16.11-astarte': Permission denied
      ln: cannot remove `/boot/vmlinuz': Permission denied
      You may need to create an initial ramdisk now.
----

    Is this a bug or a feature?  I.e. is the "make help" misleading in
saying "O=<dir>" can be used to specify the output directory of a
make run?  Or should this be working?

Thanks,
Linda'



