Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSDIQ3g>; Tue, 9 Apr 2002 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSDIQ3g>; Tue, 9 Apr 2002 12:29:36 -0400
Received: from stingr.net ([212.193.32.15]:6272 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S293458AbSDIQ3e>;
	Tue, 9 Apr 2002 12:29:34 -0400
Date: Tue, 9 Apr 2002 20:29:26 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre5-ac3
Message-ID: <20020409162926.GA523@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020407164439.GA5662@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Art Haas:
> Hi.
> 
> Once again the patch has been re-diffed for the latest -ac
> kernel. It's running on my machine now. Enjoy!

I'm sure you will glad to hear that your patch trashing the box it runs on
completely.

I'm now developing -stingr4* patchset against -pre5-ac3 and I am very angry.
I wasted about 6 hours today hinting this very obscure bug and didn't caught
it well :(

the kernel with radix tree pagecache patch under LTP fs tests load fails
generating the following oopses (below).

I'm sure Mr.Viro will glad to see it too because I am stuck and after 1st
pass cannot see the place in where I_FREEING can be removed from
inode->i_state tracing from iput to clear_inode thru reiserfs_delete_inode.

But maybe I'm just blind. Anyway, oopses included, ltp fs just finished its
second run on kernel without radix tree pagecache, and is happy.

anyone interested in viewing "exactly my kernel"
bk://linux-stingr.bkbits.net/unstable - you can clone existing marcelo tree
with clone -rv2.4.19-pre5 then bk pull changes from mine

ksymoops 2.4.5 on i686 2.4.19-pre5-ac3-s42.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5-ac3-s42/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
cpu: 0, clocks: 664766, slice: 221588
cpu: 1, clocks: 664766, slice: 221588
 /dev/scsi/host0/bus0/target2/lun0:<7>LDM:  DEBUG (ldm.c, 963): validate_partition_table: No MS-DOS partition found.
 /dev/scsi/host0/bus0/target4/lun0:<7>LDM:  DEBUG (ldm.c, 963): validate_partition_table: No MS-DOS partition found.
  Receiver lock-up bug exists -- enabling work-around.
kernel BUG at inode.c:515!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015241a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c57c08a0   ebx: ffffffff   ecx: c57c08c0   edx: c57c08c0
esi: c57c08a0   edi: c13a7000   ebp: c57c08a0   esp: c8227ed8
ds: 0018   es: 0018   ss: 0018
Process growfiles (pid: 8896, stackpage=c8227000)
Stack: c8227efc c13a7000 00000024 c57c090c c57c090c c8227efc c016f362 c57c08a0 
       c8226000 c023a3a4 00000007 00000024 00002ed9 c13a7000 00000000 c57c08a0 
       c13a7000 c57c08a0 c016f2b0 c02708a0 cbaa0ec0 c0152ed3 c57c08a0 cbaa0ec0 
Call Trace: [<c016f362>] [<c016f2b0>] [<c0152ed3>] [<c01510a6>] [<c01496da>] 
   [<c014834a>] [<c0149799>] [<c0115ef0>] [<c0108afb>] 
Code: 0f 0b 03 02 15 20 24 c0 8b 86 1c 01 00 00 a9 10 00 00 00 75 


>>EIP; c015241a <clear_inode+1a/100>   <=====

>>eax; c57c08a0 <_end+5494114/c585874>
>>ebx; ffffffff <END_OF_CODE+335dd3e0/????>
>>ecx; c57c08c0 <_end+5494134/c585874>
>>edx; c57c08c0 <_end+5494134/c585874>
>>esi; c57c08a0 <_end+5494114/c585874>
>>edi; c13a7000 <_end+107a874/c585874>
>>ebp; c57c08a0 <_end+5494114/c585874>
>>esp; c8227ed8 <_end+7efb74c/c585874>

Trace; c016f362 <reiserfs_delete_inode+b2/f0>
Trace; c016f2b0 <reiserfs_delete_inode+0/f0>
Trace; c0152ed3 <iput+143/240>
Trace; c01510a6 <d_delete+66/b0>
Trace; c01496da <vfs_unlink+1ba/1f0>
Trace; c014834a <lookup_hash+4a/d0>
Trace; c0149799 <sys_unlink+89/f0>
Trace; c0115ef0 <do_page_fault+0/45b>
Trace; c0108afb <system_call+33/38>

Code;  c015241a <clear_inode+1a/100>
00000000 <_EIP>:
Code;  c015241a <clear_inode+1a/100>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015241c <clear_inode+1c/100>
   2:   03 02                     add    (%edx),%eax
Code;  c015241e <clear_inode+1e/100>
   4:   15 20 24 c0 8b            adc    $0x8bc02420,%eax
Code;  c0152423 <clear_inode+23/100>
   9:   86 1c 01                  xchg   %bl,(%ecx,%eax,1)
Code;  c0152426 <clear_inode+26/100>
   c:   00 00                     add    %al,(%eax)
Code;  c0152428 <clear_inode+28/100>
   e:   a9 10 00 00 00            test   $0x10,%eax
Code;  c015242d <clear_inode+2d/100>
  13:   75 00                     jne    15 <_EIP+0x15> c015242f <clear_inode+2f/100>

kernel BUG at inode.c:515!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c015241a>]    Not tainted
EFLAGS: 00010286
eax: c157e2c0   ebx: ffffffff   ecx: c157e2e0   edx: c157e2e0
esi: c157e2c0   edi: c13a7000   ebp: c157e2c0   esp: c405be88
ds: 0018   es: 0018   ss: 0018
Process gzip (pid: 8901, stackpage=c405b000)
Stack: c405beac c13a7000 00000024 c157e32c c157e32c c405beac c016f362 c157e2c0 
       c405a000 c023a3a4 00000013 00000024 00002f12 c13a7000 00000000 c157e2c0 
       c13a7000 c157e2c0 c016f2b0 c02708a0 cbc29240 c0152ed3 c157e2c0 cbc29240 
Call Trace: [<c016f362>] [<c016f2b0>] [<c0152ed3>] [<c01505a7>] [<c01504dc>] 
   [<c013e0ee>] [<c013cbf1>] [<c011d5ad>] [<c011ddbe>] [<c01146ff>] [<c0108afb>] 
Code: 0f 0b 03 02 15 20 24 c0 8b 86 1c 01 00 00 a9 10 00 00 00 75 


>>EIP; c015241a <clear_inode+1a/100>   <=====

>>eax; c157e2c0 <_end+1251b34/c585874>
>>ebx; ffffffff <END_OF_CODE+335dd3e0/????>
>>ecx; c157e2e0 <_end+1251b54/c585874>
>>edx; c157e2e0 <_end+1251b54/c585874>
>>esi; c157e2c0 <_end+1251b34/c585874>
>>edi; c13a7000 <_end+107a874/c585874>
>>ebp; c157e2c0 <_end+1251b34/c585874>
>>esp; c405be88 <_end+3d2f6fc/c585874>

Trace; c016f362 <reiserfs_delete_inode+b2/f0>
Trace; c016f2b0 <reiserfs_delete_inode+0/f0>
Trace; c0152ed3 <iput+143/240>
Trace; c01505a7 <dput+e7/150>
Trace; c01504dc <dput+1c/150>
Trace; c013e0ee <fput+ce/f0>
Trace; c013cbf1 <filp_close+91/a0>
Trace; c011d5ad <put_files_struct+4d/d0>
Trace; c011ddbe <do_exit+11e/250>
Trace; c01146ff <smp_apic_timer_interrupt+ef/120>
Trace; c0108afb <system_call+33/38>

Code;  c015241a <clear_inode+1a/100>
00000000 <_EIP>:
Code;  c015241a <clear_inode+1a/100>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015241c <clear_inode+1c/100>
   2:   03 02                     add    (%edx),%eax
Code;  c015241e <clear_inode+1e/100>
   4:   15 20 24 c0 8b            adc    $0x8bc02420,%eax
Code;  c0152423 <clear_inode+23/100>
   9:   86 1c 01                  xchg   %bl,(%ecx,%eax,1)
Code;  c0152426 <clear_inode+26/100>
   c:   00 00                     add    %al,(%eax)
Code;  c0152428 <clear_inode+28/100>
   e:   a9 10 00 00 00            test   $0x10,%eax
Code;  c015242d <clear_inode+2d/100>
  13:   75 00                     jne    15 <_EIP+0x15> c015242f <clear_inode+2f/100>


1 warning issued.  Results may not be reliable.

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
