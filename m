Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135962AbREBGaw>; Wed, 2 May 2001 02:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135974AbREBGan>; Wed, 2 May 2001 02:30:43 -0400
Received: from qn-212-127-137-79.quicknet.nl ([212.127.137.79]:1540 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id <S135962AbREBGae>;
	Wed, 2 May 2001 02:30:34 -0400
Date: Wed, 2 May 2001 08:30:18 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi module
Message-ID: <20010502083018.A5717@qn-212-127-137-79.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-operating-system: Linux qn-212-127-137-79 2.4.4-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here I am with another, fresh oops that I encountered while exploring
new kernels. This time, the oops is generated when trying to load the
module for a very old (1993) Future Domain SCSI card. 2.4.3-ac7 was my
previous kernel and worked perfectly. Now, loading the module
generates the following OOPS:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

ksymoops 2.3.7 on i686 2.4.4-ac3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac3/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000078
c712a847
Oops: 0002
CPU:    0
EIP:    0010:[<c712a847>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000142   ecx: c3c36a40   edx: 00000000
esi: c712cce0   edi: 00000148   ebp: 00003080   esp: c4579ec0
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 5603, stackpage=c4579000)
Stack: c712cce0 00000001 00000001 00000000 c705bb3a c712cce0 c712cce0 00000001
       00000001 00003080 00000286 00000000 c02e6cb8 00000000 00003080 00004df9
       00000286 00000212 c712a000 00000001 00000001 00003080 c705c3dd c712cce0
Call Trace: [<c712cce0>] [<c705bb3a>] [<c712cce0>] [<c712cce0>] [<c712a000>]
   [<c705c3dd>] [<c712cce0>] [<c712a000>] [<c712b986>] [<c712cce0>] [<c011364d>]
   [<c711e000>] [<c712a060>] [<c0106bbb>]
Code: 89 42 78 c6 41 54 10 51 e8 0c f8 ff ff a1 b8 ca 12 c7 83 c4

>>EIP; c712a847 <[fdomain]fdomain_16x0_detect+1f7/2d0>   <=====
Trace; c712cce0 <[fdomain]driver_template+0/7f>
Trace; c705bb3a <[scsi_mod]scsi_register_host+6a/2f0>
Trace; c712cce0 <[fdomain]driver_template+0/7f>
Trace; c712cce0 <[fdomain]driver_template+0/7f>
Trace; c712a000 <[snd-pcm-oss]__module_using_checksums+3692/36f2>
Trace; c705c3dd <[scsi_mod]scsi_register_module+2d/60>
Trace; c712cce0 <[fdomain]driver_template+0/7f>
Trace; c712a000 <[snd-pcm-oss]__module_using_checksums+3692/36f2>
Trace; c712b986 <[fdomain]init_this_scsi_driver+16/40>
Trace; c712cce0 <[fdomain]driver_template+0/7f>
Trace; c011364d <sys_init_module+4fd/5a0>
Trace; c711e000 <[snd-seq-midi]__module_parm_desc_input_buffer_size+11a0/1200>
Trace; c712a060 <[fdomain]print_banner+0/140>
Trace; c0106bbb <system_call+33/38>
Code;  c712a847 <[fdomain]fdomain_16x0_detect+1f7/2d0>
00000000 <_EIP>:
Code;  c712a847 <[fdomain]fdomain_16x0_detect+1f7/2d0>   <=====
   0:   89 42 78                  mov    %eax,0x78(%edx)   <=====
Code;  c712a84a <[fdomain]fdomain_16x0_detect+1fa/2d0>
   3:   c6 41 54 10               movb   $0x10,0x54(%ecx)
Code;  c712a84e <[fdomain]fdomain_16x0_detect+1fe/2d0>
   7:   51                        push   %ecx
Code;  c712a84f <[fdomain]fdomain_16x0_detect+1ff/2d0>
   8:   e8 0c f8 ff ff            call   fffff819 <_EIP+0xfffff819> c712a060 <[fdomain]print_banner+0/140>
Code;  c712a854 <[fdomain]fdomain_16x0_detect+204/2d0>
   d:   a1 b8 ca 12 c7            mov    0xc712cab8,%eax
Code;  c712a859 <[fdomain]fdomain_16x0_detect+209/2d0>
  12:   83 c4 00                  add    $0x0,%esp

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

Then, Linux works quite normally. In lsmod, the module appears as
initializing:

fdomain                12416   1  (initializing)

Now, why do I have intermixed calls to sound modules, I don't know. I
don't load kernel sound modules, since I have a ForteMedia 801 sound
card, that requires ALSA drivers. 

This happens quite regularly, even if loading the fdomain module is
the first thing I do after reboot. It happens with 2.4.4, 2.4.4-ac1
and 2.4.4-ac3. 

The machine is an oldish Athlon 500MHz, with a reasonably up-to-date
debian setup. The SCSI card has attached to it an old QIC-tape unit
and a Nikon negative scanner (but this last one can be off, and the
OOPS happens just the same)

I hope this helps. If I can be of help in providing more info or
testing eventual patches, I will be happy to do so.

Ciao
Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)

----- End forwarded message -----

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
