Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbRGISgX>; Mon, 9 Jul 2001 14:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbRGISgN>; Mon, 9 Jul 2001 14:36:13 -0400
Received: from [64.64.109.142] ([64.64.109.142]:14353 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264632AbRGISgF>; Mon, 9 Jul 2001 14:36:05 -0400
Message-ID: <3B49F98F.39A39BCA@didntduck.org>
Date: Mon, 09 Jul 2001 14:35:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Lawrence Gold <gold@shell.aros.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oopses under 2.4.5/2.4.6 w/ Athlon Thunderbird
In-Reply-To: <20010709113412.A21360@shell.aros.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Gold wrote:
> 
> Apologies if this is a repeat; my previous attempt to send this bounced.
> 
> I'm running 2.4.6 with the latest ext3 patch on an Expo 8kta3 motherboard
> with an Athlon Thunderbird 1200MHz CPU.  My kernel is compiled with the
> CPU type set to "Athlon" but the 3DNOW line in arch/i386/config.in is
> commented out.  The compiler used was egcs-1.1.2.
> 
> For the past several weeks, I have been experiencing occasional oopses,
> but only when running mplayer (http://192.190.173.45/homepage/news.html),
> and even with vanilla 2.4.5 and 2.4.6 kernels.  I've run the player with
> 3dnow code disabled, but I still got oopses.
> 
> Below is the latest oops run through ksymoops.  I've tried several things
> to try to alleviate the problem to no avail:
> 
> - Increased the core voltage of the CPU.
> - Loaded the fail-safe defaults in the BIOS.
> - Ran memtest86 with no problems found.
> - Checked the CPU and case temperature from the BIOS and they were well
>   within limits.  (But I understand that this is an inaccurate way to
>   gauge the temperature.)
> 
> Thanks for any advice you can offer.
> 
> P.S. This is the first time I remember seeing the oops occur in process
> sh; usually it showed the errant process as gnome-terminal.
> 
> ksymoops 2.4.1 on i686 2.4.6.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.6/ (default)
>      -m /boot/System.map (specified)
> 
> Warning (compare_maps): ksyms_base symbol
> __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
> ksyms_base entry
> Unable to handle kernel paging request at virtual address 38343031
> c0143490
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[sys_getcwd+32/416]
> EFLAGS: 00010203
> eax: cff9ba30   ebx: 38343021   ecx: 0000000f   edx: cff80000
> esi: 0028c69d   edi: c2d85f68   ebp: 38343031   esp: c2d85f08
> ds: 0018   es: 0018   ss: 0018
> Process sh (pid: 14775, stackpage=c2d85000)
> Stack: 0028c69d 00000000 c2d85f68 c2d85fa4 cff9ba30 caebf009 0028c69d
> 00000003
> c013b230 cf5abb40 c2d85f68 0028c69d c013b962 cf5abb40 c2d85f68 00000000
> caebf000 00000000 c2d85fa4 bfffdca0 c2d84000 c2d84000 00000009 00000000
> Call Trace: [path_walk+400/1840] [path_init+50/304] [open_namei+732/1296]
> [copy_strings+214/464] [sys_lseek+83/160] [system_call+51/56]
> Code: 8b 6d 00 8b 74 24 18 39 73 44 75 7c 8b 74 24 24 39 73 0c 75
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 6d 00                  mov    0x0(%ebp),%ebp

About the best answer I can give you here is that the kernel followed a
bad file->f_op->llseek pointer.  The value in %ebp that it faulted on is
totally bogus, and the call trace does not make sense beyond sys_lseek.

--

				Brian Gerst
