Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSGRN0r>; Thu, 18 Jul 2002 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGRN0r>; Thu, 18 Jul 2002 09:26:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318058AbSGRN0q>;
	Thu, 18 Jul 2002 09:26:46 -0400
Date: Thu, 18 Jul 2002 14:29:46 +0100
From: Matthew Wilcox <willy@debian.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718142946.L13352@parcelfarce.linux.theplanet.co.uk>
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk> <20020718010617.GL1096@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020718010617.GL1096@holomorphy.com>; from wli@holomorphy.com on Wed, Jul 17, 2002 at 06:06:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 06:06:17PM -0700, William Lee Irwin III wrote:
> Could you reproduce this and get maybe a backtrace and a line number?

100% reproducible...

ksymoops 2.4.5 on i686 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01b7695
*pde = 37867001
Oops: 0000
CPU:    0
EIP:    0010:[<c01b7695>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000001   ebx: 00000000   ecx: 00000000   edx: f7906600
esi: 00000000   edi: c03dcc00   ebp: 00000000   esp: c3d45e7c
ds: 0018   es: 0018   ss: 0018
Stack: f7906600 00000001 c03dc9a0 00000000 00000000 c01b7773 00000000 00000001 
       00000000 f784a000 00000000 f78518f0 f7906600 c01baa25 00000000 00000000 
       00000001 c01ac08c f784a000 f7871da0 c3d44000 f7871da0 00000000 f78518f0 
Call Trace: [<c01b7773>] [<c01baa25>] [<c01ac08c>] [<c0145a83>] [<c0144ed7>] 
   [<c0146373>] [<c013c33a>] [<c013b001>] [<c013af16>] [<c013b307>] [<c0108893>]
 
Code: 8b 41 04 ff d0 8b 34 3b 83 c4 08 66 83 7e 22 00 75 22 8a 86 


>>EIP; c01b7695 <visual_init+85/e0>   <=====

>>edx; f7906600 <END_OF_CODE+37502e5c/????>
>>edi; c03dcc00 <vc_cons+0/fc>
>>esp; c3d45e7c <END_OF_CODE+39426d8/????>

Trace; c01b7773 <vc_allocate+83/140>
Trace; c01baa25 <con_open+19/88>
Trace; c01ac08c <tty_open+20c/394>
Trace; c0145a83 <link_path_walk+683/874>
Trace; c0144ed7 <permission+27/2c>
Trace; c0146373 <may_open+5f/2ac>
Trace; c013c33a <chrdev_open+66/98>
Trace; c013b001 <dentry_open+e1/1b0>
Trace; c013af16 <filp_open+52/5c>
Trace; c013b307 <sys_open+37/74>
Trace; c0108893 <syscall_call+7/b>

Code;  c01b7695 <visual_init+85/e0>
00000000 <_EIP>:
Code;  c01b7695 <visual_init+85/e0>   <=====
   0:   8b 41 04                  mov    0x4(%ecx),%eax   <=====
Code;  c01b7698 <visual_init+88/e0>
   3:   ff d0                     call   *%eax
Code;  c01b769a <visual_init+8a/e0>
   5:   8b 34 3b                  mov    (%ebx,%edi,1),%esi
Code;  c01b769d <visual_init+8d/e0>
   8:   83 c4 08                  add    $0x8,%esp
Code;  c01b76a0 <visual_init+90/e0>
   b:   66 83 7e 22 00            cmpw   $0x0,0x22(%esi)
Code;  c01b76a5 <visual_init+95/e0>
  10:   75 22                     jne    34 <_EIP+0x34> c01b76c9 <visual_init+b9
/e0>
Code;  c01b76a7 <visual_init+97/e0>
  12:   8a 86 00 00 00 00         mov    0x0(%esi),%al

 <0>Kernel panic: Attempted to kill init!



-- 
Revolutions do not require corporate support.
