Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262401AbTCMPe1>; Thu, 13 Mar 2003 10:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbTCMPe0>; Thu, 13 Mar 2003 10:34:26 -0500
Received: from jack.stev.org ([217.79.103.51]:62004 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S262401AbTCMPeT>;
	Thu, 13 Mar 2003 10:34:19 -0500
Message-ID: <014b01c2e978$701050e0$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Stephan von Krawczynski" <skraw@ithnet.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
References: <20030227221017.4291c1f6.skraw@ithnet.com>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Date: Thu, 13 Mar 2003 15:50:51 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

strange looks alot like the ones i have seen though the whole 2.4.x tree.

this was discussed before somebody said they would send a patch myself
and sombody else were going to test it but the patch never happens.
>From what i can work out an error occurs on the cd drive and the request
queue is then empty and the ide-scsi driver then attempts to access the
reuest queue that doesnt exist i never did manage to find out
where the request get removed from the queue though.


*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e5783>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c7a71000   ecx: c0327104   edx: 00000000
esi: 00000001   edi: c13a4fc0   ebp: cb23df58   esp: cb23df44
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 381, stackpage=cb23d000)
Stack: 00000000 c0327294 c13de260 c0327294 00000202 cb23df78 c01cdd11
c0327294
       c01e5700 c0327104 c121db00 04000001 0000000f cb23df98 c010a0bd
0000000f
       c13de260 cb23dfc4 cb23dfc4 0000000f c02f8ae0 cb23dfbc c010a24d
0000000f
Call Trace: [<c01cdd11>] [<c01e5700>] [<c010a0bd>] [<c010a24d>] [<c010c358>]
Code: 8b 72 18 46 89 72 18 8b 55 f0 8b 82 f0 00 00 00 8b 58 04 53

>>EIP; c01e5783 <idescsi_pc_intr+83/290>   <=====
Trace; c01cdd11 <ide_intr+c1/120>
Trace; c01e5700 <idescsi_pc_intr+0/290>
Trace; c010a0bd <handle_IRQ_event+3d/70>
Trace; c010a24d <do_IRQ+7d/c0>
Trace; c010c358 <call_do_IRQ+5/d>
Code;  c01e5783 <idescsi_pc_intr+83/290>
00000000 <_EIP>:
Code;  c01e5783 <idescsi_pc_intr+83/290>   <=====
   0:   8b 72 18                  mov    0x18(%edx),%esi   <=====
Code;  c01e5786 <idescsi_pc_intr+86/290>
   3:   46                        inc    %esi
Code;  c01e5787 <idescsi_pc_intr+87/290>
   4:   89 72 18                  mov    %esi,0x18(%edx)
Code;  c01e578a <idescsi_pc_intr+8a/290>
   7:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
Code;  c01e578d <idescsi_pc_intr+8d/290>
   a:   8b 82 f0 00 00 00         mov    0xf0(%edx),%eax
Code;  c01e5793 <idescsi_pc_intr+93/290>
  10:   8b 58 04                  mov    0x4(%eax),%ebx
Code;  c01e5796 <idescsi_pc_intr+96/290>
  13:   53                        push   %ebx

<0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.



----- Original Message -----
From: "Stephan von Krawczynski" <skraw@ithnet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Marcelo Tosatti"
<marcelo@conectiva.com.br>
Sent: Thursday, February 27, 2003 9:10 PM
Subject: OOPS in 2.4.21-pre5, ide-scsi


