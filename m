Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTAGR1b>; Tue, 7 Jan 2003 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbTAGR1b>; Tue, 7 Jan 2003 12:27:31 -0500
Received: from jonquil.thebachchoir.org.uk ([138.37.90.250]:36626 "EHLO
	jonquil.thebachchoir.org.uk") by vger.kernel.org with ESMTP
	id <S267427AbTAGR13>; Tue, 7 Jan 2003 12:27:29 -0500
Date: Tue, 7 Jan 2003 17:36:04 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.54-mm2 oops under io load
Message-ID: <Pine.LNX.4.51.0301071727260.3818@r2-pc>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (18Vxe3-0002YZ-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to demonstrate that xmms won't skip in 2.5 no matter what 
load you throw at the computer (by doing some stuff such as 'find /usr 
-type f -exec cat "{}" \; >/dev/null &' a few times each after hopefully 
long enough to defeat the caches), when:

kernel BUG at mm/slab.c:1516!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c013405a>]    Not tainted
EFLAGS: 00210002
EIP is at cache_alloc_refill+0x24a/0x2a0
eax: 00000003   ebx: c3318040   ecx: 00000014   edx: 00000013
esi: c3318058   edi: 00000013   ebp: 00000034   esp: ce1b5e48
ds: 007b   es: 007b   ss: 0068
Process pidof (pid: 22002, threadinfo=ce1b4000 task=c4c66640)
Stack: d0c34344 00000000 d7d2b010 d7fed9b0 d7fed9b8 d7d2b000 d7fed9a4 00200246 
       000001d0 c092814c c0134228 d7fed9a4 000001d0 00000007 c14bcddc fffffff4 
       c14bce44 c015fb9c d7fed9a4 000001d0 00000000 00000000 cc0aa00b 00b118fa 
Call Trace:
 [<c0134228>] kmem_cache_alloc+0x78/0x80
 [<c015fb9c>] d_alloc+0x1c/0x1c0
 [<c01562dd>] real_lookup+0xad/0x100
 [<c015653f>] do_lookup+0x9f/0xb0
 [<c015687e>] link_path_walk+0x32e/0x5f0
 [<c0134fbb>] cache_free_debugcheck+0x15b/0x1f0
 [<c01574ae>] open_namei+0x7e/0x390
 [<c01481b3>] filp_open+0x43/0x70
 [<c014860b>] sys_open+0x5b/0x90
 [<c0109387>] syscall_call+0x7/0xb

Code: 0f 0b ec 05 89 d7 26 c0 e9 48 fe ff ff 8b 7c 24 2c 8b 57 38 
 <6>note: pidof[22002] exited with preempt_count 1

This is under a Redhat Phoebe set-up (only altered with Rusty's modutils, 
and a viciously hacked rc.sysinit) using its (default) ext3-with-indexes 
stuff:

Linux r2-pc 2.5.54 #1 Thu Jan 2 23:09:11 GMT 2003 i686 athlon i386 GNU/Linux
  
Gnu C                  3.2.1
Gnu make               3.79.1
util-linux             2.11w
mount                  2.11w
module-init-tools      0.9.7
e2fsprogs              1.32
jfsutils               error:
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.10
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         mousedev hid usbmouse uhci_hcd usbcore ohci1394 ieee1394
parport_pc parport es1371 soundcore gameport ac97_codec sd_mod aic7xxx scsi_mod
nfs lockd sunrpc autofs4 mga via_agp agpgart atkbd i8042 serio e100 
af_packet unix

PS modules will be in a different order as it takes a fight to get my USB 
mouse recognised..

PPS xmms was still playing :-) and. until the stress test, this kernel was 
stable for 4 days
