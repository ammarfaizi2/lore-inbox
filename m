Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUDEFpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 01:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbUDEFpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 01:45:36 -0400
Received: from mailgate4.cinetic.de ([217.72.192.167]:64737 "EHLO
	mailgate4.cinetic.de") by vger.kernel.org with ESMTP
	id S263134AbUDEFpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 01:45:08 -0400
Message-ID: <4070F11B.6020602@web.de>
Date: Mon, 05 Apr 2004 07:39:39 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa1
References: <40707888.80006@web.de> <200404041859.47940.jeffpc@optonline.net> <20040405002028.GB21069@dualathlon.random>
In-Reply-To: <20040405002028.GB21069@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> did you get an oops or just a sigsegv? (see dmesg) If you only got a
> sigsegv can you try to keep the segfaulting process under "strace -o
> /tmp/o -p <pid>" and report the last few syscalls before the segfault?
> That should reduce the scope of the problem, I had a look at the
> diff between rc3 and 2.6.5 final but I found nothing obvious that could
> explain your problem (yet).

nForce2 board, nVidia bin driver 5341 with ALSA sound driver snd_intel8x0. 
No sound daemon under my Fedora GNOME Desktop running. Online with DSL 
connection.
Ive tested it again, no chance with 2.6.5 only with rc3, switching back 
and it runs fine. ALSA changes? Or in the net code? To get sound in the 
game I do this:

echo "et.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
echo "et.x86 0 0 disable" > /proc/asound/card0/pcm0c/oss


The related part (i hope) of strace:
-------------------------------------------
sched_yield()                           = 0
sched_yield()                           = 0
sched_yield()                           = 0
sched_yield()                           = 0
sched_yield()                           = 0
sched_yield()                           = 0
sched_yield()                           = 0
sched_yield()                           = 0
gettimeofday({1081141090, 664894}, NULL) = 0
gettimeofday({1081141090, 664917}, NULL) = 0
gettimeofday({1081141090, 664944}, NULL) = 0
ioctl(36, SNDCTL_DSP_GETOPTR, 0xbffff774) = 0
time([1081141090])                      = 1081141090
gettimeofday({1081141090, 665080}, NULL) = 0
open("/home/marcus/.etwolf/etmain/etkey", O_RDONLY) = 39
close(39)                               = 0
open("/home/marcus/.etwolf/etmain/etkey", O_RDONLY) = 39
fstat64(39, {st_mode=S_IFREG|0754, st_size=67, ...}) = 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x54355000
read(39, "0000001002200311220003785725I\374CJ"..., 131072) = 67
read(39, "", 131072)                    = 0
close(39)                               = 0
munmap(0x54355000, 131072)              = 0
time([1081141090])                      = 1081141090
gettimeofday({1081141090, 665413}, NULL) = 0
time([1081141090])                      = 1081141090
gettimeofday({1081141090, 665459}, NULL) = 0
time([1081141090])                      = 1081141090
gettimeofday({1081141090, 665502}, NULL) = 0
ioctl(29, FIONREAD, [32])               = 0
read(29, "\6\0\24\1\310\t\34\0\217\0\0\0\2\0\340\1\0\0\0\0\376\377"..., 
32) = 32
gettimeofday({1081141090, 665627}, NULL) = 0
ioctl(29, FIONREAD, [32])               = 0
read(29, "\6\0\24\1\320\t\34\0\217\0\0\0\2\0\340\1\0\0\0\0\377\377"..., 
32) = 32
gettimeofday({1081141090, 665705}, NULL) = 0
ioctl(29, FIONREAD, [32])               = 0
read(29, "\6\0\24\1\330\t\34\0\217\0\0\0\2\0\340\1\0\0\0\0\376\377"..., 
32) = 32
gettimeofday({1081141090, 665794}, NULL) = 0
ioctl(29, FIONREAD, [0])                = 0
read(0, 0xbfff768f, 1)                  = -1 EAGAIN (Resource temporarily 
unavailable)
recvfrom(37, 0x93848c0, 32768, 0, 0xbfff76e0, 0xbfff76dc) = -1 EAGAIN 
(Resource temporarily unavailable)
gettimeofday({1081141090, 665962}, NULL) = 0
gettimeofday({1081141090, 665982}, NULL) = 0
ioctl(29, FIONREAD, [0])                = 0
read(0, 0xbfff768f, 1)                  = -1 EAGAIN (Resource temporarily 
unavailable)
recvfrom(37, 0x93848c0, 32768, 0, 0xbfff76e0, 0xbfff76dc) = -1 EAGAIN 
(Resource temporarily unavailable)
gettimeofday({1081141090, 666104}, NULL) = 0
ioctl(29, FIONREAD, [0])                = 0
read(0, 0xbfff768f, 1)                  = -1 EAGAIN (Resource temporarily 
unavailable)
recvfrom(37, 0x93848c0, 32768, 0, 0xbfff76e0, 0xbfff76dc) = -1 EAGAIN 
(Resource temporarily unavailable)
gettimeofday({1081141090, 666206}, NULL) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x54355000
write(1, "Received signal 11, exiting...\n", 31) = 31
write(29, "\211\2\2\0\0\0\0\0+D\1\0", 12) = 12
read(29, "\1\2\26\1\0\0\0\0\22\0\300\1\0\0\0\0\0\0\0\0\34\0\0\0\300"..., 
32) = 32
write(29, "i\2\3\0\2\0\1\0\4\0\1\1\33D\2\0\0\0\0\0 \0\2\0\0\0\0\0"..., 84) 
= 84
read(29, "\6\0\32\1\337\t\34\0\217\0\0\0\2\0\340\1\0\0\0\0\0\2\200"..., 
32) = 32
read(29, "\1\0\34\1\0\0\0\0\1\0\0\0\250\365\377\277\360\270\v\10"..., 32) = 32
munmap(0x5075b000, 266240)              = 0
-------------------------------------------------------------------------

Thanks, i will test it later with prempt off and an other driver.

Marcus

