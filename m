Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWAEUbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWAEUbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAEUbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:31:11 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:47344 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932170AbWAEUbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:31:10 -0500
Message-ID: <43BD8206.4000103@lwfinger.net>
Date: Thu, 05 Jan 2006 14:31:02 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: spinlockup in kacpid of 2.6.15-rc6 during boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

 > On Sun, Jan 01, 2006 at 10:58:19PM -0600, Larry Finger wrote:
 >
 >> I am getting an intermittent "BUG: spinlockup on CPU #0, kacpid/13, e3bcef9c" message when 
booting. I know it occurs from a cold boot, but am not sure about from a warm reboot.
 >>
 >> I don't know where in the boot sequence it occurs as I only have the text display on the screen, 
which is as follows:
 >
 >
 >
 > You can set a higher resolution using the vga= boot parameter (see 
Documentation/kernel-parameters.txt in the kernel sources).


Thanks - I'll set as high as I can.

 >> ...... unknown material that rolled off the top of the screen
 >> _spinlock + 0x1b/0x30
 >> exit_io_context + 0x25/0x90
 >> do_exit + 0x54/0x430
 >> die + 0x17c/0x180
 >> do_page_fault + 0x209/0x62e
 >> error_code + 0x4f/0x54
 >> show_stack + 0x9c/0x0e
 >> show_registers + 0x18f/0x230
 >> die + 0xfa/0x180
 >> do_page_fault + 0x209/0x62e
 >> BUG: spinlockup on CPU #0, kacpid/13, e3bcef9c
 >> dump_stack + 0x1e/0x20
 >> __spin_lock_debug + 0xb6/0xf0
 >> _raw_spin_lock + 0x67/0x90
 >> _spinlock + 0x1b/0x30
 >> exit_io_context + 0x25/0x90
 >> do_exit + 0x54/0x430
 >> die + 0x17c/0x180
 >> do_page_fault + 0x209/0x62e
 >> error_code + 0x4f/0x54
 >> show_stack + 0x9c/0x0e
 >> show_registers + 0x18f/0x230
 >> die + 0xfa/0x180
 >> do_page_fault + 0x209/0x62e
 >>
 >> The computer is an HP ze1115 notebook with a mobile K7 processor. The beginning lines of a 
normal dmesg are:
 >>
 >> Linux version 2.6.15-rc6 (root@linux) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #4 
PREEMPT
 >> ...
 >
 >
 >
 > IOW, 2.6.15-rc6 does sometimes boot, and sometimes it doesn't boot?


Yes. I have never had it fail two times in a row. Powering off and restarting has fixed it everytime 
so far.

 > Can you give information regarding which kernel versions are affected and which aren't, and what 
influences whether 2.6.15-rc6 does boot or does not boot?


I have not had this problem (yet?) with 2.6.15-rc7 or 2.6.15; however, it occurs so infrequently 
that I'm not sure I can rule out these later versions. The case I reported involved a dirty reiserfs 
file system. I had been debugging the bcm43xx driver and the system had frozen during shutdown 
because the module could not be unloaded. After I powered off for about 1 second, I restarted. The 
bug dump occurred fairly quickly and I believe it is early in the reboot sequence.

Larry


