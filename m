Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278092AbRJWRB6>; Tue, 23 Oct 2001 13:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278098AbRJWRBt>; Tue, 23 Oct 2001 13:01:49 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:21122 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S278092AbRJWRBe>; Tue, 23 Oct 2001 13:01:34 -0400
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.4.12-ac3 with Rik's 2.4.12-ac3-vmpatch
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 23 Oct 2001 19:01:33 +0200
Message-ID: <qww6696e1ea.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a fairly old P133 48 MB RAM, that serves files over nfs from
large (40 GB) ext3 partition. If think it happend when the diskspace ran
out in a cron job. This box has a history of oopses with all kernels so
it could be hardware, although with ext3 it does not take so long to
recover, thank you.

                                                Regards, Petr

ksymoops 2.4.1 on i586 2.4.12-ac3-vm.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac3-vm/ (default)
     -m /boot/System.map-2.4.12-ac3-vm (default)


Intel Pentium with F0 0F bug - workaround enabled.
Unable to handle kernel NULL pointer dereference at virtual address 00000d24
c012069e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012069e>]    Tainted: P                                         Using defaults from ksymoops -t elf32-i386 -a i386                              EFLAGS: 00010287
eax: 00000d20   ebx: c22b2104   ecx: c021d63c   edx: 3b8d0845                   esi: c22ba040   edi: c22ba0fc   ebp: 00000000   esp: c11e9f5c                   ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c11e9000)
Stack: 00000001 c22ba040 c1197c60 c1197c00 c013f4d0 c22ba0fc c0bd6588 c0bd6580
       c021e164 c11e9fa8 00000000 c013fbad 0000014c 000000c0 c11e8239 00000001
       00000631 c11e9fa0 c11e9fa0 0008e000 c013fbdd fffff9cf c01277df 00000000
Call Trace: [<c013f4d0>] [<c013fbad>] [<c013fbdd>] [<c01277df>] [<c012786b>]
   [<c0105480>]
Code: 89 50 04 89 02 8b 47 10 89 58 04 89 03 8d 47 10 89 43 04 89

>>EIP; c012069e <filemap_fdatasync+1a/b8>   <=====
Trace; c013f4d0 <try_to_sync_unused_inodes+c0/1ac>
Trace; c013fbad <prune_icache+101/110>
Trace; c013fbdd <shrink_icache_memory+21/30>
Trace; c01277df <do_try_to_free_pages+23/50>
Trace; c012786b <kswapd+5f/cc>
Trace; c0105480 <kernel_thread+28/38>
Code;  c012069e <filemap_fdatasync+1a/b8>
00000000 <_EIP>:
Code;  c012069e <filemap_fdatasync+1a/b8>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c01206a1 <filemap_fdatasync+1d/b8>
   3:   89 02                     mov    %eax,(%edx)
Code;  c01206a3 <filemap_fdatasync+1f/b8>
   5:   8b 47 10                  mov    0x10(%edi),%eax
Code;  c01206a6 <filemap_fdatasync+22/b8>
   8:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c01206a9 <filemap_fdatasync+25/b8>
   b:   89 03                     mov    %eax,(%ebx)
Code;  c01206ab <filemap_fdatasync+27/b8>
   d:   8d 47 10                  lea    0x10(%edi),%eax
Code;  c01206ae <filemap_fdatasync+2a/b8>
  10:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c01206b1 <filemap_fdatasync+2d/b8>
  13:   89 00                     mov    %eax,(%eax)

$  /sbin/lsmod
Module                  Size  Used by
nls_iso8859-1           2880   0 (autoclean)
isofs                  18368   0 (autoclean)
loop                    8528   0 (autoclean)
nfs                    73888   2 (autoclean)
nfsd                   67840   8 (autoclean)
lockd                  49072   1 (autoclean) [nfs nfsd]
sunrpc                 60896   1 (autoclean) [nfs nfsd lockd]
autofs                 10416   4 (autoclean)
rtc                     5728   0 (autoclean)
3c509                   7424   1 (autoclean)
isa-pnp                28688   0 (autoclean) [3c509]
ide-scsi                7968   0
scsi_mod               90240   1 [ide-scsi]
unix                   14912  12 (autoclean)

-- 
Cleanliness becomes more important when godliness is unlikely.
		-- P.J. O'Rourke
