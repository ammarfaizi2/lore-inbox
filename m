Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTIBRzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTIBRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:54:45 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:35341 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263815AbTIBR34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:29:56 -0400
Date: Tue, 2 Sep 2003 19:27:04 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm4
Message-Id: <20030902192704.5a3dfce0.aradorlinux@yahoo.es>
In-Reply-To: <20030830161536.7e7be6d3.akpm@osdl.org>
References: <20030830161536.7e7be6d3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 30 Aug 2003 16:15:36 -0700 Andrew Morton <akpm@osdl.org> escribió:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm4/


I've found a application that triggers a 100% reproduceable bug. I don't know
if the app itself is doing something wrong...

The app is get-edid; which is supposed to get some data from the monitor:
Description: hardware information-gathering tool for VESA PnP monitors
 read-edid consists of two tools; get-edid uses a VESA VBE 2 interrupt
 service routine request to read a 128 byte EDID version 1 structure from
 your graphics card, which retrieves this information from the monitor via
 the Data Display Channel (DDC).  parse-edid parses this data structure and
 outputs data about the monitor suitable for inclusion into an XF86Config
 file.
 .
 get-edid uses real-mode x86 instructions to communicate with the video
 hardware; therefore, it is usable only by root, and this package is only
 available for the i386 architecture.

Source is available here:
http://homepage.ntlworld.com/john.fremlin/programs/linux/read-edid/read-edid-1.4.1.tar.gz
more info at: http://homepage.ntlworld.com/john.fremlin/programs/linux/read-edid/
(under debian there's a package called 'read-edid').


Oops:
Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Call Trace:
 [<c0123e41>] __might_sleep+0x61/0x80
 [<c010e77e>] save_v86_state+0x6e/0x220
 [<c012161a>] __wake_up_common+0x3a/0x70
 [<c010f3a7>] handle_vm86_fault+0xb7/0xa10
 [<c01cd9f6>] __copy_from_user_ll+0x66/0x70
 [<c010c6a0>] do_general_protection+0x0/0xa0
 [<c03004db>] error_code+0x2f/0x38
 [<c02ffa6f>] syscall_call+0x7/0xb


strace (I don't know exactly what call triggers the bug):

execve("/usr/bin/get-edid", ["get-edid"], [/* 17 vars */]) = 0
uname({sys="Linux", node="estel", ...}) = 0
brk(0)                                  = 0x804c000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=70443, ...}) = 0
old_mmap(NULL, 70443, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320]\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1190032, ...}) = 0
old_mmap(NULL, 1199556, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40027000
old_mmap(0x40144000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11c000) = 0x40144000
old_mmap(0x4014a000, 7620, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014a000
close(3)                                = 0
munmap(0x40015000, 70443)               = 0
write(2, "get-edid: get-edid version 1.4.1"..., 33get-edid: get-edid version 1.4.1
) = 33
open("/dev/zero", O_RDONLY)             = 3
old_mmap(0x10000, 65536, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x10000
open("/dev/mem", O_RDWR)                = 4
old_mmap(NULL, 1282, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 4, 0) = 0
old_mmap(0xa0000, 393216, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 4, 0xa0000) = 0xa0000
ioperm(0, 0x400, 0x1)                   = 0
iopl(0x3)                               = 0
write(2, "\n\tPerforming real mode VBE call\n", 32
	Performing real mode VBE call
) = 32
write(2, "\tInterrupt 0x10 ax=0x4f00 bx=0x0"..., 40	Interrupt 0x10 ax=0x4f00 bx=0x0 cx=0x0
) = 40
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
	Function supported
write(2, "\tCall successful\n\n", 18	Call successful

)   = 18
write(2, "\tVBE version 300\n", 17	VBE version 300
)     = 17
write(2, "\tVBE string at 0x11110 \"", 24	VBE string at 0x11110 ") = 24
write(2, "3", 13)                        = 1
write(2, "d", 1d)                        = 1
write(2, "f", 1f)                        = 1
write(2, "x", 1x)                        = 1
write(2, " ", 1 )                        = 1
write(2, "I", 1I)                        = 1
write(2, "n", 1n)                        = 1
write(2, "t", 1t)                        = 1
write(2, "e", 1e)                        = 1
write(2, "r", 1r)                        = 1
write(2, "a", 1a)                        = 1
write(2, "c", 1c)                        = 1
write(2, "t", 1t)                        = 1
write(2, "i", 1i)                        = 1
write(2, "v", 1v)                        = 1
write(2, "e", 1e)                        = 1
write(2, ",", 1,)                        = 1
write(2, " ", 1 )                        = 1
write(2, "I", 1I)                        = 1
write(2, "n", 1n)                        = 1
write(2, "c", 1c)                        = 1
write(2, ".", 1.)                        = 1
write(2, "\"\n", 2"
)                     = 2
write(2, "\nVBE/DDC service about to be cal"..., 36
VBE/DDC service about to be called
) = 36
write(2, "\tReport DDC capabilities\n", 25	Report DDC capabilities
) = 25
write(2, "\n\tPerforming real mode VBE call\n", 32
	Performing real mode VBE call
) = 32
write(2, "\tInterrupt 0x10 ax=0x4f15 bx=0x0"..., 40	Interrupt 0x10 ax=0x4f15 bx=0x0 cx=0x0
) = 40
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
[tons of this]
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
	Function supported
write(2, "\tCall successful\n\n", 18	Call successful

)   = 18
write(2, "\tMonitor and video card combinat"..., 68	Monitor and video card combination does not support DDC1 transfers
) = 68
write(2, "\tMonitor and video card combinat"..., 60	Monitor and video card combination supports DDC2 transfers
) = 60
write(2, "\t0 seconds per 128 byte EDID blo"..., 44	0 seconds per 128 byte EDID block transfer
) = 44
write(2, "\tScreen is not blanked during DD"..., 44	Screen is not blanked during DDC transfer

) = 44
write(2, "Reading next EDID block\n", 24Reading next EDID block
) = 24
write(2, "\nVBE/DDC service about to be cal"..., 36
VBE/DDC service about to be called
) = 36
write(2, "\tRead EDID\n", 11	Read EDID
)           = 11
write(2, "\n\tPerforming real mode VBE call\n", 32
	Performing real mode VBE call
) = 32
write(2, "\tInterrupt 0x10 ax=0x4f15 bx=0x1"..., 40	Interrupt 0x10 ax=0x4f15 bx=0x1 cx=0x0
) = 40
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
[tons of the same...]
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
vm86old(0x804bbcc)                      = -1 ENOSYS (Function not implemented)
	Function supported
write(2, "\tCall failed\n\n", 14	Call failed

)       = 14
write(2, "The EDID data should not be trus"..., 59The EDID data should not be trusted as the VBE call failed
) = 59
write(2, "Error: output block unchanged\n", 30Error: output block unchanged
) = 30
close(1)                                = 0
exit_group(1)                           = ?



I hope it helps.
