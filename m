Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284871AbRLURUv>; Fri, 21 Dec 2001 12:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284853AbRLURUr>; Fri, 21 Dec 2001 12:20:47 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:10771 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284879AbRLURUa>;
	Fri, 21 Dec 2001 12:20:30 -0500
Date: Fri, 21 Dec 2001 09:16:46 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: oops in mm/memory.c remap_page_range() in 2.2.20
Message-ID: <20011221091646.C21051@kroah.com>
In-Reply-To: <20011221090511.A21051@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221090511.A21051@kroah.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 23 Nov 2001 14:23:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 09:05:11AM -0800, Greg KH wrote:
> Running "cvs update" on a 2.2.20 kernel with 16Mb of real memory I got
> the following oops:

Sorry, had /boot/System.map pointing to the wrong place, this is the
correct symbols:

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000002
current->tss.cr3 = 00f53000, %cr3 = 00f53000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01194a0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000002   ebx: c0fe4f50   ecx: 00000000   edx: c0229ff8
esi: 00000000   edi: c0fe4f50   ebp: 00000002   esp: c0805f04
ds: 0018   es: 0018   ss: 0018
Process cvs (pid: 21185, process nr: 44, stackpage=c0805000)
Stack: c0fe4f50 00000000 c0fe4fcc c011956f 00000002 00000000 c0804000 c0fe4f9c 
       c012247e c0fe4f50 00000000 00000000 c0fe4f50 00000243 c0ebd200 00000000 
       00000048 c0fe4f50 00000243 00000000 3c2367de 3c2367de 3c2367de 00000006 
Call Trace: [<c011956f>] [<c012247e>] [<c012aa62>] [<c0122ea4>] [<c01230ea>] [<c01079c4>] 
Code: 8b 4d 00 89 4c 24 10 8b 5d 04 8b 75 08 29 de 8b 55 2c 3b 54 

>>EIP; c01194a0 <vmtruncate_list+c/a8>   <=====
Trace; c011956f <vmtruncate+33/3c>
Trace; c012247e <do_truncate+66/9c>
Trace; c012aa62 <open_namei+2be/2ec>
Trace; c0122ea4 <filp_open+44/f0>
Trace; c01230ea <sys_open+36/94>
Trace; c01079c4 <system_call+34/38>
Code;  c01194a0 <vmtruncate_list+c/a8>
00000000 <_EIP>:
Code;  c01194a0 <vmtruncate_list+c/a8>   <=====
   0:   8b 4d 00                  mov    0x0(%ebp),%ecx   <=====
Code;  c01194a3 <vmtruncate_list+f/a8>
   3:   89 4c 24 10               mov    %ecx,0x10(%esp,1)
Code;  c01194a7 <vmtruncate_list+13/a8>
   7:   8b 5d 04                  mov    0x4(%ebp),%ebx
Code;  c01194aa <vmtruncate_list+16/a8>
   a:   8b 75 08                  mov    0x8(%ebp),%esi
Code;  c01194ad <vmtruncate_list+19/a8>
   d:   29 de                     sub    %ebx,%esi
Code;  c01194af <vmtruncate_list+1b/a8>
   f:   8b 55 2c                  mov    0x2c(%ebp),%edx
Code;  c01194b2 <vmtruncate_list+1e/a8>
  12:   3b 54 00 00               cmp    0x0(%eax,%eax,1),%edx


greg k-h
