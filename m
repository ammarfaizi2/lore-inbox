Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317564AbSGRJnt>; Thu, 18 Jul 2002 05:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSGRJnt>; Thu, 18 Jul 2002 05:43:49 -0400
Received: from basket.ball.reliam.net ([213.91.6.7]:56838 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S317564AbSGRJns>; Thu, 18 Jul 2002 05:43:48 -0400
Date: Thu, 18 Jul 2002 11:48:00 +0200
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <1251977776.20020718114800@uni.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[3]: 2.5.26 broken on headless boxes
In-Reply-To: <20020718010617.GL1096@holomorphy.com>
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk>
 <20020718010617.GL1096@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello William,

Thursday, July 18, 2002, 3:06:17 AM, you wrote:

>> [... kernelpanic ...]

> Could you reproduce this and get maybe a backtrace and a line number?

I just want to say that I do get a similiar panic (i hope it's the
same reason and I do not mix up something), the story about the
trouble which 2.5.26 is causing I will expound below:

-snip-
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c025a9d7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025a9d7>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c039e060   ecx: 00000013   edx: c02db5d4
esi: 00000014   edi: 00000000   ebp: c02dc85c   esp: c11f3f98
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, threadinfo=c11f2000 task=c11f0040)
Stack: c02f86cc c02dc85c 00000014 00000000 c02dffc8 c039df41 0008e000 00000005
       c039e000 c02f8618 c039df20 c11c5360 00000000 c02589ac c031ebe8 00000000
       c02e0746 c11f2000 c02e077f c0105073 00010f00 c02dffc8 c01056a4 00000000
Call Trace: [<c02589ac>] [<c0105073>] [<c01056a4>]

Code: 83 38 00 75 f4 0f b7 c1 c3 8b 54 24 04 8b 4c 24 08 31 c0 49
 <0>Kernel panic: Attempted to kill init!
-snap-

Sorry, I am just a guy having free time to test dev-kernels and to
report bugs if there are some, but I do not really know what you mean
with "backtrace" and how i should discover the effecting line number.
Please do not spare with seemingly trivial information.

Well then to the 2.5.26 misadventure story:
I patched from 2.5.25 to .26 and first it didn't want to be compiled
until I created a symlink from /usr/include/asm-generic to
/usr/src/linux/include/asm-generic (while /usr/src/linux is a symlink
to /usr/src/linux-2.5.26) - for me it seemed as if the makefile
doesn't care about include/ in the kernelsource dir, although this file
seems to be proper - a failure/ignorance of mine i do not exclude
though (if someone want to recommend to use the whole tarball, i tried
it already).

However, after the creation it compiled using the old config file of
2.5.25. The image did even boot, init stopped though when the gettys
should be invoked. So far so bad, I modified the /etc/inittab not to
use the vc's but the ordinary console instead - and the kernel
successfully booted and I could work.

This phenomenon looks like the VCs are broken, but I am absolutely not
sure, because none has complained about them so far.

To make sure I wanted to build a kernel completely new (and not just
using the old configfile), but during the boot of the resulting kernelimage I
got the panic above. If somebody wants, I can create a diff between the
configfile used by the kernel where the VCs seems to be broken and the
one of the kernel causing the panic.

--
cheers,
  Tobias

http://freebits.org

