Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTABETB>; Wed, 1 Jan 2003 23:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbTABETB>; Wed, 1 Jan 2003 23:19:01 -0500
Received: from admin.nni.com ([216.107.0.51]:49674 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S265484AbTABETA>;
	Wed, 1 Jan 2003 23:19:00 -0500
From: Andrew Rodland <arodland@noln.com>
Organization: Dis Organization
To: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: fbcon breakage?
Date: Wed, 1 Jan 2003 23:27:18 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301012327.18244.arodland@noln.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using a Dell Latitude CPi A laptop, with a Neomagic 2200 graphics chip in 
it.
Since earlier today, I can't get it to work with neofb; I get a really nasty 
oops early in the boot, right after neofb initialized.
 I changed more than a few things today, but I changed everything back, 
around, and in circles, and it still seems to come down to neofb.

Anyway, I manually copied down the oops and ran it through ksymoops.
Output follows.

Please Cc:, as I read the list through GMANE.

Thanks
--hobbs

--snip--

ksymoops 2.4.6 on i686 2.4.19-ck14.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.53/ (specified)
     -m System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c02423e8
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0060:[<c02423e8>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000 ebx: 00000018 ecx: c0376da0 edx: 00000000
esi: c11f7e28 edi: c11f7e48 ebp: c11f7e08 esp: c11f7dbc
ds: 007b es: 007b ss: 0068
Stack: c033d7cc c11f6000 c033d7cc c0135041 c11d9408 c03ec6a0 00000000 00000000
00000000 00000020 00000000 00000010 00000010 c11f7e68 cbd57000 c03a1e7f
c11f7e68 00000001 cbd57000 06060000 0e0e0a0a 1a1a1616 22221e1e 00001212
Call Trace: [<c0135041>] [<c0240e29>] [<c0242c15>] [<c024ec87>] [<c023f509>] 
[<c01e60ad>] [<c01e9ee0>] [<c01e2d94>] [<c0105705>] [<c0105040>] [<c0108ff9>]
Code: 0f b7 13 89 54 24 10 8d 43 02 83 c5 02 83 c7 02 73 c6 02 85


>>EIP; c02423e8 <fb_set_cmap+88/150>   <=====

>>ecx; c0376da0 <neofb_ops+0/60>

Trace; c0135041 <buffered_rmqueue+b1/150>
Trace; c0240e29 <fb_show_logo+219/2b0>
Trace; c0242c15 <neoUnlock+5/20>
Trace; c024ec87 <ds_release+7/a0>
Trace; c023f509 <fbcon_switch+129/1f0>
Trace; c01e60ad <redraw_screen+11d/190>
Trace; c01e9ee0 <take_over_console+1b0/1d0>
Trace; c01e2d94 <con_set_default_unimap+164/180>
Trace; c0105705 <huft_build+285/540>
Trace; c0105040 <init+0/160>
Trace; c0108ff9 <kernel_thread_helper+5/c>

Code;  c02423e8 <fb_set_cmap+88/150>
00000000 <_EIP>:
Code;  c02423e8 <fb_set_cmap+88/150>   <=====
   0:   0f b7 13                  movzwl (%ebx),%edx   <=====
Code;  c02423eb <fb_set_cmap+8b/150>
   3:   89 54 24 10               mov    %edx,0x10(%esp,1)
Code;  c02423ef <fb_set_cmap+8f/150>
   7:   8d 43 02                  lea    0x2(%ebx),%eax
Code;  c02423f2 <fb_set_cmap+92/150>
   a:   83 c5 02                  add    $0x2,%ebp
Code;  c02423f5 <fb_set_cmap+95/150>
   d:   83 c7 02                  add    $0x2,%edi
Code;  c02423f8 <fb_set_cmap+98/150>
  10:   73 c6                     jae    ffffffd8 <_EIP+0xffffffd8>
Code;  c02423fa <fb_set_cmap+9a/150>
  12:   02 85 00 00 00 00         add    0x0(%ebp),%al

<0>kernel panic: Attempted to kill init!

