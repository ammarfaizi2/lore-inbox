Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKHIV6>; Wed, 8 Nov 2000 03:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKHIVs>; Wed, 8 Nov 2000 03:21:48 -0500
Received: from [62.98.133.238] ([62.98.133.238]:5636 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S129044AbQKHIVf>; Wed, 8 Nov 2000 03:21:35 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 3c509 crash (maybe)
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 08 Nov 2000 09:21:44 +0100
Message-ID: <87r94m6fhj.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, with test10 I get this oops during boot, at the moment of
initializing eth0 (a 3c509b, loaded as module). What looks strange is
that the decoded oops shows stuff from the awe32 sound card that was
initalized right before this:


Unable to handle kernel NULL pointer dereference at virtual address 00000070
ca8cb5a5
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<ca8cb5a5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: dd24a000   ebx: 00000004   ecx: 00000070   edx: 00000070
esi: 00000000   edi: 00000003   ebp: 00000300   esp: c5e97f08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 116, stackpage=c5e97000)
Stack: 00000000 00000000 ca8cb04e ffffffea c5e97f3c c5e97f2c 00000070 0000000a
       51ff0001 ca8cb04e ffffffea c1044010 c02ade0c dd24a000 ffff1139 ca8cc209
       00000000 ca8cb000 00000001 c0117888 c5e96000 400299cc bfffe0c4 bfffe084
Call Trace: [<ca8cb04e>] [<ca8cb04e>] [<dd24a000>] [<ffff1139>] [<ca8cc209>] [<ca8cb000>] [<c0117888>]
       [<ca8cb048>] [<ca8a4000>] [<ca8cb048>] [<c010a32f>] [<c025002b>]
Code: 89 02 8b 44 24 38 66 89 42 04 8b 4c 24 40 89 69 20 8b 44 24

>>EIP; ca8cb5a5 <[3c509].text.start+545/6d4>   <=====
Trace; ca8cb04e <[awe_wave].bss.end+124f/1261>
Trace; ca8cb04e <[awe_wave].bss.end+124f/1261>
Trace; dd24a000 <END_OF_CODE+128f6da0/????>
Trace; ffff1139 <END_OF_CODE+3569ded9/????>
Trace; ca8cc209 <[3c509]init_module+55/70>
Trace; ca8cb000 <[awe_wave].bss.end+1201/1261>
Trace; c0117888 <sys_init_module+3d0/440>
Trace; ca8cb048 <[awe_wave].bss.end+1249/1261>
Trace; ca8a4000 <[opl3]__module_parm_io+143a/149a>
Trace; ca8cb048 <[awe_wave].bss.end+1249/1261>
Trace; c010a32f <system_call+33/38>
Trace; c025002b <IRQ0x9b_interrupt+3/8>
Code;  ca8cb5a5 <[3c509].text.start+545/6d4>
0000000000000000 <_EIP>:
Code;  ca8cb5a5 <[3c509].text.start+545/6d4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  ca8cb5a7 <[3c509].text.start+547/6d4>
   2:   8b 44 24 38               mov    0x38(%esp,1),%eax
Code;  ca8cb5ab <[3c509].text.start+54b/6d4>
   6:   66 89 42 04               mov    %ax,0x4(%edx)
Code;  ca8cb5af <[3c509].text.start+54f/6d4>
   a:   8b 4c 24 40               mov    0x40(%esp,1),%ecx
Code;  ca8cb5b3 <[3c509].text.start+553/6d4>
   e:   89 69 20                  mov    %ebp,0x20(%ecx)
Code;  ca8cb5b6 <[3c509].text.start+556/6d4>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax



Yes, ksymoops was using the right System.map-2.4.0-test10. 

I don't know if this may be related but in test9, despite all
functioning properly, I have this strange indication in /proc/modules:

3c509                   7088   1 (autoclean)
isa-pnp                27280   0 (autoclean) [3c509]

I am pretty sure that the 3c509B is NOT an isa-pnp card (also pnpdump
shows nothing), and then, even if it be, shouldn't the isa-pnp module
be unloaded after setting up the card ?

Just to complete the scene, I had to add isapnp=0 to the options
passed to sb, to get it to work.

Is there a way that I can disable the isapnp module from the command
line without recompiling ?

Thanks

Pf

-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.0-test9 #1 Wed Oct 4 11:51:25 CEST 2000 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
