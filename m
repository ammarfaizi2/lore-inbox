Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274070AbRISOV6>; Wed, 19 Sep 2001 10:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274069AbRISOVw>; Wed, 19 Sep 2001 10:21:52 -0400
Received: from pscgate.progress.com ([192.77.186.1]:35266 "EHLO
	pscgate.progress.com") by vger.kernel.org with ESMTP
	id <S274070AbRISOVn>; Wed, 19 Sep 2001 10:21:43 -0400
Subject: Coda and Ext3
From: "Sujal Shah" <sshah@progress.com>
Reply-To: sujal@sujal.net
To: Jan Harkes <jaharkes@cs.cmu.edu>, codalist@TELEMANN.coda.cs.cmu.edu
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <20010906115302.B826@cs.cmu.edu>
In-Reply-To: <3B9792FB.7020708@progress.com> 
	<20010906115302.B826@cs.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.17.07.08 (Preview Release)
Date: 19 Sep 2001 10:23:36 -0400
Message-Id: <1000909441.2017.20.camel@pcsshah>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

     The Linux Coda drivers and the ext3 patches don't seem to get along
very well, at least in Linux 2.4.7.  I've got a stock 2.4.7 kernel with
a patch applied to the USB drivers (for a sony digital camera; see
http://www.sujal.net/tech/linux/ just a change in unusual_devs.h). 

After I applied the ext3 patches from
http://www.uow.edu.au/~andrewm/linux/ext3/ .  Basically, when an
application tries to write to a file system mounted via coda, the
application terminates with "Memory Fault" returned to the terminal. 
THe file system still thinks it's busy (can't umount).

I'm using the ext3-2.4-0.9.5-247 patch.  I have not yet tried a newer
kernel.

THe funny thing is that mounting/unmount works fine as long as I don't
try to write.  Also, I can create files via touch or mkdir without
causing problems.  The following log snippet shows me mounting then
immediately unmounting the filesystem, then remounting and trying a
write operation (using cp).

Just to let everyone know, I am running my own replacement for venus
(something similar to podfuk/uservfs), and I do have the NVidia drivers
loaded.  I was able to recreate this bug without the NVdriver module
loaded, however.  Also, I backed out the patches for ext3 and the
problem went away.

THe following messages appear in my syslog:

Sep 18 19:02:00 pcsshah kernel: Coda Kernel/Venus communications, v5.3.14, coda@cs.cmu.edu
Sep 18 19:02:16 pcsshah kernel: coda_read_super: Bad mount version
Sep 18 19:02:16 pcsshah kernel: coda_read_super: device index: 0
Sep 18 19:02:16 pcsshah kernel: coda_read_super: rootfid is (0x1234567,0xffffffff,0x1)
Sep 18 19:02:16 pcsshah kernel: coda_read_super: rootinode is 1450180609 dev 7
Sep 18 19:03:04 pcsshah kernel: Coda: Bye bye.
Sep 18 19:03:50 pcsshah gconfd (sujal-1184): 21 items remain in the cache after cleaning already-synced items older than 300 seconds
Sep 18 19:04:34 pcsshah kernel: coda_read_super: Bad mount version
Sep 18 19:04:34 pcsshah kernel: coda_read_super: device index: 0
Sep 18 19:04:34 pcsshah kernel: coda_read_super: rootfid is (0x1234567,0xffffffff,0x1)
Sep 18 19:04:34 pcsshah kernel: coda_read_super: rootinode is 1450180609 dev 7
Sep 18 19:05:02 pcsshah kernel: kernel BUG at file.c:45!
Sep 18 19:05:02 pcsshah kernel: invalid operand: 0000
Sep 18 19:05:02 pcsshah kernel: CPU:    0
Sep 18 19:05:02 pcsshah kernel: EIP:    0010:[<e59a73df>]
Sep 18 19:05:02 pcsshah kernel: EFLAGS: 00210282
Sep 18 19:05:02 pcsshah kernel: eax: 00000019   ebx: d403e1a0   ecx: 00000006   edx: 00000000
Sep 18 19:05:02 pcsshah kernel: esi: ffffffea   edi: d3eaf240   ebp: d3f71de0   esp: d36f3f60
Sep 18 19:05:02 pcsshah kernel: ds: 0018   es: 0018   ss: 0018
Sep 18 19:05:02 pcsshah kernel: Process cp (pid: 1650, stackpage=d36f3000)
Sep 18 19:05:02 pcsshah kernel: Stack: e59acb2c e59acc83 0000002d d3f71de0 ffffffea 00000000 00000400 c0130f96 
Sep 18 19:05:02 pcsshah kernel:        d3f71de0 bfffef10 00000400 d3f71e00 00000000 0009bce9 00000000 d3a78b60 
Sep 18 19:05:02 pcsshah kernel:        d383ede0 00000000 d3f719c0 bffff308 d36f2000 00000400 bfffef10 bfffeef8 
Sep 18 19:05:02 pcsshah kernel: Call Trace: [sys_write+150/208] [system_call+51/56] 
Sep 18 19:05:02 pcsshah kernel: 
Sep 18 19:05:02 pcsshah kernel: Code: 0f 0b 83 c4 0c 8b 43 08 8b 70 08 8d 5e 5c 89 d9 ff 4e 5c 0f 

Just FYI. 

Thanks,

Sujal

-- 
---- Sujal Shah --- sujal@sujal.net ---

        http://www.sujal.net

Now Playing: George Michael - Freedom 90

