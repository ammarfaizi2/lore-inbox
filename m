Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136453AbRD3Gav>; Mon, 30 Apr 2001 02:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136452AbRD3Gam>; Mon, 30 Apr 2001 02:30:42 -0400
Received: from gateway.folmsbee.com ([204.250.21.200]:51217 "EHLO
	gateway.folmsbee.com") by vger.kernel.org with ESMTP
	id <S136454AbRD3Gae>; Mon, 30 Apr 2001 02:30:34 -0400
Message-ID: <001e01c0d13f$0f820d20$030a0a0a@aaron.home>
From: "Aaron M. Folmsbee" <aaron@folmsbee.com>
To: <linux-kernel@vger.kernel.org>,
        "Ville Herva" <vherva@mail.niksula.cs.hut.fi>
In-Reply-To: <000a01c0d047$eb250060$030a0a0a@aaron.home> <20010429103909.J3529@niksula.cs.hut.fi>
Subject: Re: 2.4.x SMP Kernel Exception (Bug?)
Date: Sun, 29 Apr 2001 23:30:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Ville Herva" <vherva@mail.niksula.cs.hut.fi>
To: "Aaron M. Folmsbee" <aaron@folmsbee.com>
Sent: Sunday, April 29, 2001 12:39 AM
Subject: Re: 2.4.x SMP Kernel Exception (Bug?)


> Please feed it through ksymoops (see Documentation/oops-tracing.txt and
make
> sure your System.map matches the kernel in question).
>
> You are sure that your hardware is not faulty? Has it been running
reliably
> with other kernels? What happens if you swap the CPU's and run in in UP
> mode? Have you run memtest86?

The hardware has run 2.3x SMP kernels successfully for over a year.

I tried running the 2.4.4 kernel that is crashing with the 'nosmp' option,
and it booted ok.

The ksymoops output:

ksymoops 2.4.0 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m System.map (specified)

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
invalid operand: 0000
CPU: 0
EIP: 0010:[<c010c630>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0183fbff   ebx: cba52000     ecx: c02d0000       edx: cba52000
esi: c02d0000   edi: c02d0350     edp: 00000000       esp: c02d1f74
ds: 0018        es:0018               ss:0018
Process swapper (pid: 0, stackpage=c02d1000)
Stack:  c010581d cba52000 c0305800 cba52350 cba52000 cbd87a40 00000000
cba53e1c
        c0110e66 c02d1fd4 00000001 cdb87a40 c01051b0 cba52000 c02d0000
00000001
        c02d0000 00000030 00000000 c02d0000 c0309440 c01051b0 c02d0000
c02d0000
           [<c01051b0>] [<c010526e>] [<c0105000>] [<c01001cf>]
Code: 0f ae 82 90 03 00 00 db e2 eb 0c 90 8d 74 26 00 dd b2 90 03

>>EIP; c010c630 <save_init_fpu+10/40>   <=====
Code;  c010c630 <save_init_fpu+10/40>
00000000 <_EIP>:
Code;  c010c630 <save_init_fpu+10/40>   <=====
   0:   0f ae 82 90 03 00 00      fxsave 0x390(%edx)   <=====
Code;  c010c637 <save_init_fpu+17/40>
   7:   db e2                     fnclex
Code;  c010c639 <save_init_fpu+19/40>
   9:   eb 0c                     jmp    17 <_EIP+0x17> c010c647
<save_init_fpu+27/40>
Code;  c010c63b <save_init_fpu+1b/40>
   b:   90                        nop
Code;  c010c63c <save_init_fpu+1c/40>
   c:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c010c640 <save_init_fpu+20/40>
  10:   dd b2 90 03 00 00         fnsave 0x390(%edx)

Kernel panic: Attempted to kill the idle task!

1 warning issued.  Results may not be reliable.


