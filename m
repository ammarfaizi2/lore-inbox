Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315155AbSEUQG0>; Tue, 21 May 2002 12:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSEUQGZ>; Tue, 21 May 2002 12:06:25 -0400
Received: from uvo1-18.univie.ac.at ([131.130.231.18]:2432 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S315155AbSEUQGW>;
	Tue, 21 May 2002 12:06:22 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Linux 2.5.17: compile error: sound/driver/opl3/opl3_oss.c
Date: Tue, 21 May 2002 18:04:14 +0200
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205211205.09824@pflug3.gphy.univie.ac.at> <s5h661hhata.wl@alsa2.suse.de>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200205211804.15568@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Takashi Iwai -- Tuesday 21 May 2002 15:47:
> At Tue, 21 May 2002 12:05:08 +0200,
> Melchior FRANZ wrote:
[opl3 compiling failure]
> this was fixed on alsa cvs.
> please try the attached patch (applied under $KENREL/sound).

Well, it compiles now. But it doesn't work. (It did under 2.5.13.)

First it complained about sound-service-0-3 (snd-pcm-oss) not being found.

OK, so I compiled all three "OSS API EMULATION" options in, although that
wasn't needed in 2.5.13, and rebooted: This gave an oops. (See below.
I can't explain the warnings, but I don't feel guilty.  ;-)

OK, so I deselected the options again and simply turned sound-service-0-3
off in /etc/modules.conf. Recompiled. Rebooted. No complaints this time.
And no sound either. No entries in /var/log/messages.

OK. Gave up. Rebooted into 2.4.18 again. (Alsa 0.9.0beta8(a))

m.   :-(







ksymoops 2.4.0 on i686 2.5.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.17/ (default)
     -m /boot/System.map-2.5.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol snd_pcm_devices  , snd-pcm says d8906420, /lib/modules/2.5.17/kernel/sound/core/snd-pcm.o says d8906140.  Ignoring /lib/modules/2.5.17/kernel/sound/core/snd-pcm.o entry
Warning (compare_maps): mismatch on symbol snd_ecards_limit  , snd says d88e8fe0, /lib/modules/2.5.17/kernel/sound/core/snd.o says d88e8d00.  Ignoring /lib/modules/2.5.17/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_mixer_oss_notify_callback  , snd says d88e9040, /lib/modules/2.5.17/kernel/sound/core/snd.o says d88e8d60.  Ignoring /lib/modules/2.5.17/kernel/sound/core/snd.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
d890380e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d890380e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: c02f0000   ecx: 00000004   edx: c1006c08
esi: d8906360   edi: 00000001   ebp: 00010000   esp: d4127e68
ds: 0018   es: 0018   ss: 0018
Stack: d89053ed 00000003 d8906360 00000024 002f0000 00010000 d89038fa d8906360 
       00010000 00010000 d890392c d8906360 00010000 00010000 d456b818 d890c1bc 
       d456ba6f d4127ee8 d890aa05 d456ba18 00010000 00010000 d4127f14 d8918780 
Call Trace: [<d89053ed>] [<d8906360>] [<d89038fa>] [<d8906360>] [<d890392c>] 
   [<d8906360>] [<d890c1bc>] [<d890aa05>] [<d8918780>] [<d89187c0>] [<d8914754>] 
   [<d8918212>] [<d89186c0>] [<d89183ec>] [sys_init_module+1297/1512] [<d8918060>] [syscall_call+7/11] 
Code: 8b 00 50 e8 96 04 fe ff 89 c3 83 c4 0c 85 db 74 37 c7 43 10 

>>EIP; d890380e <[snd-pcm]snd_pcm_lib_preallocate_pages1+e6/13c>   <=====
Trace; d89053ed <[snd-pcm].rodata.start+16ad/170e>
Trace; d8906360 <[snd-pcm]snd_pcm_reg+0/40>
Trace; d89038fa <[snd-pcm]snd_pcm_lib_preallocate_isa_pages+22/28>
Trace; d8906360 <[snd-pcm]snd_pcm_reg+0/40>
Trace; d890392c <[snd-pcm]snd_pcm_lib_preallocate_isa_pages_for_all+2c/4c>
Trace; d8906360 <[snd-pcm]snd_pcm_reg+0/40>
Trace; d890c1bc <[snd-cs4231-lib].rodata.start+edc/112f>
Trace; d890aa05 <[snd-cs4231-lib]snd_cs4231_pcm+13d/158>
Trace; d8918780 <[snd-cs4236]snd_irq+0/20>
Trace; d89187c0 <[snd-cs4236]snd_dma1+0/20>
Trace; d8914754 <[snd-cs4236-lib]snd_cs4236_pcm+1c/3c>
Trace; d8918212 <[snd-cs4236]__module_parm_snd_cport+24/32>
Trace; d89186c0 <[snd-cs4236]snd_enable+0/20>
Trace; d89183ec <[snd-cs4236]alsa_card_cs423x_init+18/2c>
Code;  d890380e <[snd-pcm]snd_pcm_lib_preallocate_pages1+e6/13c>
00000000 <_EIP>:
Code;  d890380e <[snd-pcm]snd_pcm_lib_preallocate_pages1+e6/13c>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  d8903810 <[snd-pcm]snd_pcm_lib_preallocate_pages1+e8/13c>
   2:   50                        push   %eax
Code;  d8903811 <[snd-pcm]snd_pcm_lib_preallocate_pages1+e9/13c>
   3:   e8 96 04 fe ff            call   fffe049e <_EIP+0xfffe049e> d88e3cac <[snd]snd_info_create_card_entry+0/30>
Code;  d8903816 <[snd-pcm]snd_pcm_lib_preallocate_pages1+ee/13c>
   8:   89 c3                     mov    %eax,%ebx
Code;  d8903818 <[snd-pcm]snd_pcm_lib_preallocate_pages1+f0/13c>
   a:   83 c4 0c                  add    $0xc,%esp
Code;  d890381b <[snd-pcm]snd_pcm_lib_preallocate_pages1+f3/13c>
   d:   85 db                     test   %ebx,%ebx
Code;  d890381d <[snd-pcm]snd_pcm_lib_preallocate_pages1+f5/13c>
   f:   74 37                     je     48 <_EIP+0x48> d8903856 <[snd-pcm]snd_pcm_lib_preallocate_pages1+12e/13c>
Code;  d890381f <[snd-pcm]snd_pcm_lib_preallocate_pages1+f7/13c>
  11:   c7 43 10 00 00 00 00      movl   $0x0,0x10(%ebx)


5 warnings issued.  Results may not be reliable.

