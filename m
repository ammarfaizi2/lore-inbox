Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263050AbREWLY1>; Wed, 23 May 2001 07:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbREWLYR>; Wed, 23 May 2001 07:24:17 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:26129 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S263047AbREWLYE>;
	Wed, 23 May 2001 07:24:04 -0400
Message-Id: <200105231126.f4NBQte21076@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Gerald Weber <gerald.weber@teleworld.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops with 2.4.3-xfs 
In-Reply-To: Message from Gerald Weber <gerald.weber@teleworld.at> 
   of "Wed, 23 May 2001 10:17:39 +0200." <3B0B7223.96CB5599@teleworld.at> 
Date: Wed, 23 May 2001 06:26:55 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, we 'released' version 1 of XFS against a 2.4.2 base - and packaged
it into a RedHat 7.1 Kernel RPM, we also have a development CVS tree
currently running at 2.4.4. If you are running a production server
with what you describe below, you might want to switch to one of the
other two kernels I mentioned. The development tree just got a fix
which does make xfs much more responsive to cache pruning, and has
numerous other xfs fixes so you might want to use this.

Steve 

> hi,
> i use kernel 2.4.3 with xfs (release 1) on a dell poweredge 2450.
> 
> it happens about every week that the system completely hangs (network
> down,console does not accept
> any input,sysreq useless...).
> i think this has anything to do with xfs or other fs issues,because kupdated
> always uses about 98% of cpu
> time.i couldn't report any errors because no oops or something else was
> generated until yesterday night:
> 
> ksymoops 2.4.0 on i686 2.4.3-XFS.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.3-XFS/ (default)
>      -m /boot/System.map-2.4.3-XFS (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod fil
> e?
> May 23 00:43:08 twasrv1 kernel: invalid operand: 0000
> May 23 00:43:08 twasrv1 kernel: CPU:    1
> May 23 00:43:08 twasrv1 kernel: EIP:    0010:[do_timer+67/152]
> May 23 00:43:08 twasrv1 kernel: EFLAGS: 00010002
> May 23 00:43:08 twasrv1 kernel: eax: 00000020   ebx: d121dfc4   ecx: 00000086
>   
> edx: 00000000
> May 23 00:43:08 twasrv1 kernel: esi: 20000001   edi: 00000020   ebp: 00000000
>   
> esp: d121df68
> May 23 00:43:08 twasrv1 kernel: ds: 0018   es: 0018   ss: 0018
> May 23 00:43:08 twasrv1 kernel: Process exp816 (pid: 15671, stackpage=d121d00
> 0)
> May 23 00:43:08 twasrv1 kernel: Stack: c010b7ec d121dfc4 c033c234 c01086c1
> 00000000 00000000 d121dfc4 c03cc880 
> May 23 00:43:08 twasrv1 kernel:        c03ad800 00000000 d121dfbc c01088a6
> 00000000 d121dfc4 c033c234 40572404 
> May 23 00:43:08 twasrv1 kernel:        080c928c 080cf3e1 00000001 00000020
> c033c234 bfffc5f4 c0107014 40572404 
> May 23 00:43:08 twasrv1 kernel: Call Trace: [timer_interrupt+168/304]
> [handle_IRQ_event+77/120] [do_IRQ+166/244] [ret_from_intr+0/32]
> [startup_32+43/203] 
> May 23 00:43:08 twasrv1 kernel: Code: c7 9d 81 3d 4c db 33 c0 4c db 33 c0 0f 
> 94
> c0 0f b6 c0 85 c0 
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   c7 9d 81 3d 4c db 33      movl   $0xdb4cc033,0xdb4c3d81(%ebp)
> Code;  00000007 Before first symbol
>    7:   c0 4c db 
> Code;  0000000a Before first symbol
>    a:   33 c0                     xor    %eax,%eax
> Code;  0000000c Before first symbol
>    c:   0f 94 c0                  sete   %al
> Code;  0000000f Before first symbol
>    f:   0f b6 c0                  movzbl %al,%eax
> Code;  00000012 Before first symbol
>   12:   85 c0                     test   %eax,%eax
> 
> 
> 2 warnings issued.  Results may not be reliable.
> 
> 
> i'm using a suse7.1 system,the kernel was compiled with gcc-2.95.3.
> 
> i'm not sure if this oops has anything to do with xfs or fs in general,but th
> is
> is the first oops i ever found
> in the logfiles.
> 
> if anyone needs more information,please let me know.
> the system is a production system and i need to get this thing stable.
> 
> please cc me because i'm not subscribed to the list.
> 
> regards,
> gerald weber
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


