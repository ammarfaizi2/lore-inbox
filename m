Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281566AbRKUKEg>; Wed, 21 Nov 2001 05:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKUKE0>; Wed, 21 Nov 2001 05:04:26 -0500
Received: from [61.171.113.165] ([61.171.113.165]:57862 "EHLO
	marvin.zhlinux.com") by vger.kernel.org with ESMTP
	id <S281563AbRKUKET>; Wed, 21 Nov 2001 05:04:19 -0500
Date: Wed, 21 Nov 2001 18:04:53 +0800
From: Wenzhuo Zhang <wenzhuo@zhmail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: [OOPS] 2.4.13-ac5 default_idle [more info]
Message-ID: <20011121180453.A4734@zhmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20011120234928.B714@zhmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120234928.B714@zhmail.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More info:
It's a slackware-8.0 box.
# gcc --version
2.95.3
# ld -v
GNU ld version 2.11.90.0.19 (with BFD 2.11.90.0.19)

The motherboard is a Asus P/I-P55TP4N. And the CPU is Petium(classic)
100MHz.
# cat cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 6
cpu MHz         : 99.475
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 198.24


I don't know whether it's a kernel issue or a hardware issue. Pls shed
light over it. Thanks

(The box crashed again when I was writing this message.)

On Tue, Nov 20, 2001 at 11:49:28PM +0800, Wenzhuo Zhang wrote:
> 
> Hello,
> 
> I noticed frequent crashings of my old Pentium desktop, after I kept it
> running 24x7 as a gateway/filewall. Tonight, I caught sight of a oops
> and hand-copied it down.
> 
> ksymoops 2.3.4 on i686 2.4.13-ac5.  Options used
> 		  ^^ Since I cannot compile ksymoops in the slackware-8.0
>   box, I copied the kernel/modules to another box, and ran ksymoops there.
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.13-ac5/ (default)
>      -m /boot/System.map-2.4.13-ac5 (specified)
> 
> CPU: 0
> EIP: 0010:[<c0105173>] Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00000246
> eax: 00000000 ebx: c0210000 ecx: c11e2260 edx: c11e2260
> esi: c0105150 edi: ffffe000 ebp: 0008e000 esp: c0211fdc
> ds: 0018 es: 0018 ss:0018
> Process swapper (pid: 0, stackpage=c0211000)
> Stack: c01051d7 00003000 000a0600 c0105000 c0105027 c02127f3 00000000 c0246060
>        c0100197
> Call Trace: [<c01051d7>] [<c0105000>] [<c0105027>]
> Code: c3 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff ff 87 42
> 
> >>EIP; c0105173 <default_idle+23/28>   <=====
> Trace; c01051d7 <cpu_idle+3f/54>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105027 <rest_init+27/28>
> Code;  c0105173 <default_idle+23/28>
> 00000000 <_EIP>:
> Code;  c0105173 <default_idle+23/28>   <=====
>    0:   c3                        ret       <=====
> Code;  c0105174 <default_idle+24/28>
>    1:   fb                        sti    
> Code;  c0105175 <default_idle+25/28>
>    2:   c3                        ret    
> Code;  c0105176 <default_idle+26/28>
>    3:   89 f6                     mov    %esi,%esi
> Code;  c0105178 <poll_idle+0/20>
>    5:   fb                        sti    
> Code;  c0105179 <poll_idle+1/20>
>    6:   ba 00 e0 ff ff            mov    $0xffffe000,%edx
> Code;  c010517e <poll_idle+6/20>
>    b:   21 e2                     and    %esp,%edx
> Code;  c0105180 <poll_idle+8/20>
>    d:   b8 ff ff ff ff            mov    $0xffffffff,%eax
> Code;  c0105185 <poll_idle+d/20>
>   12:   87 42 00                  xchg   %eax,0x0(%edx)
> 
>   <0> Kernel panic: Attempted to kill the idle task!
> 
> 
> Thanks,
> 
> -- 
> Wenzhuo
>   GnuPG Key ID 0xBA586A68
>   Key fingerprint = 89C7 C6DE D956 F978 3F12  A8AF 5847 F840 BA58 6A68
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Wenzhuo
  GnuPG Key ID 0xBA586A68
  Key fingerprint = 89C7 C6DE D956 F978 3F12  A8AF 5847 F840 BA58 6A68
