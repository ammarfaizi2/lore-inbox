Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282056AbRLWWGK>; Sun, 23 Dec 2001 17:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281863AbRLWWGB>; Sun, 23 Dec 2001 17:06:01 -0500
Received: from chemlab.org ([216.151.95.151]:6874 "EHLO chemlab.org")
	by vger.kernel.org with ESMTP id <S282056AbRLWWFt>;
	Sun, 23 Dec 2001 17:05:49 -0500
Date: Sun, 23 Dec 2001 17:05:47 -0500
From: "steve j. kondik" <shade@chemlab.org>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: oops on boot w/ lvm root & xfs
Message-ID: <20011223220547.GA16992@chemlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm not sure if this is a devfs problem of an xfs problem.
i'm using an initrd to set up my lvmroot.  devfs complains then
panics.  all versions of 2.4.17 that i've tried (rc1, rc2, final)
will not boot.  2.4.16 runs fine.  help :>

devfs: devfs_do_symlink(root): could not append to parent, err: -17
change_root: old root has d_count=2

here's the ksymoops (i copied this by hand- i hope its right)

ksymoops 2.4.3 on i686 2.4.16-sk.  Options used
     -V (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs (specified)
     -m /boot/System.map-2.4.17-xfs (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d3ed>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c14be440    ecx: c14be4a8   edx: c14be438
esi: c14be431   edi: c031b4d4    ebp: 00020000   esp: c140ff00
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c140f000)
Stack: c140ff68 c140e000 cfecc340 c140ffbc c140ff1c c14be460 00000004 0000000c
       c038d7c4 c031b4c7 00000014 00000040 00000000 00000000 00000000 c038d0df
       c0317560 00000002 ffffffbf ffffffff 00000009 c140ffe0 cfecc340 00000000
Call Trace: [<c011a5b6>] [<c010706b>] [<c010526b>] [<c01052af>] [<c0105798>]
Code: 0f 0b 8b 12 8b 02 0f 0d 00 81 fa 68 46 36 c0 75 d4 a1 68 46

>>EIP; c012d3ec <kmem_cache_create+2ec/340>   <=====
Trace; c011a5b6 <sys_waitpid+16/20>
Trace; c010706a <system_call+32/38>
Trace; c010526a <prepare_namespace+12a/150>
Trace; c01052ae <init+1e/150>
Trace; c0105798 <kernel_thread+28/40>
Code;  c012d3ec <kmem_cache_create+2ec/340>
00000000 <_EIP>:
Code;  c012d3ec <kmem_cache_create+2ec/340>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d3ee <kmem_cache_create+2ee/340>
   2:   8b 12                     mov    (%edx),%edx
Code;  c012d3f0 <kmem_cache_create+2f0/340>
   4:   8b 02                     mov    (%edx),%eax
Code;  c012d3f2 <kmem_cache_create+2f2/340>
   6:   0f 0d 00                  prefetch (%eax)
Code;  c012d3f4 <kmem_cache_create+2f4/340>
   9:   81 fa 68 46 36 c0         cmp    $0xc0364668,%edx
Code;  c012d3fa <kmem_cache_create+2fa/340>
   f:   75 d4                     jne    ffffffe5 <_EIP+0xffffffe5> c012d3d0 <kmem_cache_create+2d0/340>
Code;  c012d3fc <kmem_cache_create+2fc/340>
  11:   a1 68 46 00 00            mov    0x4668,%eax

Kernel panic: Attempted to kill init!   

-- 
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."	
