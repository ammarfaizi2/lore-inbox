Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbRE1KtV>; Mon, 28 May 2001 06:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbRE1KtB>; Mon, 28 May 2001 06:49:01 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:50771 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263027AbRE1KtA>; Mon, 28 May 2001 06:49:00 -0400
Date: Mon, 28 May 2001 13:48:47 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: initrd oops with 2.4.5ac2: megaraid OOPSes
Message-ID: <20010528134847.R11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk> <20010527192650.H11981@niksula.cs.hut.fi> <20010528001220.M11981@niksula.cs.hut.fi> <20010528102551.N11981@niksula.cs.hut.fi> <20010528180254.380908d8.masaruk@gol.com> <20010528130507.P11981@niksula.cs.hut.fi> <20010528132831.Q11981@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528132831.Q11981@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Mon, May 28, 2001 at 01:28:31PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 01:28:31PM +0300, you [Ville Herva] claimed:
> 
> The other OOPS (http://v.iki.fi/~vherva/tmp/bootlog.grub and
> http://v.iki.fi/~vherva/tmp/ksymoops-grub) still remains: 

That one appears to be because it couldn't find the initrd (incorrect boot
param, my fault). Should it oops then? 2.4.2-2 definetely doesn't. With the
correct initrd param 2.4.4 boots ok, but 2.4.5ac2 still OOPSes. Now it only
does it later, during scsi adapter probe:

ksymoops 2.4.1 on i686 2.4.5-ac2.  Options used
     -v ./vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac2/ (default)
     -m ./System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000004f
c01c02bf
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01c02bf>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: ffffffff   ebx: f7ef007c   ecx: 00000001   edx: c1eec400
esi: 0000000f   edi: f7ef8aac   ebp: f8800000   esp: cfb2bee8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=cfb2b000)
Stack: 00000000 c0114966 c1eec400 00000000 00000001 0f001667 00001681
0000003f
       00009060 0000101e 00001667 f7ef0000 00001960 00008086 00000000
10cd7b40
       3344103c 00000000 00000000 c02d7b40 c0267aa0 c01c05ce c0267aa0
00008086
Call Trace: [<c0114966>] [<c01c05ce>] [<c01af674>] [<c0105000>] [<c01af024>]
   [<c0105000>] [<c014786f>] [<c0147bb0>] [<c0105000>] [<c0105209>]
[<c0105000>]
   [<c01056a6>] [<c0105200>]
Code: 89 68 50 8b 83 dc 02 00 00 c6 40 54 10 8b 8b dc 02 00 00 0f

>>EIP; c01c02bf <mega_findCard+30f/530>   <=====
Trace; c0114966 <__call_console_drivers+46/60>
Trace; c01c05ce <megaraid_detect+ee/1d0>
Trace; c01af674 <scsi_unregister_host+3c4/450>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01af024 <scsi_register_host+54/2e0>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c014786f <proc_register+f/90>
Trace; c0147bb0 <create_proc_entry+90/a0>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c0105209 <init+9/140>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01056a6 <kernel_thread+26/30>
Trace; c0105200 <init+0/140>
Code;  c01c02bf <mega_findCard+30f/530>
00000000 <_EIP>:
Code;  c01c02bf <mega_findCard+30f/530>   <=====
   0:   89 68 50                  mov    %ebp,0x50(%eax)   <=====
Code;  c01c02c2 <mega_findCard+312/530>
   3:   8b 83 dc 02 00 00         mov    0x2dc(%ebx),%eax
Code;  c01c02c8 <mega_findCard+318/530>
   9:   c6 40 54 10               movb   $0x10,0x54(%eax)
Code;  c01c02cc <mega_findCard+31c/530>
   d:   8b 8b dc 02 00 00         mov    0x2dc(%ebx),%ecx
Code;  c01c02d2 <mega_findCard+322/530>
  13:   0f 00 00                  sldt   (%eax)


bootlog:
http://v.iki.fi/~vherva/tmp/bootlog.sym53
ksymoops:
http://v.iki.fi/~vherva/tmp/ksymoops-sym53

I have sym53c875 and megaraid in this box. If the megaraid scsi bios is
disabled, it boots ok (from the sym53c875), if I enable the bios and boot
from megaraid, I get the oops above.


-- v --

v@iki.fi
