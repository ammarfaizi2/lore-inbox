Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUHNVrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUHNVrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUHNVrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 17:47:53 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:51855 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S266219AbUHNVrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 17:47:49 -0400
Message-ID: <411E87A7.1000500@softhome.net>
Date: Sat, 14 Aug 2004 14:44:07 -0700
From: Brannon Klopfer <plazmcman@softhome.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic, 2.6.8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.8
IBM ThinkPad 600E (PII)
Slackware-current (mostly)
---
plaz:~$ /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux littleblue 2.6.8 #67 Sat Aug 14 11:32:19 PDT 2004 i686 unknown 
unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ircomm_tty ircomm nsc_ircc irda crc_ccitt nfsd 
exportfs intel_agp uhci_hcd serial_cs 3c574_cs ds yenta_socket 
pcmcia_core snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib 
snd_mpu401_uart snd_rawmidi snd_cs4231_lib agpgart
#note that ver_linux was of course run after the panic,
#but the modules should be the same. Also, the build machine,
#although different, should have the same software.
--------------------------
While I was upgradeing my kernel (from 2.6.7), an odd chain of events 
happened, ending in a full blown kernel panic. As best as I can 
remember, this is what happened:

I fired up my tower (2.6.7), ssh'ed into it with my laptop (2.6.7), and 
compiled it (my laptop's a lot slower than my tower). Then I downloaded, 
via NFS, the 2.6.8 modules, kernel, and System.map onto my laptop. Then 
I upgraded the tower. Rebooted, both running 2.6.8, so far so good. 
Wanted to fine-tune the kernel config, so I did the whole process over: 
However, "cp" segfaulted when trying to copy the kernel/System.map:

# cp -v System.map vmlinuz /
    `vmlinuz' -> `/vmlinuz'
    Segmentation Fault
#

Now, the files are fine (can cat them from tower). I think it was NFSv3, 
as I forgot to enable NFSv4 at the time (*not sure*). So, I went to 
unmount the tower from the laptop, and umount just stalled. Was 
recompiling kernel with support for NFSv4 (I *think*), so I put my 
laptop to sleep (apm -S) - nothing happened. Tried suspending it, no go. 
Tried shutting down, rebooting, nothing. There were a number of apm 
proccesses (that I started) going, tried killing them, but they 
woulcdn't die (even with SIGKILL). So I went to runlevel one (init 1), 
and that's when I got a kernel panic. I took a picture of the screen, 
but it's kinda hard to read. I'll mail it to anyone who wants it.

Not sure what info you want, but here's some of it:

Call Trace:
code: 38 1f 45 c0 c0 4f 3c c1 ff 12 2d 00 6e ad 87 4b 40 74 13 c0
#not sure if I got the call trace right, hard to read my bad pic.
#...
kernel BUG at kernel/timer.c:405!
invalid operand: 0000 [#18]
#again, can't be 100% sure that's what's written. Sure about the 
timer.c:405, though.

Hope this helps. Oh, probably not at all related, but my computer slows 
the CPU clock down when it's on batteries (which it wasn't, I don't 
think), so I'll sometimes get a "losing too many ticks" in my dmesg. 
CPUfreq drivers don't seem to work with it, a PII.

-Brannon Klopfer


