Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272835AbRIGUYA>; Fri, 7 Sep 2001 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272836AbRIGUXu>; Fri, 7 Sep 2001 16:23:50 -0400
Received: from i1231.vwr.wanadoo.nl ([194.134.212.212]:40576 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S272835AbRIGUXa>; Fri, 7 Sep 2001 16:23:30 -0400
Date: Fri, 7 Sep 2001 22:24:07 +0200
From: Remi Turk <remi@abcweb.nl>
To: emu10k1-devel@opensource.creative.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre4 + CVS == oops
Message-ID: <20010907222407.A1008@localhost.localdomain>
Mail-Followup-To: emu10k1-devel@opensource.creative.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Using 2.4.10-pre4 and either the CVS-driver or the in-kernel one,
I'm getting an oops on loading the module.


Creative EMU10K1 PCI Audio Driver, version 0.15, 18:57:43 Sep  4 2001 
PCI: Found IRQ 11 for device 00:11.0 
emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xdc00-0xdc1f, IRQ 11 
ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023) 


The oops: (from the CVS-version)

ksymoops 2.3.5 on i686 2.4.10-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre4/ (default)
     -m /boot/System.map-2.4.10-pre4 (specified)

Sep  7 17:10:51 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004 
Sep  7 17:10:51 localhost kernel: c0113fe6 
Sep  7 17:10:51 localhost kernel: *pde = 00000000 
Sep  7 17:10:51 localhost kernel: Oops: 0002 
Sep  7 17:10:51 localhost kernel: CPU:    0 
Sep  7 17:10:51 localhost kernel: EIP:    0010:[<c0113fe6>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  7 17:10:51 localhost kernel: EFLAGS: 00010082 
Sep  7 17:10:51 localhost kernel: eax: e22bc640   ebx: 00000282   ecx: e2e85f34   edx: 00000000 
Sep  7 17:10:51 localhost kernel: esi: e22bc000   edi: 00001000   ebp: e2e85f40   esp: e2e85f2c 
Sep  7 17:10:51 localhost kernel: ds: 0018   es: 0018   ss: 0018 
Sep  7 17:10:51 localhost kernel: Process ogg123 (pid: 1831, stackpage=e2e85000) 
Sep  7 17:10:51 localhost kernel: Stack: 00000000 e2e84000 00001000 e8954394 00000206 00000000 e895444c e44791c0  
Sep  7 17:10:51 localhost kernel:        ffffffea 00000000 00001000 00000001 e2e85f68 e2e84000 e0a23600 000009d8  
Sep  7 17:10:51 localhost kernel:        c013306f e44791c0 0804cac0 00001000 e44791e0 080d6fff e7becf40 080d7000  
Sep  7 17:10:51 localhost kernel: Call Trace: [<e8954394>] [<e895444c>] [<c013306f>] [<c0124053>] [<c0106edf>]  
Sep  7 17:10:51 localhost kernel: Code: 89 4a 04 89 55 f4 89 45 f8 89 08 e8 1a f9 ff ff fa 8b 55 f8  

>>EIP; c0113fe6 <interruptible_sleep_on+26/50>   <=====
Trace; e8954394 <[emu10k1]emu10k1_audio_write+174/250>
Trace; e895444c <[emu10k1]emu10k1_audio_write+22c/250>
Trace; c013306f <sys_write+af/d0>
Trace; c0124053 <sys_brk+e3/f0>
Trace; c0106edf <system_call+33/38>
Code;  c0113fe6 <interruptible_sleep_on+26/50>
00000000 <_EIP>:
Code;  c0113fe6 <interruptible_sleep_on+26/50>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0113fe9 <interruptible_sleep_on+29/50>
   3:   89 55 f4                  mov    %edx,0xfffffff4(%ebp)
Code;  c0113fec <interruptible_sleep_on+2c/50>
   6:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  c0113fef <interruptible_sleep_on+2f/50>
   9:   89 08                     mov    %ecx,(%eax)
Code;  c0113ff1 <interruptible_sleep_on+31/50>
   b:   e8 1a f9 ff ff            call   fffff92a <_EIP+0xfffff92a> c0113910 <schedule+0/3f0>
Code;  c0113ff6 <interruptible_sleep_on+36/50>
  10:   fa                        cli    
Code;  c0113ff7 <interruptible_sleep_on+37/50>
  11:   8b 55 f8                  mov    0xfffffff8(%ebp),%edx


ver_linux output:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost.localdomain 2.4.9 #3 Tue Sep 4 18:53:23 CEST 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10s
mount                  2.10p
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.53
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc emu10k1 ac97_codec soundcore


More info on request.

Happy hacking

	Remi

-- 
Linux 2.4.9 #3 Tue Sep 4 18:53:23 CEST 2001
