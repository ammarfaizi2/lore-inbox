Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129470AbQKMRMz>; Mon, 13 Nov 2000 12:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbQKMRMp>; Mon, 13 Nov 2000 12:12:45 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:21846
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129470AbQKMRMh>; Mon, 13 Nov 2000 12:12:37 -0500
Date: Mon, 13 Nov 2000 18:04:49 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.2.17, not in 2.2.14-5
Message-ID: <20001113180449.A652@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When running 'tar cvIf <file> /' or 'tar cvzf <file> /' (but sometimes not
with 'plain' tar, i.e., without compression) I get an oops after some
time. This is reproducible. The oops below is from a 'tar cvIf' run. 

I get this also with 2.2.17pre10 (which was what I was running before
encountering this) but not with the stock RH 6.2 kernel (2.2.14-5.0).
Unless I get other suggestions I'm going to try with the latest 2.2.18pre
and 2.2.16 tomorrow.

Since I had just experienced RAM problems on another machine I put in
some new RAM after testing it with memtest86, but that did not solve
the problem (neither did the old RAM show any errors when I memtested
it afterwards).

I'm not sure about the warning. Is it fatal? And what should I do to get
rid of it?

Comments appreciated and info willingly given :)

ksymoops 0.7c on i586 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Nov 13 18:15:05 firewall kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004 
Nov 13 18:15:05 firewall kernel: current->tss.cr3 = 07259000, %cr3 = 07259000 
Nov 13 18:15:05 firewall kernel: *pde = 00000000 
Nov 13 18:15:05 firewall kernel: Oops: 0002 
Nov 13 18:15:05 firewall kernel: CPU:    0 
Nov 13 18:15:05 firewall kernel: EIP:    0010:[<c0121b43>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 13 18:15:05 firewall kernel: EFLAGS: 00010087 
Nov 13 18:15:05 firewall kernel: eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000 
Nov 13 18:15:05 firewall kernel: esi: c02009f0   edi: 00001000   ebp: c022a790   esp: c725bd4c 
Nov 13 18:15:05 firewall kernel: ds: 0018   es: 0018   ss: 0018 
Nov 13 18:15:05 firewall kernel: Process bzip2 (pid: 1327, process nr: 23, stackpage=c725b000) 
Nov 13 18:15:05 firewall kernel: Stack: 00001000 00000306 00000001 0000000a 00000202 00000000 00000306 000016cf  
Nov 13 18:15:05 firewall kernel:        00001000 c0126ff4 00000003 00000000 00001000 00000306 00000002 c10fd3c0  
Nov 13 18:15:05 firewall kernel:        c06c1000 c01261e8 00001000 000016cf 00001000 00000306 00000002 c10fd3c0  
Nov 13 18:15:05 firewall kernel: Call Trace: [<c0126ff4>] [<c01261e8>] [<c01263c5>] [<c0125f01>] [<c013f74c>] [<c013fdc2>] [<c014011b>]  
Nov 13 18:15:05 firewall kernel:        [<c01264ff>] [<c013e23e>] [<c011130e>] [<c011ae20>] [<c011157e>] [<c0111573>] [<c010a103>] [<c01249cf>]  
Nov 13 18:15:05 firewall kernel:        [<c012483c>] [<c010923d>] [<c0109104>]  
Nov 13 18:15:05 firewall kernel: Code: 89 70 04 89 e8 2b 05 ec da 1d c0 8d 04 40 89 c2 c1 e2 04 01  

>>EIP; c0121b43 <__get_free_pages+1eb/2b8>   <=====
Trace; c0126ff4 <grow_buffers+40/f8>
Trace; c01261e8 <refill_freelist+10/44>
Trace; c01263c5 <getblk+139/164>
Trace; c0125f01 <get_hash_table+1d/2c>
Trace; c013f74c <ext2_alloc_block+74/178>
Trace; c013fdc2 <block_getblk+156/2a0>
Trace; c014011b <ext2_getblk+20f/21c>
Trace; c01264ff <__brelse+13/64>
Trace; c013e23e <ext2_file_write+226/5bc>
Trace; c011130e <update_wall_time+12/48>
Trace; c011ae20 <handle_mm_fault+c8/13c>
Trace; c011157e <timer_bh+d2/3a0>
Trace; c0111573 <timer_bh+c7/3a0>
Trace; c010a103 <do_8259A_IRQ+8f/9c>
Trace; c01249cf <sys_write+c3/e8>
Trace; c012483c <sys_read+0/d0>
Trace; c010923d <error_code+2d/40>
Trace; c0109104 <system_call+34/40>
Code;  c0121b43 <__get_free_pages+1eb/2b8>
00000000 <_EIP>:
Code;  c0121b43 <__get_free_pages+1eb/2b8>   <=====
   0:   89 70 04                  mov    %esi,0x4(%eax)   <=====
Code;  c0121b46 <__get_free_pages+1ee/2b8>
   3:   89 e8                     mov    %ebp,%eax
Code;  c0121b48 <__get_free_pages+1f0/2b8>
   5:   2b 05 ec da 1d c0         sub    0xc01ddaec,%eax
Code;  c0121b4e <__get_free_pages+1f6/2b8>
   b:   8d 04 40                  lea    (%eax,%eax,2),%eax
Code;  c0121b51 <__get_free_pages+1f9/2b8>
   e:   89 c2                     mov    %eax,%edx
Code;  c0121b53 <__get_free_pages+1fb/2b8>
  10:   c1 e2 04                  shl    $0x4,%edx
Code;  c0121b56 <__get_free_pages+1fe/2b8>
  13:   01 00                     add    %eax,(%eax)


1 warning issued.  Results may not be reliable.

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Without censorship, things can get terribly confused in the
public mind. -General William Westmoreland, during the war in Viet Nam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
