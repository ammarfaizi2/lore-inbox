Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKFCYS>; Sun, 5 Nov 2000 21:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKFCYI>; Sun, 5 Nov 2000 21:24:08 -0500
Received: from cr630205-a.crdva1.bc.wave.home.com ([24.113.89.232]:4335 "EHLO
	ryan") by vger.kernel.org with ESMTP id <S129044AbQKFCYC>;
	Sun, 5 Nov 2000 21:24:02 -0500
Message-ID: <3A060BE5.8877F477@netidea.com>
Date: Sun, 05 Nov 2000 17:39:49 -0800
From: ryan <ryan@netidea.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-raid i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
In-Reply-To: <1459.973469046@kao2.melbourne.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------E36FC225D6FD5032F3B7421A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E36FC225D6FD5032F3B7421A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Which tells us precisely nothing.  Saying "a message like" is no good.
> You need to follow the procedure in linux/REPORTING-BUGS, including the
> _exact_ message, run through ksymoops if necessary.

Ok, for your enlightenment:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux pangea 2.2.16-raid #1 SMP Sat Sep 23 17:57:25 PDT 2000 i686
unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.91
Linux C Library        2.1.96
Dynamic linker         ldd (GNU libc) 2.1.96
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0i
Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss raid1
parport_probe parport_pc lp parport snd-card-ens1371 snd-ens1371 snd-pcm
snd-timer snd-ac97-codec snd-mixer snd-rawmidi snd-seq-device snd
soundcore lockd sunrpc ne2k-pci 8390 nls_cp437 vfat fat


the modules is useless because i cant do any work on 2.4.0test10, it
crashes before i can do anything useful.

Included is oops.txt and oops_rpt.txt.

A the time I took a snapshot of ksyms and modules from /proc only module
'md' was loaded... but when I start the raid array with raidstart
/dev/md0 it might have loaded other modules to handle RAID1 personality,
im not sure.  Either way the oops.txt with full trace and the report
from ksymoops is there.


My own experiments have shown this bug dissapears if I do not have SMP
compiled in...

And a final note, I applied the alpha raid patches to kernel 2.2.16 to
produce this raid array (just a simple mirror for /home), so the
question is, could it be the array data itself? perhaps mkraid under
2.4.0test10 would be good? Either way I dont think a hardcrash is a
reasonable response ;-)

-ryan
--------------E36FC225D6FD5032F3B7421A
Content-Type: text/plain; charset=us-ascii;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU: 1
EIP: 0010:[<c0223186>]
EFLAGS:  00000086
eax: c01b2824  ebx: c7ff8e80  ecx: 00000020  edx: 00000001
esi: c1234e60  edi: 00000282  ebp: 0000000e  esp: c7ff1e00
ds: 0018   es: 0018  ss: 0018
Process swapper (pid:0, stackpage=c7ff1000)
Stack:  c7ff8e80 04000001 00000020 0000000e 00000213 c101be41 0000000e c1234e60
        c7ff1e64 c02f9260 c02db9c0 0000000e c7ff1e5c c010c026 0000000e c7ff1e64
        c7ff8e80 c6bc4000 00000000 c6bc4478 00000001 00000020 c7ff8e80 c54e8f60 
Call trace: [<c010be41>] [<c010c026>] [<c010a764>] [<c88577c3>] [<c8857861>] [<c018bb11>] [<c01b10aa>]
            [<c01b9594>] [<c01b2953>] [<c01b9530>] [<c010be41>] [<c010c026>] [<c0108900>] [<c0108900>] [<c010a764>]
            [<c0108900>] [<c0108900>] [<c0100018>] [<c0108920>] [<c0108992>] [<c01e687>] [<c019c13f>]
Code: 80 3d 44 1b 29 c0 00 f3 90 7e f5 e9 9c f6 f8 ff 80 3d 44 1b
console shuts up...

