Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTDVKYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbTDVKYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:24:47 -0400
Received: from mail.ithnet.com ([217.64.64.8]:44554 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263057AbTDVKYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:24:41 -0400
Date: Tue, 22 Apr 2003 12:36:41 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: gkajmowi@tbaytel.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Kernel panic in IDE-SCSI with CDROM drive
Message-Id: <20030422123641.7c2fa19d.skraw@ithnet.com>
In-Reply-To: <200304212137.54302.gkajmowi@tbaytel.net>
References: <200304212137.54302.gkajmowi@tbaytel.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This BUG is fixed. Please have a look at the 2.4.21-rc1 ide-scsi patch I posted
to LKML lately.


On Mon, 21 Apr 2003 21:37:54 -0400
Garrett Kajmowicz <gkajmowi@tbaytel.net> wrote:

> I recieved the appened kernel oops while attempting to mount a cdrom, as well
> 
> as to dd the CDROM into a file.  This as occured under 2.4.19 as well as 
> 2.4.20 (reason why I tried upgrading).  The drive is bootable and works fine 
> under Win98.
> 
> The oops in question locks the system up completely and causes Caps+Scroll 
> lock lights to blink.
> 
> The drive in question is an HP CD-RW drive, attached via IDE using IDE-SCSI.
> I have also attached information on my drive, should it be useful.
> 
> Thank you for all of yuor hard work.  Let me know if you need more info.
> Garrett Kajmowicz
> gkajmowi@tbayel.net
> 
> 
> 
> Output from ksymoops (kernel was NOT tainted):
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000018
> Oops: 0
> CPU: 0
> EIP: 0010:[<c01e702b>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: e7de5b40  ebx: c02df488  ecx: db5ef8c0  edx: db5ef8c0
> esi: 00000000  edi: c02df488  ebp: 00000000  esp: c029fe90
> ds: 00000018  es: 00000018  ss: 00000018
> c01cda7c 000005dc e758ff7c 00000046 e7de5b40 00000000 00000000 c02df488
> c02df444 c01cde6a c02df488 00000000 00000000 00000088 00000003 00000000
> c026f414 c029ff00 00000000 aca424e9 c02df488 e7f46280 c02df444 db5ef8c0
> Call trace: [<c01cda7c>] [<c01cde6a>] [<c01ce065>] [<c01ce345>] [<c01ce260>]
> [<c011c3fe>] [<c0118842>] [<c0118756>] [<c0118594>] [<c0108a3e>] [<c01053a0>]
> [<c010af98>] [<c01053a0>] [<c01053c3>] [<c0105432>] [<c0105000>]
> Code: 8b 56 18 89 70 04 8b 46 1c 8b 7e 0c c7 46 10 00 00 00 00 89
> 
> 
> >>EIP; c01e702b <idescsi_issue_pc+1b/1b0>   <=====
> 
> >>eax; e7de5b40 <_end+27b01428/28566968>
> >>ebx; c02df488 <ide_hwifs+388/20a8>
> >>ecx; db5ef8c0 <_end+1b30b1a8/28566968>
> >>edx; db5ef8c0 <_end+1b30b1a8/28566968>
> >>edi; c02df488 <ide_hwifs+388/20a8>
> >>esp; c029fe90 <init_task_union+1e90/2000>
> 
> Trace; c01cda7c <ide_wait_stat+bc/130>
> Trace; c01cde6a <start_request+1ba/260>
> Trace; c01ce065 <ide_do_request+c5/1c0>
> Trace; c01ce345 <ide_timer_expiry+e5/1c0>
> Trace; c01ce260 <ide_timer_expiry+0/1c0>
> Trace; c011c3fe <run_timer_list+ee/160>
> Trace; c0118842 <bh_action+22/40>
> Trace; c0118756 <tasklet_hi_action+46/70>
> Trace; c0118594 <do_softirq+94/a0>
> Trace; c0108a3e <do_IRQ+9e/a0>
> Trace; c01053a0 <default_idle+0/30>
> Trace; c010af98 <call_do_IRQ+5/d>
> Trace; c01053a0 <default_idle+0/30>
> Trace; c01053c3 <default_idle+23/30>
> Trace; c0105432 <cpu_idle+42/60>
> Trace; c0105000 <_stext+0/0>
> 
> Code;  c01e702b <idescsi_issue_pc+1b/1b0>
> 00000000 <_EIP>:
> Code;  c01e702b <idescsi_issue_pc+1b/1b0>   <=====
>    0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
> Code;  c01e702e <idescsi_issue_pc+1e/1b0>
>    3:   89 70 04                  mov    %esi,0x4(%eax)
> Code;  c01e7031 <idescsi_issue_pc+21/1b0>
>    6:   8b 46 1c                  mov    0x1c(%esi),%eax
> Code;  c01e7034 <idescsi_issue_pc+24/1b0>
>    9:   8b 7e 0c                  mov    0xc(%esi),%edi
> Code;  c01e7037 <idescsi_issue_pc+27/1b0>
>    c:   c7 46 10 00 00 00 00      movl   $0x0,0x10(%esi)
> Code;  c01e703e <idescsi_issue_pc+2e/1b0>
>   13:   89 00                     mov    %eax,(%eax)
> 
> <0>Kernel panic: Aiee, killing interupt handler!
> 
> --------------------Enf od ksymoops output----------------------------
> Panic message ended with:  In interupt handler - not syncing.
> 
> cat /proc/ide/drivers
> ide-scsi version 0.9
> ide-disk version 1.12
> 
> cat /proc/ide/ide1/config
> pci bus 00 device 39 vid 1106 did 0571 channel 1
> 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 01 d4 00 00 00 00 00 00 00 00 00 00 06 11 71 05
> 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
> 0b 52 09 3a 10 10 c0 00 a8 20 a8 20 11 00 20 20
> 07 07 07 e0 14 00 00 00 a8 a8 a8 a8 00 00 00 00
> 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
> 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
> 00 60 df 27 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> 06 00 71 05 06 11 71 05 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> cat /proc/ide/ide1/hdc/settings
> name                    value           min             max             mode
> ----                    -----           ---             ---             ----
> bios_cyl                0               0               1023            rw
> bios_head               0               0               255             rw
> bios_sect               0               0               63              rw
> current_speed           34              0               69              rw
> ide_scsi                0               0               1               rw
> init_speed              12              0               69              rw
> io_32bit                1               0               3               rw
> keepsettings            0               0               1               rw
> log                     0               0               1               rw
> nice1                   1               0               1               rw
> number                  2               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> transform               1               0               3               rw
> unmaskirq               1               0               1               rw
> using_dma               1               0               1               rw
> 
> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) XP 1800+
> stepping        : 2
> cpu MHz         : 1529.036
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 3047.42
> 
> Using version:
> GNU assembler 2.13.2
> gcc (GCC) 3.2.2
> /lib/libc-2.3.1.so
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
MfG,
Stephan von Krawczynski
ith Kommunikationstechnik GmbH
