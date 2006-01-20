Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWATXjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWATXjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWATXjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:39:18 -0500
Received: from S01060080c85517f6.wp.shawcable.net ([24.79.196.167]:8925 "EHLO
	ubb.ca") by vger.kernel.org with ESMTP id S1751195AbWATXjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:39:18 -0500
In-Reply-To: <8BD55BB2-E4C4-4E73-970B-0C4FD4EDD19B@ubb.ca>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca> <20060120044407.432eae02.akpm@osdl.org> <20060120203104.GA31803@stusta.de> <20060120144114.08f0c340.akpm@osdl.org> <8BD55BB2-E4C4-4E73-970B-0C4FD4EDD19B@ubb.ca>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E26A0E5D-844E-4608-B68E-D84374F3FFBA@ubb.ca>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Tony Mantler <nicoya@ubb.ca>
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Date: Fri, 20 Jan 2006 17:39:14 -0600
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Jan-06, at 4:47 PM, Tony Mantler wrote:

> I'm going to twiddle the configs again and see if I can make a  
> CONFIG_MK7 kernel with -march=k6

And to follow up on this, the bug is present in a kernel built with  
CONFIG_MK7 and with the compiler flags switched to "-march=k6".

I suppose that means the bug is at least compiler related. Some  
assistance/guidance here would be helpful.

To reiterate what I posted before, the compiler I'm using is straight  
out of Debian-unstable, version as follows:
$ gcc -v
Using built-in specs.
Target: i486-linux-gnu
Configured with: ../src/configure -v --enable-languages=c,c+ 
+,java,f95,objc,ada,treelang --prefix=/usr --enable-shared --with- 
system-zlib --libexecdir=/usr/lib --without-included-gettext --enable- 
threads=posix --enable-nls --program-suffix=-4.0 --enable- 
__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug --enable- 
java-awt=gtk-default --enable-gtk-cairo --with-java-home=/usr/lib/jvm/ 
java-1.4.2-gcj-4.0-1.4.2.0/jre --enable-mpfr --disable-werror --with- 
tune=i686 --enable-checking=release i486-linux-gnu
Thread model: posix
gcc version 4.0.3 20060104 (prerelease) (Debian 4.0.2-6)

I also get some oopsing on reboot, which mostly points back to the  
functions in procfs that I pointed out in a previous message. I don't  
suspect the oops report will be remarkably useful, but I'll paste it  
below for the sake of completeness.

Unable to handle kernel NULL pointer dereference at virtual address  
0000002a
printing eip:
c018ce48
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: radeon drm thermal fan button processor ac battery  
ipv6 nfs lockd sunrpc af_packet dm_mod w83627hf hwmon_vid eeprom  
i2c_isa rtc joydev evdev parport_pc i2c_viapro via_agp parport 3c59x  
mii snd_via82xx snd_ac97_codec snd_ac97_bus agpgart i2c_core snd_pcm  
snd_timer snd_page_alloc snd_mpu401_uart floppy snd_rawmidi  
snd_seq_device snd soundcore uhci_hcd usbcore ide_cd cdrom unix
CPU:    0
EIP:    0060:[proc_exe_link+40/160]    Not tainted VLI
EFLAGS: 00010202   (2.6.15.1mapstest)
EIP is at proc_exe_link+0x28/0xa0
eax: df41fa70   ebx: df41fa40   ecx: df41fa70   edx: 00000015
esi: d6dd5f18   edi: deca3824   ebp: 00000000   esp: d6dd5e18
ds: 007b   es: 007b   ss: 0068
Process start-stop-daem (pid: 2189, threadinfo=d6dd4000 task=dd419030)
Stack: deca6c08 d6dd5f18 c018edef deca6c08 d6dd5f18 d6dd5f1c d6dd4000  
c018eda0
        c016b040 d9729c40 d6dd5f18 d6dd4000 d6dd4000 d6dd4000  
d6dd4000 d6dd4000
        d6dd5f18 00000001 d6dd4000 df4b2000 c155b1a0 c155b1a0  
d9729c40 0024c5a3
Call Trace:
[proc_pid_follow_link+79/128] proc_pid_follow_link+0x4f/0x80
[proc_pid_follow_link+0/128] proc_pid_follow_link+0x0/0x80
[__link_path_walk+3136/3872] __link_path_walk+0xc40/0xf20
[link_path_walk+69/224] link_path_walk+0x45/0xe0
[path_lookup+145/384] path_lookup+0x91/0x180
[__user_walk+32/64] __user_walk+0x20/0x40
[vfs_stat+23/96] vfs_stat+0x17/0x60
[sys_stat64+16/64] sys_stat64+0x10/0x40
[syscall_call+7/11] syscall_call+0x7/0xb
Code: 90 90 90 56 53 8b 44 24 0c ff 70 f0 e8 92 c2 f8 ff 85 c0 89 c3  
5a 74 77 8d 48 30 89 c8 ff 00 0f 88 72 07 00 00 8b 13 85 d2 74 14  
<f6> 42 15 10 74 07 8b 42 4c 85 c0 75 28 8b 52 0c 85 d2 75 ec be




--
Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
--  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --

