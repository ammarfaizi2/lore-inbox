Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWBMRYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBMRYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBMRYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:24:04 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:23635 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932127AbWBMRYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:24:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AO9NF2PwdR4TtZiQnSQ0q11HXu5HVzl6oTYUHnSXDN5Htc+GGrf8grgvUiQNwpSSgDNJHF41W1VB6GXU5y2ow7sNM1gZLlXFAzGE0hCaktDh0tgYuWUVnVFhMMmExBhDT/6a29IBZ6sGbfRxbjZ3EjN3OhMTXWrBXDPsfMN0fRk=
Message-ID: <40a4ed590602130924h2fa305dbye4e1c58e27c089ba@mail.gmail.com>
Date: Mon, 13 Feb 2006 17:24:02 +0000
From: Zeno Davatz <zdavatz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at arch/i386/mm/pageattr.c:137!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm running Kernel. 2.6.15.4 and I compiled the newest sources for the
Kernel with the Nvidia driver. When I start Xorg dmesg gives me the
following:

kernel BUG at arch/i386/mm/pageattr.c:137!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: nvidia wlan_scan_ap wlan_scan_sta ath_pci
ath_rate_sample wlan ath_hal
CPU:    0
EIP:    0060:[<c0112dfa>]    Tainted: P      VLI
EFLAGS: 00013082   (2.6.15.4)
EIP is at __change_page_attr+0x181/0x18e
eax: 00009a20   ebx: 341a0000   ecx: c1009a20   edx: 340001e3
esi: c04d1f40   edi: c1000000   ebp: 00000163   esp: f5b5bd64
ds: 007b   es: 007b   ss: 0068
Process X (pid: 6661, threadinfo=f5b5a000 task=f7ab25a0)
Stack: f41a0000 f419f000 340001e3 f41a0000 c1683400 00000010 00000000 00003296
       c0112e5f c1683400 00000163 f45ca560 f8e00000 f7355000 f5b5bdec c0112a6e
       c1683200 00000011 00000163 00010000 f8e00000 f9336f32 f8e00000 f914b180
Call Trace:
 [<c0112e5f>] change_page_attr+0x58/0x6d
 [<c0112a6e>] iounmap+0xe0/0x11e
 [<f9336f32>] os_unmap_kernel_space+0xf/0x13 [nvidia]
 [<f914b180>] _nv001706rm+0x20/0x2c [nvidia]
 [<f914b173>] _nv001706rm+0x13/0x2c [nvidia]
 [<f9147731>] _nv002359rm+0xe9/0x184 [nvidia]
 [<f913ea7a>] _nv001955rm+0x36/0xe0 [nvidia]
 [<f915198c>] rm_teardown_agp+0x48/0x50 [nvidia]
 [<f91503e6>] _nv001296rm+0x1ce/0x1e4 [nvidia]
 [<f9334dc9>] nv_agp_teardown+0x56/0x74 [nvidia]
 [<f914d5cb>] _nv001708rm+0x73/0xa0 [nvidia]
 [<f913f4a6>] _nv001847rm+0x26/0x2c [nvidia]
 [<f914df7c>] _nv000650rm+0x58/0xcc [nvidia]
 [<f914dfd7>] _nv000650rm+0xb3/0xcc [nvidia]
 [<f914e671>] _nv001362rm+0x71/0xb0 [nvidia]
 [<f914e67e>] _nv001362rm+0x7e/0xb0 [nvidia]
 [<f914b4be>] _nv001820rm+0x12/0x18 [nvidia]
 [<f91510e7>] rm_disable_adapter+0x2f/0x8c [nvidia]
 [<f9151117>] rm_disable_adapter+0x5f/0x8c [nvidia]
 [<f915110b>] rm_disable_adapter+0x53/0x8c [nvidia]
 [<f9332b97>] nv_kern_close+0x170/0x1e2 [nvidia]
 [<c0156a61>] __fput+0x15c/0x16e
 [<c0155044>] filp_close+0x4d/0x79
 [<c01550d6>] sys_close+0x66/0x94
 [<c0102fb1>] syscall_call+0x7/0xb
Code: 44 c0 89 44 24 08 8b 44 24 0c 89 44 24 04 e8 2f fe ff ff 89 d9
e9 f2 fe ff ff 80 3e 00 78 0c 09 eb 89 1e ff 49 04 e9 f1 fe ff ff <0f>
0b 89 00 13 f1 3d c0 e9 e4 fe ff ff 55 57 31 ff 56 53 83 ec

My System Info:
Portage 2.0.51.22-r2 (default-linux/x86/2005.1, gcc-3.3.5-20050130,
glibc-2.3.4.20041102-r1, 2.6.15.4 i686)
=================================================================
System uname: 2.6.15.4 i686 Mobile Intel(R) Pentium(R) 4     CPU 3.20GHz
Gentoo Base System version 1.6.14
dev-lang/python:     2.3.5-r2
sys-apps/sandbox:    1.2.11
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.4_p6, 1.5, 1.6.3, 1.7.9-r1, 1.8.5-r3, 1.9.6-r1
sys-devel/binutils:  2.15.92.0.2-r10
sys-devel/libtool:   1.5.18-r1
virtual/os-headers:  2.6.11-r2
ACCEPT_KEYWORDS="x86"
AUTOCLEAN="yes"
CBUILD="i686-pc-linux-gnu"
CFLAGS="-Os -march=pentium4 -pipe"
CHOST="i686-pc-linux-gnu"
CONFIG_PROTECT="/etc /usr/kde/2/share/config /usr/kde/3/share/config
/usr/lib/X11/xkb /usr/share/config /var/qmail/control"
CONFIG_PROTECT_MASK="/etc/gconf /etc/terminfo /etc/env.d"
CXXFLAGS="-Os -march=pentium4 -pipe"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoconfig distlocks sandbox sfperms strict"
GENTOO_MIRRORS="http://distfiles.gentoo.org
http://distro.ibiblio.org/pub/Linux/distributions/gentoo"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
SYNC="rsync://192.168.0.15/gentoo-portage"
USE="x86 X alsa apache2 apm berkdb bitmap-fonts bzip2 crypt cups curl
eds emboss encode expat fam foomaticdb fortran gdbm gif gpm gstreamer
gtk gtk2 imlib ipv6 jpeg libg++ libwww mad mailbox maildir mikmod
motif mp3 mpeg ncurses nls nvidia opengl openssh openssl oss pam pcre
pdflib perl png pop python qt quicktime readline ruby sasl sdl spell
ssl tcpd tiff truetype truetype-fonts type1-fonts udev unicode vorbis
xml2 xmms xv zlib userland_GNU kernel_linux elibc_glibc"
Unset:  ASFLAGS, CTARGET, LANG, LC_ALL, LDFLAGS, LINGUAS, MAKEOPTS,
PORTDIR_OVERLAY

Thanks for any advice.
Zeno
