Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbTCLB6m>; Tue, 11 Mar 2003 20:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263004AbTCLB6m>; Tue, 11 Mar 2003 20:58:42 -0500
Received: from pvil-e-148.resnet.purdue.edu ([128.211.249.148]:14524 "EHLO
	bruin.offtopic.org") by vger.kernel.org with ESMTP
	id <S263003AbTCLB6l>; Tue, 11 Mar 2003 20:58:41 -0500
Date: Tue, 11 Mar 2003 21:08:50 -0500
From: Xiong Jiang <jxiong@offtopic.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug] module unloading or unmap_vma bug ?
Message-ID: <20030312020849.GA8228@offtopic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, folks,

Maybe this was reported or maybe not...

Plain 2.5.64 kernel, with isofs as modules, using the new module-init-tool.
Try modprobe isofs and unload it, then try it again, then I got following
segfault. Then modules system got something wrong and have to reboot.
And shutdown procedure is halted when iptable service is to be stopped.

Here is now to reproduce it:
/sbin/modprobe isofs
/sbin/rmmod isofs
/sbin/rmmod zlib_inflate
/sbin/modprobe isofs
/sbin/rmmod isofs

Process rmmod (pid: 693, threadinfo=cd096000 task=cd2d07c0)
Stack: 40017000 cd097f38 c0141bf4 c03035a4 d0864d74 d0864d60 00000000 cd097f2c
       c01aba94 d0864d74 d0864d74 cd097f3c c01abab4 d0864d74 00000000 cd097f50
       c016a562 d0864d74 c0288518 d0864f40 cd097f5c d0861ac2 d0864d60 cd097fbc
Call Trace:
 [<c0141bf4>] unmap_vmas+0xc4/0x220
 [<d0864d74>] iso9660_fs_type+0x14/0x80 [isofs]
 [<d0864d60>] iso9660_fs_type+0x0/0x80 [isofs]
 [<c01aba94>] kobject_del+0x14/0x20
 [<d0864d74>] iso9660_fs_type+0x14/0x80 [isofs]
 [<d0864d74>] iso9660_fs_type+0x14/0x80 [isofs]
 [<c01abab4>] kobject_unregister+0x14/0x20
 [<d0864d74>] iso9660_fs_type+0x14/0x80 [isofs]
 [<c016a562>] unregister_filesystem+0x32/0x40
 [<d0864d74>] iso9660_fs_type+0x14/0x80 [isofs]
 [<d0864f40>] +0x0/0x140 [isofs]
 [<d0861ac2>] +0x12/0x20 [isofs]
 [<d0864d60>] iso9660_fs_type+0x0/0x80 [isofs]
 [<c01330d3>] sys_delete_module+0x1b3/0x1f0
 [<c0145667>] sys_munmap+0x57/0x80
 [<c010b282>] sysenter_entry+0x52/0x70

Code: 0f 0b 0a 01 56 1e 26 c0 ff 07 83 4f 04 08 85 ff 0f 84 37 01

