Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVDNFC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDNFC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 01:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVDNFC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 01:02:57 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47880 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261428AbVDNFCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 01:02:50 -0400
Date: Thu, 14 Apr 2005 07:02:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Kiniger <karl.kiniger@med.ge.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30 Oops when connecting external USB hard drive
Message-ID: <20050414050243.GF7858@alpha.home.local>
References: <20050412173911.GA21311@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412173911.GA21311@wszip-kinigka.euro.med.ge.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may try to unload the ehci-hcd driver and load only uhci and check if
it still happens. I guess from the trace that the problem lies in the ehci
driver itself.

Regards,
willy

On Tue, Apr 12, 2005 at 07:39:11PM +0200, Kiniger wrote:
> Pls see the hand-copied decoded backtrace.
> 
> It happens when I connect a Seagate 160 GB external USB
> hard disk. (I dont have access to this particular drive
> just now  but under Windows I have seen it  as an ST3316002 3A
> USB Device) - Oops happens reliably just after I plug the
> drive in.
> 
> When connecting a Maxtor USB disk there is no Oops however.
> 
> Kernel is 2.4.30-pre4 (same as 2.4.30) with the
> TNG NTFS patches from Anton Altaparmakov but it is not
> in use when it happens. There are no hotplug, automount etc.
> scripts on this system.
> 
> suggestions from the USB experts are welcome.
> 
> Greetings,
> Karl
> 
> ksymoops 2.4.11 on i686 2.6.10-1.770_FC3.  Options used
>      -v vmlinux (specified)
>      -k ksyms.out (specified)
>      -l modules.out (specified)
>      -o /lib/modules/2.4.30-rc4 (specified)
>      -m System.map (specified)
> 
> Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
> Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
> Error (pclose_local): find_objects pclose failed 0x100
> Warning (compare_ksyms_lsmod): module Module is in lsmod but not in ksyms, probably no symbols exported
> Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
> Oops: 0000
> CPU:    0
> EIP:    0010:[<f0089d42>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010207
> eax: 00000000   ebx: eed8c200  ecx: ee9f9100  edx: 00000000
> esi: 00010011   edi: ee9ae2e0  ebp: ee9f9100  esp: c029fe98
> ds: 0018   es: 0018  ss: 0018
> Process swapper (pid: 0, stackpage=c029f000)
> Stack: ee9f7180 eed8c200 f00890e3 eed8c200 ee9f9100 2e9f7180 00018148 ee9f914c
>        01d8c200 00000000 00000001 00000001 ee9f914c ee9f7120 00000000 00000000
>        dd9f9100 000017f8 f008b3fb eed8c200 ee9f9100 c029ff8c 00000000 ee9f6bfc
> Call Trace:    [<f00890e3>] [<f008b3fb>] [<f008bcdc>] [<f0049d4a>] [<c010a5d5>]
>   [<c010a754>] [<c010cc78>] [<c0110018>] [<c0106fb3>] [<c0114c9c>] [<c0114b60>]
>   [<c0107042>] [<c0105000>]
> Code: 8b 40 48 39 c8 75 f7 8b 01 89 02 8b 41 48 89 42 48 8b 83 00
> 
> 
> >>EIP; f0089d42 <[ehci-hcd]start_unlink_async+32/e0>   <=====
> 
> >>ebx; eed8c200 <_end+2ea8f728/2fd10588>
> >>ecx; ee9f9100 <_end+2e6fc628/2fd10588>
> >>edi; ee9ae2e0 <_end+2e6b1808/2fd10588>
> >>ebp; ee9f9100 <_end+2e6fc628/2fd10588>
> >>esp; c029fe98 <init_task_union+1e98/2000>
> 
> Trace; f00890e3 <[ehci-hcd]qh_completions+1f3/2d0>
> Trace; f008b3fb <[ehci-hcd]scan_periodic+1cb/230>
> Trace; f008bcdc <[ehci-hcd]ehci_work+4c/d0>
> Trace; f0049d4a <[usbcore]hcd_irq+2a/60>
> Trace; c010a5d5 <handle_IRQ_event+45/70>
> Trace; c010a754 <do_IRQ+64/a0>
> Trace; c010cc78 <call_do_IRQ+5/d>
> Trace; c0110018 <pci_conf2_write_config_byte+8/60>
> Trace; c0106fb3 <default_idle+23/40>
> Trace; c0114c9c <apm_cpu_idle+13c/160>
> Trace; c0114b60 <apm_cpu_idle+0/160>
> Trace; c0107042 <cpu_idle+52/70>
> Trace; c0105000 <_stext+0/0>
> 
> Code;  f0089d42 <[ehci-hcd]start_unlink_async+32/e0>
> 00000000 <_EIP>:
> Code;  f0089d42 <[ehci-hcd]start_unlink_async+32/e0>   <=====
>    0:   8b 40 48                  mov    0x48(%eax),%eax   <=====
> Code;  f0089d45 <[ehci-hcd]start_unlink_async+35/e0>
>    3:   39 c8                     cmp    %ecx,%eax
> Code;  f0089d47 <[ehci-hcd]start_unlink_async+37/e0>
>    5:   75 f7                     jne    fffffffe <_EIP+0xfffffffe>
> Code;  f0089d49 <[ehci-hcd]start_unlink_async+39/e0>
>    7:   8b 01                     mov    (%ecx),%eax
> Code;  f0089d4b <[ehci-hcd]start_unlink_async+3b/e0>
>    9:   89 02                     mov    %eax,(%edx)
> Code;  f0089d4d <[ehci-hcd]start_unlink_async+3d/e0>
>    b:   8b 41 48                  mov    0x48(%ecx),%eax
> Code;  f0089d50 <[ehci-hcd]start_unlink_async+40/e0>
>    e:   89 42 48                  mov    %eax,0x48(%edx)
> Code;  f0089d53 <[ehci-hcd]start_unlink_async+43/e0>
>   11:   8b 83 00 00 00 00         mov    0x0(%ebx),%eax
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 2 warnings and 3 errors issued.  Results may not be reliable.
> 
> lspci output:
> 00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 03)
> 00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
> 00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller  (rev 01)
> 00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller  (rev 01)
> 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface Bridge (rev 01)
> 00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 01)
> 00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 01:08.0 Ethernet controller: Intel Corporation 82801DB PRO/100 VE (CNR) Ethernet Controller (rev 81)
> 01:0c.0 Bridge: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 0a)
> 01:0f.0 VGA compatible controller: Chips and Technologies F65550 (rev c6)
> 
> 
> -- 
> Karl Kiniger   mailto:karl.kiniger@med.ge.com
> GE Medical Systems Kretztechnik GmbH & Co OHG
> Tiefenbach 15       Tel: (++43) 7682-3800-710
> A-4871 Zipf Austria Fax: (++43) 7682-3800-47
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
