Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288658AbSATO1i>; Sun, 20 Jan 2002 09:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288645AbSATO1a>; Sun, 20 Jan 2002 09:27:30 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:24998 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S288657AbSATO1T>; Sun, 20 Jan 2002 09:27:19 -0500
Date: Sun, 20 Jan 2002 14:28:11 +0000
From: Dave Jones <davej@suse.de>
To: zippel@linux-m68k.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: AFFS oops.
Message-ID: <20020120142811.A22052@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, zippel@linux-m68k.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a boring Sunday afternoon, so I decided to do some destruction testing
on unusual filesystems. First on the list is AFFS.

I mounted a 900k AFFS floppy disk image via loopback, and ran fsx on it.
It dies instantly, before fsx gets to do any of its usual fun.


Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01de497
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01de497>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c01de488   ebx: 000006a0   ecx: cff63db8   edx: 00000000
esi: c12c5940   edi: cc511e8c   ebp: cf983800   esp: cb1bfe98
ds: 0018   es: 0018   ss: 0018
Process a.out (pid: 10367, stackpage=cb1bf000)
Stack: 000006a0 c12c5940 cc511e8c cf983800 cc511e8c c01ded06 00000000 c12c5940 
       000006a0 000006a0 000186a0 00000000 cc511ddc 00000000 00000000 00000000 
       cc511ddc 00000000 000000cc c0126481 00000002 c01264e0 cc511ddc 00000048 
Call Trace: [<c01ded06>] [<c0126481>] [<c01264e0>] [<c01480cb>] [<c01dce7f>] 
   [<c0148200>] [<c01344d9>] [<c0134777>] [<c0108743>] 
Code: 8b 42 08 31 d2 8b 48 08 8b 74 24 1c 8b 46 18 a9 08 00 00 00 

>>EIP; c01de496 <affs_commit_write_ofs+72/698>   <=====
Trace; c01ded06 <affs_truncate+206/384>
Trace; c0126480 <do_swap_page+84/ec>
Trace; c01264e0 <do_swap_page+e4/ec>
Trace; c01480ca <notify_change+86/dc>
Trace; c01dce7e <affs_new_inode+66/1cc>
Trace; c0148200 <free_fd_array+8/4c>
Trace; c01344d8 <sys_truncate+148/180>
Trace; c0134776 <sys_truncate64+14a/184>
Trace; c0108742 <system_call+32/40>
Code;  c01de496 <affs_commit_write_ofs+72/698>
00000000 <_EIP>:
Code;  c01de496 <affs_commit_write_ofs+72/698>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  c01de498 <affs_commit_write_ofs+74/698>
   3:   31 d2                     xor    %edx,%edx
Code;  c01de49a <affs_commit_write_ofs+76/698>
   5:   8b 48 08                  mov    0x8(%eax),%ecx
Code;  c01de49e <affs_commit_write_ofs+7a/698>
   8:   8b 74 24 1c               mov    0x1c(%esp,1),%esi
Code;  c01de4a2 <affs_commit_write_ofs+7e/698>
   c:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c01de4a4 <affs_commit_write_ofs+80/698>
   f:   a9 08 00 00 00            test   $0x8,%eax


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
