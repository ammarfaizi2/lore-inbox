Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbTFSJxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbTFSJxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:53:00 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:3529 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265749AbTFSJw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:52:58 -0400
Subject: alsa sound module on 2.5.72 --- does not create /dev/snd/controlC0
From: celestar@t-online.de (Frank Victor Fischer)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056017227.3327.76.camel@darkstar.fischer.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Jun 2003 12:07:08 +0200
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: E65lqaZ6YeJNf51kck07F5mnEKByAeIQ7GDfGIY+vL7ewM7MffA0gk@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello out there

I have just switched from 2.5.70 to 2.5.72 on my test box, and found
that I have problems using the mixer for emu10k1, with both alsamixer
and amixer. Using 2.5.71 hit the same problem.

Next, I have used the 2.5.70 source tree for the 2.5.72 build, but the
problem persists.

I have then straced the command "amixer set Master 50 unmute" on both
2.5.70 and 2.5.72, which revealed that on .72 /dev/snd/controlC0 is not
created (the mixer program cannot open it), because /dev/snd is a
symbolic link to /proc/asound/dev which does not exist.

What am I missing?
I am not on the mailing list, so if possible CC to celestar@t-online.de


Thanks in advance.
Victor

(partial output from strace amixer set Master 50 unmute follows)
=====
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7034, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7034, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0x8053000)                          = 0x8053000
brk(0x8054000)                          = 0x8054000
brk(0x8055000)                          = 0x8055000
read(3, "efaults.ctl.card\n\t\t\t}\n\t\t}\n\t}\n\tty"..., 4096) = 2938
brk(0x8056000)                          = 0x8056000
brk(0x8057000)                          = 0x8057000
brk(0x8058000)                          = 0x8058000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
brk(0x8059000)                          = 0x8059000
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC0", O_RDONLY)          = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC0", O_RDONLY)          = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or directory)
write(2, "amixer: ", 8)                 = 8
write(2, "Mixer attach default error: No s"..., 53) = 53
========

