Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbRFQNOQ>; Sun, 17 Jun 2001 09:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264734AbRFQNOG>; Sun, 17 Jun 2001 09:14:06 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:25728 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264733AbRFQNN4>;
	Sun, 17 Jun 2001 09:13:56 -0400
Date: Sun, 17 Jun 2001 15:13:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Cordes <peter@llama.nslug.ns.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopses with heavy disk activity with 2.4 on VIA Apollo (VT82C586B)
Message-ID: <20010617151324.A526@suse.cz>
In-Reply-To: <20010616190202.D25955@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010616190202.D25955@llama.nslug.ns.ca>; from peter@llama.nslug.ns.ca on Sat, Jun 16, 2001 at 07:02:03PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Note that you have the VIA IDE driver disabled in your setup.

Vojtech

On Sat, Jun 16, 2001 at 07:02:03PM -0300, Peter Cordes wrote:
>  This is a bug report about the VIA IDE driver.  I'm forwarding it here
> because bugs@linux-ide.org bounced.
> 
> ----- Forwarded message from Mail Delivery System <Mailer-Daemon@llama.nslug.ns.ca> -----
>   bugs@linux-ide.org
>     SMTP error from remote mailer after RCPT TO:<bugs@linux-ide.org>:
>     host mail.linux-ide.org [24.219.123.215]: 550 5.7.1 Unable to relay for bugs@linux-ide.org
> 
> ------ This is a copy of the message, including all the headers. ------
> 
> Return-path: <peter@llama.nslug.ns.ca>
> Received: from peter by llama.nslug.ns.ca with local (Exim 3.22 #1 (Debian))
> 	id 15Ajcp-0005Jz-00
> 	for <bugs@linux-ide.org>; Thu, 14 Jun 2001 23:46:19 -0300
> Date: Thu, 14 Jun 2001 23:46:19 -0300
> To: bugs@linux-ide.org
> Subject: oopses with heavy disk activity with 2.4 on VIA Apollo (VT82C586B)
> Message-ID: <20010614234619.D20351@llama.nslug.ns.ca>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> User-Agent: Mutt/1.3.15i
> From: Peter Cordes <peter@llama.nslug.ns.ca>
> 
> 
>  I rescued a P5BV3+ (a super 7) mobo with a VIA MVP3 chipset from the trash
> (I know the guy who was tossing it, and he didn't say anything about it
> being damaged, just old).  I moved my disks over from my old system, and
> compiled myself a kernel for it.  It's got an AMD k6-2 at 350MHz, and the
> memory bus is running at 100MHz.  I've run memtest86 for a long time
> (several complete passes, one with "extended tests") and found no errors.
> 
>  The problem is that all the 2.4 kernels I've tried oops under heavy disk
> load.  A couple typical ones are like this:
> 
> ksymoops 2.4.1 on i586 2.2.19-idepci.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.5 (specified)
>      -m /boot/System.map-2.4.5 (specified)
> 
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Jun 12 02:11:40 yeti kernel: Unable to handle kernel paging request at virtual address 0000848d
> Jun 12 02:11:40 yeti kernel: c010fb03
> Jun 12 02:11:40 yeti kernel: *pde = 00000000
> Jun 12 02:11:40 yeti kernel: Oops: 0000
> Jun 12 02:11:40 yeti kernel: CPU:    0
> Jun 12 02:11:40 yeti kernel: EIP:    0010:[__wake_up+51/168]
> Jun 12 02:11:40 yeti kernel: EFLAGS: 00010017
> Jun 12 02:11:40 yeti kernel: eax: c123fe10   ebx: 00008491   ecx: c8b6a6e4   edx: c123fdf8
> Jun 12 02:11:40 yeti kernel: esi: c8b6a6e4   edi: 00008489   ebp: c8b87ef4   esp: c8b87ed8
> Jun 12 02:11:40 yeti kernel: ds: 0018   es: 0018   ss: 0018
> Jun 12 02:11:40 yeti kernel: Process bonnie++ (pid: 329, stackpage=c8b87000)
> Jun 12 02:11:40 yeti kernel: Stack: c123fdf4 c8b6a6e4 c123fdcc c123fdf8 00000001 00000282 00000003 000020e9 
> Jun 12 02:11:40 yeti kernel:        c0125481 c01e2134 c01e2304 00000002 00000000 c0126b34 c01e2134 00000000 
> Jun 12 02:11:40 yeti kernel:        c01e230c 00000000 c13bee48 c0126c11 c01e2300 00000000 00000002 00000001 
> Jun 12 02:11:40 yeti kernel: Call Trace: [reclaim_page+969/1016] [__alloc_pages_limit+108/148] [__alloc_pages+181/584] [generic_file_write+843/1336] [sys_write+142/196] [system_call+51/64] 
> Jun 12 02:11:40 yeti kernel: Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 4f 04                  mov    0x4(%edi),%ecx
> Code;  00000003 Before first symbol
>    3:   8b 1b                     mov    (%ebx),%ebx
> Code;  00000005 Before first symbol
>    5:   8b 01                     mov    (%ecx),%eax
> Code;  00000007 Before first symbol
>    7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
> Code;  0000000a Before first symbol
>    a:   74 51                     je     5d <_EIP+0x5d> 0000005d Before first symbol
> Code;  0000000c Before first symbol
>    c:   31 c0                     xor    %eax,%eax
> Code;  0000000e Before first symbol
>    e:   9c                        pushf  
> Code;  0000000f Before first symbol
>    f:   5e                        pop    %esi
> Code;  00000010 Before first symbol
>   10:   fa                        cli    
> Code;  00000011 Before first symbol
>   11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
> 
> 
> 
> 
> Jun 12 04:06:20 yeti kernel: Unable to handle kernel paging request at virtual address 000045bd
> Jun 12 04:06:20 yeti kernel: c010fb03
> Jun 12 04:06:20 yeti kernel: *pde = 075d6067
> Jun 12 04:06:20 yeti kernel: Oops: 0000
> Jun 12 04:06:20 yeti kernel: CPU:    0
> Jun 12 04:06:20 yeti kernel: EIP:    0010:[__wake_up+51/168]
> Jun 12 04:06:20 yeti kernel: EFLAGS: 00010017
> Jun 12 04:06:20 yeti kernel: eax: c123fe10   ebx: 000045c1   ecx: c8b6a6e4   edx: c111edf8
> Jun 12 04:06:20 yeti kernel: esi: c111edf4   edi: 000045b9   ebp: c13c3f94   esp: c13c3f78
> Jun 12 04:06:20 yeti kernel: ds: 0018   es: 0018   ss: 0018
> Jun 12 04:06:20 yeti kernel: Process kswapd (pid: 3, stackpage=c13c3000)
> Jun 12 04:06:20 yeti kernel: Stack: c111edcc c111edf4 00000000 c111edf8 00000001 00000282 00000003 000041c8 
> Jun 12 04:06:20 yeti kernel:        c01259dc 00000004 00000000 00000000 0008e000 00000000 00000004 00000000 
> Jun 12 04:06:20 yeti kernel:        00002159 00000000 c0125ffd 00000004 00000000 c13c2000 c01bc391 c13c2239 
> Jun 12 04:06:20 yeti kernel: Call Trace: [page_launder+1324/2096] [do_try_to_free_pages+29/88] [kswapd+83/224] [kernel_thread+40/56] 
> Jun 12 04:06:20 yeti kernel: Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 4f 04                  mov    0x4(%edi),%ecx
> Code;  00000003 Before first symbol
>    3:   8b 1b                     mov    (%ebx),%ebx
> Code;  00000005 Before first symbol
>    5:   8b 01                     mov    (%ecx),%eax
> Code;  00000007 Before first symbol
>    7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
> Code;  0000000a Before first symbol
>    a:   74 51                     je     5d <_EIP+0x5d> 0000005d Before first symbol
> Code;  0000000c Before first symbol
>    c:   31 c0                     xor    %eax,%eax
> Code;  0000000e Before first symbol
>    e:   9c                        pushf  
> Code;  0000000f Before first symbol
>    f:   5e                        pop    %esi
> Code;  00000010 Before first symbol
>   10:   fa                        cli    
> Code;  00000011 Before first symbol
>   11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
> 
> 
>  This happens pretty consistently when I run 2.4.5.  I haven't tried earlier
> 2.4 kernels, since I thought it would be unlikely to help.
> 
>  Luckily for me, 2.2 kernels seem to have no trouble, even when doing ultra
> DMA.  I ran bonnie++ after running hdparm -m16 -u1 -d1 -c1 /dev/hdc, and it
> completed without causing any problems.  Under 2.4.5, this always gave an
> oops pretty quickly, and the bonnie++ process would be in an un-killable
> disk-sleep.  I had to reboot the machine to get rid of it.
> 
> The precompiled Debian 2.2.19-idepci kernel says this on bootup:
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: FUJITSU MPG3307AT, ATA DISK drive
> hdc: QUANTUM FIREBALL CR13.0A, ATA DISK drive
> hdd: SAMSUNG CD-R/RW DRIVE SW-212B, ATAPI CDROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: FUJITSU MPG3307AT, 29319MB w/2048kB Cache, CHS=59570/16/63
> hdc: QUANTUM FIREBALL CR13.0A, 12416MB w/418kB Cache, CHS=25228/16/63
> hdd: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache
> 
>  My 2.4.5 kernel was compiled with gcc version 2.95.4 20010319 (Debian
> prerelease).  (I'm running Debian woody.)
> 
>  This is really annoying, because I want to use 2.4 on this machine for DRI
> with the 3DFX Voodoo3 I just got for it, netfilter, and raid2...  Oh well, I
> guess I'll survive with 2.2.19 until this gets figured out.  I'm willing to
> do some testing on this, since I've got other computers that I can send
> email from if this one eats its disk.
> 
> -- 
> #define X(x,y) x##y
> Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)
> 
> "The gods confound the man who first found out how to distinguish the hours!
>  Confound him, too, who in this place set up a sundial, to cut and hack
>  my day so wretchedly into small pieces!" -- Plautus, 200 BCE
> 
> ----- End forwarded message -----
> 
> -- 
> #define X(x,y) x##y
> Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)
> 
> "The gods confound the man who first found out how to distinguish the hours!
>  Confound him, too, who in this place set up a sundial, to cut and hack
>  my day so wretchedly into small pieces!" -- Plautus, 200 BCE
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
