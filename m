Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLFXHo>; Wed, 6 Dec 2000 18:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFXHe>; Wed, 6 Dec 2000 18:07:34 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:49682 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129415AbQLFXHS>; Wed, 6 Dec 2000 18:07:18 -0500
Message-ID: <3A2EBF17.9010509@megapathdsl.net>
Date: Wed, 06 Dec 2000 14:35:03 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012061150460.1917-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for the reply.

I agree with your analysis of the information I reported
in this message.  However, in previous related bug reports
I mentioned actual functional conflicts between the drivers.

Here is what goes wrong:

Dec  6 04:21:32 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.
Dec  6 04:21:32 agate kernel: eth0: using default media MII
Dec  6 04:21:32 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.
Dec  6 04:21:32 agate kernel: eth0: using default media MII
Dec  6 04:21:32 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.
Dec  6 04:21:33 agate kernel: eth0: using default media MII
Dec  6 04:21:33 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.
Dec  6 04:21:33 agate kernel: eth0: using default media MII
Dec  6 04:21:33 agate kernel: eth0: Too much work in interrupt, status 
e003.
Dec  6 04:21:33 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.
Dec  6 04:21:33 agate kernel: eth0: using default media MII
Dec  6 04:21:33 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.
Dec  6 04:21:33 agate kernel: eth0: using default media MII
Dec  6 04:21:33 agate kernel: eth0: Host error, FIFO diagnostic register 
0000.

The repro case is to simply get both drivers happily loaded, insert
my USB mouse and restart XFree86 so the USB mouse gets used, then
copy a file from an FTP site while moving the mouse.

Here's an strace of modprobe usb-ohci:


query_module(NULL, QM_SYMBOLS, 0x806afe0, 16384, 21890) = -1 ENOSPC (No 
space left on device)
brk(0x8076000)                          = 0x8076000
query_module(NULL, QM_SYMBOLS, { /* 930 entries */ }, 930) = 0
lseek(3, 0, SEEK_SET)                   = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 
52) = 52
lseek(3, 15100, SEEK_SET)               = 15100
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
560) = 560
lseek(3, 64, SEEK_SET)                  = 64
read(3, "WVS\213t$\0241\333\17\267V\0049\323}\34\215~\20\213\4\237"..., 
13074) = 13074
lseek(3, 18756, SEEK_SET)               = 18756
read(3, "\35\0\0\0\2:\0\0/\0\0\0\2:\0\0o\0\0\0\2;\0\0\213\0\0\0"..., 
2248) = 2248
lseek(3, 13152, SEEK_SET)               = 13152
read(3, "\0\0\0\0\254\377\377\377\271\377\377\377\254\377\377\377"..., 
192) = 192
lseek(3, 21004, SEEK_SET)               = 21004
read(3, "@\0\0\0\1\3\0\0D\0\0\0\1\3\0\0L\0\0\0\1\2\0\0P\0\0\0\1"..., 96) 
= 96
lseek(3, 13376, SEEK_SET)               = 13376
read(3, "kernel_version=2.4.0-test12\0\0\0\0\0"..., 140) = 140
lseek(3, 13536, SEEK_SET)               = 13536
read(3, "/usr/src/linux/include/linux/mou"..., 1393) = 1393
lseek(3, 21100, SEEK_SET)               = 21100
read(3, "\350\2\0\0\1\2\0\0\354\2\0\0\1\2\0\0\360\2\0\0\1\2\0\0"..., 
160) = 160
lseek(3, 14929, SEEK_SET)               = 14929
read(3, "\0GCC: (GNU) egcs-2.91.66 1999031"..., 61) = 61
lseek(3, 14990, SEEK_SET)               = 14990
read(3, "\0.symtab\0.strtab\0.shstrtab\0.text"..., 108) = 108
lseek(3, 15660, SEEK_SET)               = 15660
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0"..., 
1664) = 1664
brk(0x8077000)                          = 0x8077000
lseek(3, 17324, SEEK_SET)               = 17324
read(3, "\0usb-ohci.c\0gcc2_compiled.\0__mod"..., 1430) = 1430
brk(0x8078000)                          = 0x8078000
lstat("/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/lib/modules", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/lib/modules/2.4.0-test12", {st_mode=S_IFDIR|0775, st_size=4096, 
...}) = 0
lstat("/lib/modules/2.4.0-test12/kernel", {st_mode=S_IFDIR|0755, 
st_size=4096, ...}) = 0
lstat("/lib/modules/2.4.0-test12/kernel/drivers", {st_mode=S_IFDIR|0755, 
st_size=4096, ...}) = 0
lstat("/lib/modules/2.4.0-test12/kernel/drivers/usb", 
{st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/lib/modules/2.4.0-test12/kernel/drivers/usb/usb-ohci.o", 
{st_mode=S_IFREG|0644, st_size=21260, ...}) = 0
stat("/lib/modules/2.4.0-test12/kernel/drivers/usb/usb-ohci.o", 
{st_mode=S_IFREG|0644, st_size=21260, ...}) = 0
create_module("usb-ohci", 15072)        = 0xc5891000
brk(0x807c000)                          = 0x807c000
init_module("usb-ohci", 0x8077d10 <unfinished ...>

I will test again with usb-ohci and 3c59x built into
the kernel.

As always, many thanks for your help!

	Miles

<snip>

> The only thing in common between the two will be the fact that they do
> share the same irq, and I'm not at all sure that those two drivers are
> always happy about irq sharing.
> 
> Your dmesg output looks sane and happy, though. Both the USB and the 3c59x
> driver find their hardware, and claim to have successfully initialized
> them. The USB driver even finds the stuff on the USB bus (microsoft
> intellimouse), so it obviously works to a large degree. Similarly, the
> ethernet driver happily finds everything etc.
> 
> In fact, everything looks so happy that I bet that the reason the module
> is stuck initializing is some setup problem, possibly because kusbd ends
> up waiting on /sbin/hotplug or similar. It does not look like the drivers
> themselves would have trouble, it looks much more like a modprobe-related
> issue (maybe deadlocking on some semaphore or other lock).
> 
> I'd suggest two things:
> 
>  - try not using modules. Does it "just work" for you then? (Both the OHCI
>    and the 3c59x driver should happily work with hotplug compiled right
>    into the kernel).
> 
>  - try "strace"ing the whole modprobe thing, to see where it hangs, in
>    order to figure out what it is waiting for. I wonder if it's the
>    keventd changes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
