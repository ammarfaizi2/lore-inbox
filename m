Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRB1Re7>; Wed, 28 Feb 2001 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRB1Ret>; Wed, 28 Feb 2001 12:34:49 -0500
Received: from mail.surgient.com ([63.118.236.3]:1541 "EHLO
	bignorse.SURGIENT.COM") by vger.kernel.org with ESMTP
	id <S129066AbRB1Req>; Wed, 28 Feb 2001 12:34:46 -0500
Message-ID: <A490B2C9C629944E85CE1F394138AF957FC3EA@bignorse.SURGIENT.COM>
From: "Collins, Tom" <Tom.Collins@Surgient.com>
To: linux-kernel@vger.kernel.org
Cc: "Collins, Tom" <Tom.Collins@Surgient.com>
Subject: Multiple file module build problems
Date: Wed, 28 Feb 2001 11:34:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

I am trying to build a multiple-file kernel module, and am
having some difficulty.  It seems that the linker is trying
to build and executable.

The paradigm I am using is from
http://www.linuxdoc.org/LDP/lkmpg/node13.html.
I compile two source files with the following gcc command:

gcc -c -D__KERNEL__ -I/usr/src/linux/include -DMODULE -Wall -O2 -DLINUX
schar.c
gcc -c -D__KERNEL__ -I/usr/src/linux/include -DMODULE -Wall -O2 -DLINUX
procschar.c
/usr/src/linux/include/linux/mount.h: In function `mntput':
In file included from /usr/src/linux/include/linux/dcache.h:7,
                 from /usr/src/linux/include/linux/fs.h:19,
                 from procschar.c:25:
/usr/src/linux/include/linux/mount.h:46: warning: implicit declaration of
function `printk_Rsmp_1b7d4074'
procschar.c: At top level:
procschar.c:41: warning: `schar_mmap' defined but not used

I have the statement: #define __NO_VERSION__
in procschar.c, but not in schar.c.

The link command is:

ld -m elf_i386 -o scharmod.o schar.o procschar.o

At this point I get reams of output such as:

ld: warning: cannot find entry symbol _start; defaulting to 08048080
schar.o: In function `schar_timer_handler':
schar.o(.text+0x21): undefined reference to `jiffies_Rsmp_0da02d67'
schar.o(.text+0x40): undefined reference to `add_timer_Rsmp_a19eacf8'
schar.o(.text+0x5c): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x65): undefined reference to `__this_module'
schar.o(.text+0x6d): undefined reference to `__this_module'
schar.o(.text+0x81): undefined reference to `__this_module'
schar.o(.text+0xa2): undefined reference to `__wake_up_Rsmp_b173f14c'
schar.o(.text+0xb6): undefined reference to `__wake_up_Rsmp_b173f14c'
schar.o: In function `schar_ioctl':
schar.o(.text+0x262): undefined reference to `__get_user_4'
schar.o(.text+0x2a9): undefined reference to `__get_user_4'
schar.o(.text+0x2e9): undefined reference to `__get_user_4'
schar.o(.text+0x33f): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x34c): undefined reference to `printk_Rsmp_1b7d4074'
schar.o: In function `schar_read_proc':
schar.o(.text+0x390): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x3a1): undefined reference to `get_zeroed_page_Rsmp_6807e076'
schar.o(.text+0x3b8): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x3cb): undefined reference to
`__generic_copy_from_user_Rsmp_116166aa
schar.o(.text+0x3e6): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x3f5): undefined reference to `free_pages_Rsmp_234535e0'
schar.o(.text+0x41b): undefined reference to `sprintf_Rsmp_3c2c5af5'
schar.o(.text+0x435): undefined reference to `sprintf_Rsmp_3c2c5af5'
schar.o(.text+0x44f): undefined reference to `sprintf_Rsmp_3c2c5af5'
schar.o(.text+0x46c): undefined reference to `sprintf_Rsmp_3c2c5af5'
schar.o(.text+0x486): undefined reference to `sprintf_Rsmp_3c2c5af5'
schar.o(.text+0x49a): more undefined references to `sprintf_Rsmp_3c2c5af5'
follow
schar.o: In function `schar_read_proc':
schar.o(.text+0x52e): undefined reference to `proc_dostring_Rsmp_3954dab5'
schar.o: In function `schar_read':
schar.o(.text+0x563): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x59b): undefined reference to
`__generic_copy_to_user_Rsmp_d523fdd3'
schar.o(.text+0x5e9): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x5f6): undefined reference to
`interruptible_sleep_on_Rsmp_8c23e4cb'
schar.o(.text+0x612): undefined reference to `printk_Rsmp_1b7d4074'
schar.o(.text+0x639): undefined reference to
`__generic_copy_to_user_Rsmp_d523fdd3'
schar.o(.text+0x673): undefined reference to `printk_Rsmp_1b7d4074'
schar.o: In function `schar_write':
schar.o(.text+0x6b0): undefined reference to
`__generic_copy_from_user_Rsmp_116166aa
schar.o(.text+0x6db): undefined reference to `__wake_up_Rsmp_b173f14c'
schar.o(.text+0x6ef): undefined reference to `__wake_up_Rsmp_b173f14c'
schar.o(.text+0x709): undefined reference to `printk_Rsmp_1b7d4074'
schar.o: In function `schar_poll':

My guess is that I need to explicitly link with some kernel
objects? Can anyone point me in the right direction?

Thanks

Tom

-----Original Message-----
From: matthew.copeland@honeywell.com
[mailto:matthew.copeland@honeywell.com]
Sent: Wednesday, February 28, 2001 11:07 AM
To: linux-kernel@vger.kernel.org
Subject: drivers/block/rd.c under 2.2.16



I am attempting to get something figured out dealing with the ramdisk
under Linux 2.2.16.  I am trying to figure out whether you can use the
ramdisk to act as a RAM filesystem doing normal file creations and
deletion.  I noticed that within the code it makes comments about not
having to free stuff up.  Does that mean you can't delete things off the
ramdisk filesystem?  I have created a ramdisk, formatted ext2, and mounted
it.  When I create stuff on there, and then I delete it, I notice that if
I do a df, the size doesn't go back down after I have deleted the file.  
I am trying to figure out if that is how it was intended to happen, or
whether I have just done something not quite correctly and you can't
really use it as a RAM file system.

Thanks,
Matthew M. Copeland





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