--------------E36FC225D6FD5032F3B7421A
Content-Type: text/plain; charset=us-ascii;
 name="oops_rpt.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops_rpt.txt"

ksymoops 2.3.4 on i686 2.2.16-raid.  Options used
     -V (specified)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.0-test10/ (specified)
     -m /boot/System.map-2.4.0-test10 (specified)

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU: 1
EIP: 0010:[<c0223186>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00000086
eax: c01b2824  ebx: c7ff8e80  ecx: 00000020  edx: 00000001
esi: c1234e60  edi: 00000282  ebp: 0000000e  esp: c7ff1e00
ds: 0018   es: 0018  ss: 0018
Process swapper (pid:0, stackpage=c7ff1000)
Stack:  c7ff8e80 04000001 00000020 0000000e 00000213 c101be41 0000000e c1234e60
        c7ff1e64 c02f9260 c02db9c0 0000000e c7ff1e5c c010c026 0000000e c7ff1e64
        c7ff8e80 c6bc4000 00000000 c6bc4478 00000001 00000020 c7ff8e80 c54e8f60 
Call trace: [<c010be41>] [<c010c026>] [<c010a764>] [<c88577c3>] [<c8857861>] [<c018bb11>] [<c01b10aa>]
            [<c01b9594>] [<c01b2953>] [<c01b9530>] [<c010be41>] [<c010c026>] [<c0108900>] [<c0108900>] [<c010a764>]
            [<c0108900>] [<c0108900>] [<c0100018>] [<c0108920>] [<c0108992>] [<c01e687>] [<c019c13f>]
Code: 80 3d 44 1b 29 c0 00 f3 90 7e f5 e9 9c f6 f8 ff 80 3d 44 1b

>>EIP; c0223186 <stext_lock+451e/9408>   <=====
Trace; c010be41 <handle_IRQ_event+4d/78>
Trace; c010c026 <do_IRQ+a6/f4>
Trace; c010a764 <ret_from_intr+0/20>
Trace; c88577c3 <END_OF_CODE+8524/????>
Trace; c8857861 <END_OF_CODE+85c2/????>
Trace; c018bb11 <end_that_request_first+61/b8>
Trace; c01b10aa <ide_end_request+32/84>
Trace; c01b9594 <ide_dma_intr+64/9c>
Trace; c01b2953 <ide_intr+12f/198>
Trace; c01b9530 <ide_dma_intr+0/9c>
Trace; c010be41 <handle_IRQ_event+4d/78>
Trace; c010c026 <do_IRQ+a6/f4>
Trace; c0108900 <default_idle+0/34>
Trace; c0108900 <default_idle+0/34>
Trace; c010a764 <ret_from_intr+0/20>
Trace; c0108900 <default_idle+0/34>
Trace; c0108900 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cc>
Trace; c0108920 <default_idle+20/34>
Trace; c0108992 <cpu_idle+3e/54>
Trace; 0c01e687 Before first symbol
Trace; c019c13f <unblank_screen+7b/c4>
Code;  c0223186 <stext_lock+451e/9408>
00000000 <_EIP>:
Code;  c0223186 <stext_lock+451e/9408>   <=====
   0:   80 3d 44 1b 29 c0 00      cmpb   $0x0,0xc0291b44   <=====
Code;  c022318d <stext_lock+4525/9408>
   7:   f3 90                     repz nop 
Code;  c022318f <stext_lock+4527/9408>
   9:   7e f5                     jle    0 <_EIP>
Code;  c0223191 <stext_lock+4529/9408>
   b:   e9 9c f6 f8 ff            jmp    fff8f6ac <_EIP+0xfff8f6ac> c01b2832 <ide_intr+e/198>
Code;  c0223196 <stext_lock+452e/9408>
  10:   80 3d 44 1b 00 00 00      cmpb   $0x0,0x1b44


--------------E36FC225D6FD5032F3B7421A--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
