Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280773AbRKSXob>; Mon, 19 Nov 2001 18:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280774AbRKSXoN>; Mon, 19 Nov 2001 18:44:13 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:65286 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280773AbRKSXnx>; Mon, 19 Nov 2001 18:43:53 -0500
Date: Tue, 20 Nov 2001 00:43:50 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Message-ID: <20011120004350.A9631@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

I'm using kernel 2.4.15-pre6 and I can see my journal file
on '/'. Should I worry ?


[root@tony] dmesg
...
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
...


[root@tony] ls -ali /
total 65720
   2 drwxr-xr-x   24 root     root         4096 Nov 20 00:26 .
   2 drwxr-xr-x   24 root     root         4096 Nov 20 00:26 ..
2930 -rw-------    1 root     root     67108864 Nov 18 19:56 .journal
					^^^^^^^ created as -J size=64


[root@tony] tune2fs -l /dev/sda1
tune2fs 1.25 (20-Sep-2001)
Filesystem volume name:   /
Last mounted on:          <not available>
Filesystem UUID:          b909b36d-8f16-4be1-9614-5049bad90e96
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
                                               ^^^^^^^^^^^^^^ 
					       ??????????????

Journal inode:            2930    <--- like 'ls' said
Journal device:           0x0000


[root@tony] mount
/dev/sda1 on / type ext3 (rw)


lilo.conf sniplet:
	image   = /boot/vmlinuz-2.4.15-6
	label   = linux
	append  = "video=matrox:vesa:261,fv:80,font:VGA8x16 rootfstype=ext3"


Could someone please comment on this ?
I'm feeling kind of worried.

thanks,
Patrick
