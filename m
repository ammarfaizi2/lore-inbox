Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289122AbSAJSLK>; Thu, 10 Jan 2002 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289428AbSAJSK7>; Thu, 10 Jan 2002 13:10:59 -0500
Received: from marvin.nildram.co.uk ([195.112.4.71]:44554 "HELO
	marvin.nildram.co.uk") by vger.kernel.org with SMTP
	id <S289122AbSAJSKp>; Thu, 10 Jan 2002 13:10:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fernando Jimenez <f.jimenez@bigfoot.com>
Reply-To: f.jimenez@bigfoot.com
To: linux-kernel@vger.kernel.org
Subject: array size limit in module?
Date: Thu, 10 Jan 2002 18:13:53 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020110181054Z289122-13997+3040@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am trying to code a simple kernel module and I have found a problem I don't 
quite understand.

Here is the offending part of code:

char *sectors_array = NULL;
........
secs_size=131072;
sectors_array = kmalloc(secs_size*sizeof(char), GFP_KERNEL); 
for(i=0; i<secs_size; i++) {
	sectors_array[i]=0;
}

This bit of code, as it is, works fine. However, if I increment secs_size by 
one, ie, I do 'secs_size=131073;' instead of 131072, I get the following:

 Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 10 18:14:47 localhost kernel:  printing eip:
Jan 10 18:14:47 localhost kernel: c4829475
Jan 10 18:14:47 localhost kernel: *pde = 00000000
Jan 10 18:14:47 localhost kernel: Oops: 0002
Jan 10 18:14:47 localhost kernel: CPU:    0
Jan 10 18:14:47 localhost kernel: EIP:    0010:[<c4829475>]    Not tainted
Jan 10 18:14:47 localhost kernel: EFLAGS: 00000297
Jan 10 18:14:47 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 
00000001   edx: c1467f64
Jan 10 18:14:47 localhost kernel: esi: 000000fe   edi: 00000000   ebp: 
c3567f28   esp: c3567f20
Jan 10 18:14:47 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 18:14:47 localhost kernel: Process insmod (pid: 979, 
stackpage=c3567000)
Jan 10 18:14:47 localhost kernel: Stack: c4829000 00000000 0806fc58 c011a1e5 
00000000 c2f70000 00000d30 c3c0a000
Jan 10 18:14:47 localhost kernel:        00000060 ffffffea 00000007 c0a423cc 
00000060 c02caac0 c4829060 00000f90
Jan 10 18:14:47 localhost kernel:        00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000
Jan 10 18:14:47 localhost kernel: Call Trace: [<c011a1e5>] [<c4829060>] 
[<c01075bb>]
Jan 10 18:14:47 localhost kernel:
Jan 10 18:14:47 localhost kernel: Code: c6 04 03 00 83 ec 08 53 68 ce 9c 82 
c4 e8 a9 f8 8e fb 83 c4

I'm using kernel version 2.4.17 under RH7.2. I originally thought It could be 
related to lack of memory. 'free' returns this:

 total       used       free     shared    buffers     cached
Mem:         61672      54828       6844          0       1972      41060
-/+ buffers/cache:      11796      49876
Swap:       321292          0     321292

but there is plenty of swap space in there. I also tried increasing the RAM 
to 128Mb but that didn't help either

Any help will be very much appreciated, and sorry if I'm making an obvious 
mistake. I'm quite new to kernel programming. :)

FJ
