Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbUDXOXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUDXOXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDXOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 10:23:36 -0400
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:34579 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S262316AbUDXOX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 10:23:29 -0400
Date: Sat, 24 Apr 2004 07:20:27 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: oops with 2.6.6-rc1
Message-ID: <20040424142027.GA31681@net-ronin.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Not sure if ksymoops 2.4.9 is the right version, but that's what
I found via the oops-tracing.txt file in the src tree.

This kernel was via a bk pull, not sure when I grabbed it.

Really hard bug to reproduce, didn't notice for quite a while.
Any suggestions on tracking it down?

Debian/stable, gcc 3.3.1

Oops decode from ksymoops below, .config, etc info attached as
seperate file due to sheer size.  Yes, it has a lot of modules.
Helps boot time on this IBM T30 quite a bit.  :-)

ksymoops 2.4.9 on i686 2.6.6-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6-rc1/ (default)
     -m /boot/System.map-2.6.6-rc1 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 23 07:35:03 hasenpfeffer kernel: Unable to handle kernel paging request at virtual address 0008c940
Apr 23 07:35:03 hasenpfeffer kernel: c01425b8
Apr 23 07:35:03 hasenpfeffer kernel: *pde = 00000000
Apr 23 07:35:03 hasenpfeffer kernel: Oops: 0000 [#1]
Apr 23 07:35:03 hasenpfeffer kernel: CPU:    0
Apr 23 07:35:03 hasenpfeffer kernel: EIP:    0060:[<c01425b8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 23 07:35:03 hasenpfeffer kernel: EFLAGS: 00010202   (2.6.6-rc1) 
Apr 23 07:35:03 hasenpfeffer kernel: eax: 0008c940   ebx: c20a9080   ecx: c0143bdb   edx: cff54700
Apr 23 07:35:03 hasenpfeffer kernel: esi: 00018800   edi: c7031d1c   ebp: ffffffe9   esp: c1b65f54
Apr 23 07:35:03 hasenpfeffer kernel: ds: 007b   es: 007b   ss: 0068
Apr 23 07:35:03 hasenpfeffer kernel: Stack: 00000000 c2741000 00018800 c1b64000 c0142526 c7036580 cff54700 00018800 
Apr 23 07:35:03 hasenpfeffer kernel:        080574fc 00000004 c2741000 c7036580 cff54700 c2741000 c1b64000 080574fc 
Apr 23 07:35:03 hasenpfeffer kernel:        00000103 00000001 00018801 00000000 c014292b c2741000 00018800 00000000 
Apr 23 07:35:03 hasenpfeffer kernel: Call Trace: [<c0142526>]  [<c014292b>]  [<c0103bcf>] 
Apr 23 07:35:03 hasenpfeffer kernel: Code: 8b 10 be 01 00 00 00 85 d2 74 35 b8 00 e0 ff ff 21 e0 ff 40 


>>EIP; c01425b8 <dentry_open+88/1e4>   <=====

>>ebx; c20a9080 <pg0+1da5080/3fcfa000>
>>ecx; c0143bdb <get_empty_filp+4f/c8>
>>edx; cff54700 <pg0+fc50700/3fcfa000>
>>edi; c7031d1c <pg0+6d2dd1c/3fcfa000>
>>ebp; ffffffe9 <__kernel_rt_sigreturn+1ba9/????>
>>esp; c1b65f54 <pg0+1861f54/3fcfa000>

Trace; c0142526 <filp_open+52/5c>
Trace; c014292b <sys_open+37/90>
Trace; c0103bcf <syscall_call+7/b>

Code;  c01425b8 <dentry_open+88/1e4>
00000000 <_EIP>:
Code;  c01425b8 <dentry_open+88/1e4>   <=====
   0:   8b 10                     mov    (%eax),%edx   <=====
Code;  c01425ba <dentry_open+8a/1e4>
   2:   be 01 00 00 00            mov    $0x1,%esi
Code;  c01425bf <dentry_open+8f/1e4>
   7:   85 d2                     test   %edx,%edx
Code;  c01425c1 <dentry_open+91/1e4>
   9:   74 35                     je     40 <_EIP+0x40> c01425f8 <dentry_open+c8/1e4>
Code;  c01425c3 <dentry_open+93/1e4>
   b:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c01425c8 <dentry_open+98/1e4>
  10:   21 e0                     and    %esp,%eax
Code;  c01425ca <dentry_open+9a/1e4>
  12:   ff 40 00                  incl   0x0(%eax)

Apr 23 07:35:04 hasenpfeffer kernel:  <1>Unable to handle kernel paging request at virtual address 0008c940
Apr 23 07:35:04 hasenpfeffer kernel: c01425b8
Apr 23 07:35:04 hasenpfeffer kernel: *pde = 00000000
Apr 23 07:35:04 hasenpfeffer kernel: Oops: 0000 [#2]
Apr 23 07:35:04 hasenpfeffer kernel: CPU:    0
Apr 23 07:35:04 hasenpfeffer kernel: EIP:    0060:[<c01425b8>]    Not tainted
Apr 23 07:35:04 hasenpfeffer kernel: EFLAGS: 00010202   (2.6.6-rc1) 
Apr 23 07:35:04 hasenpfeffer kernel: eax: 0008c940   ebx: c20a9680   ecx: c0143bdb   edx: cff54700
Apr 23 07:35:04 hasenpfeffer kernel: esi: 00018800   edi: c7031d1c   ebp: ffffffe9   esp: c1c05f54
Apr 23 07:35:04 hasenpfeffer kernel: ds: 007b   es: 007b   ss: 0068
Apr 23 07:35:04 hasenpfeffer kernel: Stack: 00000000 c24b9000 00018800 c1c04000 c0142526 c7036580 cff54700 00018800 
Apr 23 07:35:04 hasenpfeffer kernel:        0805801c 00000004 c24b9000 c7036580 cff54700 c24b9000 c1c04000 0805801c 
Apr 23 07:35:04 hasenpfeffer kernel:        00000103 00000001 00018801 00000000 c014292b c24b9000 00018800 00000000 
Apr 23 07:35:04 hasenpfeffer kernel: Call Trace: [<c0142526>]  [<c014292b>]  [<c0103bcf>] 
Apr 23 07:35:04 hasenpfeffer kernel: Code: 8b 10 be 01 00 00 00 85 d2 74 35 b8 00 e0 ff ff 21 e0 ff 40 


>>EIP; c01425b8 <dentry_open+88/1e4>   <=====

>>ebx; c20a9680 <pg0+1da5680/3fcfa000>
>>ecx; c0143bdb <get_empty_filp+4f/c8>
>>edx; cff54700 <pg0+fc50700/3fcfa000>
>>edi; c7031d1c <pg0+6d2dd1c/3fcfa000>
>>ebp; ffffffe9 <__kernel_rt_sigreturn+1ba9/????>
>>esp; c1c05f54 <pg0+1901f54/3fcfa000>

Trace; c0142526 <filp_open+52/5c>
Trace; c014292b <sys_open+37/90>
Trace; c0103bcf <syscall_call+7/b>

Code;  c01425b8 <dentry_open+88/1e4>
00000000 <_EIP>:
Code;  c01425b8 <dentry_open+88/1e4>   <=====
   0:   8b 10                     mov    (%eax),%edx   <=====
Code;  c01425ba <dentry_open+8a/1e4>
   2:   be 01 00 00 00            mov    $0x1,%esi
Code;  c01425bf <dentry_open+8f/1e4>
   7:   85 d2                     test   %edx,%edx
Code;  c01425c1 <dentry_open+91/1e4>
   9:   74 35                     je     40 <_EIP+0x40> c01425f8 <dentry_open+c8/1e4>
Code;  c01425c3 <dentry_open+93/1e4>
   b:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c01425c8 <dentry_open+98/1e4>
  10:   21 e0                     and    %esp,%eax
Code;  c01425ca <dentry_open+9a/1e4>
  12:   ff 40 00                  incl   0x0(%eax)


1 error issued.  Results may not be reliable.

--W/nzBZO5zC0uMSeA
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="sysdat.txt.bz2"
Content-Transfer-Encoding: base64

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
qEh0cP+LuSKcKEhYwKyQAA==

--W/nzBZO5zC0uMSeA--