> Hello all,
>
> I just installed pre5 and did my current favourite test: mounting a cdrom
with ide-scsi. Maybe you remember my problem: I enter the mount, cdrom spins
up, around 20-30 seconds, then freeze.
>
> But this time it oops'ed, and here it is:
> (I had to write it down by hand, and "filled" it in another oops "form",
so just forget the date/time. All the values should be correct, I checked
twice.)
>
> # ksymoops < oops
> ksymoops 2.4.5 on i686 2.4.21-pre5.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.21-pre5/ (default)
>      -m /boot/System.map-2.4.21-pre5 (default)
>
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
>
> Nov  5 19:48:49 linux kernel: Oops: 0002
> Nov  5 19:48:49 linux kernel: CPU:    0
> Nov  5 19:48:49 linux kernel: EIP:    0010:[<c0213ab3>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Nov  5 19:48:49 linux kernel: EFLAGS: 00010202
> Nov  5 19:48:49 linux kernel: eax: 00000000   ebx: 00000001   ecx:
c1613d84   edx: 3e076fe3
> Nov  5 19:48:49 linux kernel: esi: d93ca000   edi: c0363d80   ebp:
c165cd80   esp: d98d3f2c
> Nov  5 19:48:49 linux kernel: ds: 0018   es: 0018   ss: 0018
> Nov  5 19:48:49 linux kernel: Process setiathome (pid: 1371,
stackpage=d98d3000)
> Nov  5 19:48:49 linux kernel: Stack: 00000177 51eb851f d98d2000 00100000
c01299e5 bffffa60 d98d3f50 3e076fe3
> Nov  5 19:48:49 linux kernel:        c1613d60 c0363d80 00000286 c0363cd0
c01dcbd6 c0363d80 00000000 c0213a50
> Nov  5 19:48:49 linux kernel:        c1634c80 04000001 00000000 d98d3fc4
c0109129 0000000f c1613d60 d98d3fc4
> Nov  5 19:48:49 linux kernel: Call Trace:    [<c01299e5>] [<c01dcbd6>]
[<c0213a50>] [<c0109129>] [<c0109348>] [<c010bec8>]
> Nov  5 19:48:49 linux kernel: Code: ff 42 18 89 3c 24 c7 44 24 04 01 00 00
00 e8 ae fc ff ff 31
>
>
> >>EIP; c0213ab3 <idescsi_pc_intr+63/360>   <=====
>
> >>ecx; c1613d84 <_end+12a072c/20557a08>
> >>edx; 3e076fe3 Before first symbol
> >>esi; d93ca000 <_end+190569a8/20557a08>
> >>edi; c0363d80 <ide_hwifs+520/2c60>
> >>ebp; c165cd80 <_end+12e9728/20557a08>
> >>esp; d98d3f2c <_end+195608d4/20557a08>
>
> Trace; c01299e5 <getrusage+d5/230>
> Trace; c01dcbd6 <ide_intr+e6/180>
> Trace; c0213a50 <idescsi_pc_intr+0/360>
> Trace; c0109129 <handle_IRQ_event+69/a0>
> Trace; c0109348 <do_IRQ+98/f0>
> Trace; c010bec8 <call_do_IRQ+5/d>
>
> Code;  c0213ab3 <idescsi_pc_intr+63/360>
> 00000000 <_EIP>:
> Code;  c0213ab3 <idescsi_pc_intr+63/360>   <=====
>    0:   ff 42 18                  incl   0x18(%edx)   <=====
> Code;  c0213ab6 <idescsi_pc_intr+66/360>
>    3:   89 3c 24                  mov    %edi,(%esp,1)
> Code;  c0213ab9 <idescsi_pc_intr+69/360>
>    6:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
> Code;  c0213ac0 <idescsi_pc_intr+70/360>
>    d:   00
> Code;  c0213ac1 <idescsi_pc_intr+71/360>
>    e:   e8 ae fc ff ff            call   fffffcc1 <_EIP+0xfffffcc1>
c0213774 <idescsi_do_end_request+a4/e0>
> Code;  c0213ac6 <idescsi_pc_intr+76/360>
>   13:   31 00                     xor    %eax,(%eax)
>
> Nov  5 19:48:49 linux kernel:  <0>Kernel panic: Aiee, killing interrupt
handler!
>
> 1 warning issued.  Results may not be reliable.
>


