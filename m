Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbUJZHWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUJZHWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUJZHWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:22:07 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50187 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262130AbUJZHV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:21:59 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1: make error when using separate build dir
Date: Tue, 26 Oct 2004 10:21:40 +0300
User-Agent: KMail/1.5.4
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410261021.40353.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like gen_init_cpio does not work with
separate build dir.

Copying initramfs_list into $objdir/usr/
by hand worked around this.


Date: Tue Oct 26 10:17:34 EEST 2004
Directory: 
Command: make V=1 bzImage modules
=============
make -C /.1/usr/srcdevel/kernel/linux-2.6.9-mm1		\
KBUILD_SRC=/.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src	     KBUILD_VERBOSE=1	\
KBUILD_CHECK= KBUILD_EXTMOD=""	\
        -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/Makefile bzImage
  Using /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src as source for kernel
if [ -h /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/include/asm -o -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/.config ]; then \
	echo "  /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src is not clean, please run 'make mrproper'";\
	echo "  in the '/.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src' directory.";\
	/bin/false; \
fi;
if [ ! -d include2 ]; then mkdir -p include2; fi;
ln -fsn /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/include/asm-i386 include2/asm
if /usr/bin/env test ! /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src -ef /.1/usr/srcdevel/kernel/linux-2.6.9-mm1; then \
/bin/sh /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/mkmakefile              \
    /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src /.1/usr/srcdevel/kernel/linux-2.6.9-mm1 2 6         \
    > /.1/usr/srcdevel/kernel/linux-2.6.9-mm1/Makefile;                                 \
    echo '  GEN    /.1/usr/srcdevel/kernel/linux-2.6.9-mm1/Makefile';                   \
fi
  GEN    /.1/usr/srcdevel/kernel/linux-2.6.9-mm1/Makefile
  CHK     include/linux/version.h
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=scripts/basic
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=scripts
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=scripts/genksyms
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=scripts/mod
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=arch/i386/kernel arch/i386/kernel/asm-offsets.s
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=init
  CHK     include/linux/compile.h
dnsdomainname: Unknown host
make -f /.1/usr/srcdevel/kernel/linux-2.6.9-mm1.src/scripts/Makefile.build obj=usr
  echo Using shipped usr/initramfs_list
Using shipped usr/initramfs_list
  ./usr/gen_init_cpio usr/initramfs_list > usr/initramfs_data.cpio
ERROR: unable to open 'usr/initramfs_list': No such file or directory

Usage:
	./usr/gen_init_cpio <cpio_list>

<cpio_list> is a file containing newline separated entries that
describe the files to be included in the initramfs archive:

# a comment
file <name> <location> <mode> <uid> <gid> 
dir <name> <mode> <uid> <gid>
nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>

<name>      name of the file/dir/nod in the archive
<location>  location of the file in the current filesystem
<mode>      mode/permissions of the file
<uid>       user id (0=root)
<gid>       group id (0=root)
<dev_type>  device type (b=block, c=character)
<maj>       major number of nod
<min>       minor number of nod

example:
# A simple initramfs
dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
dir /root 0700 0 0
dir /sbin 0755 0 0
file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0
make[2]: *** [usr/initramfs_data.cpio] Error 1
make[1]: *** [usr] Error 2
make: *** [bzImage] Error 2
--
vda

