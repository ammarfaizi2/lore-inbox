Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRKRUwP>; Sun, 18 Nov 2001 15:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280056AbRKRUwG>; Sun, 18 Nov 2001 15:52:06 -0500
Received: from m116-mp1-cvx1c.lee.ntl.com ([62.252.236.116]:44672 "EHLO
	box.penguin.power") by vger.kernel.org with ESMTP
	id <S280051AbRKRUvy>; Sun, 18 Nov 2001 15:51:54 -0500
Date: Sun, 18 Nov 2001 20:50:39 +0000
From: Gavin Baker <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac7 ext3 OOPS
Message-ID: <20011118205039.A3208@box.penguin.power>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A seemingly random OOPS while using netscape. 2.4.13-ac7 with preempt patches on a RH7.2 laptop.

Nov 18 13:12:45 n-files kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000003
Nov 18 13:12:45 n-files kernel: c013a8eb
Nov 18 13:12:45 n-files kernel: *pde = 00000000
Nov 18 13:12:45 n-files kernel: Oops: 0000
Nov 18 13:12:45 n-files kernel: CPU:    0
Nov 18 13:12:45 n-files kernel: EIP:    0010:[get_hash_table+107/208]    Not tainted
Nov 18 13:12:45 n-files kernel: EIP:    0010:[<c013a8eb>]    Not tainted
Nov 18 13:12:45 n-files kernel: EFLAGS: 00010286
Nov 18 13:12:45 n-files kernel: eax: c1430000   ebx: ffffffff   ecx: 00000002   edx: 00003859
Nov 18 13:12:45 n-files kernel: esi: 000abdab   edi: 0000000e   ebp: 00000305   esp: c53e1d80
Nov 18 13:12:45 n-files kernel: ds: 0018   es: 0018   ss: 0018
Nov 18 13:12:45 n-files kernel: Process netscape-commun (pid: 1324, stackpage=c53e1000)
Nov 18 13:12:45 n-files kernel: Stack: 00003859 000abdab c62c2f70 c001c6a0 c62c2e40 c0164ddb 00000305 000abdab
Nov 18 13:12:45 n-files kernel:        00001000 00001000 00000305 00000711 c001c6a0 cf0e3190 00000000 00000000
Nov 18 13:12:45 n-files kernel:        00000000 00000000 c62c23c0 00000000 c0163b39 00000000 c53e0000 c001c6a0
Nov 18 13:12:45 n-files kernel: Call Trace: [ext3_clear_blocks+251/304] [ext3_getblk+201/768] [do_get_write_access+1573/1616] [ext3_free_data+243/352] [do_get_write_access+1573/1616]
Nov 18 13:12:45 n-files kernel: Call Trace: [<c0164ddb>] [<c0163b39>] [<c016bb55>] [<c0164f03>] [<c016bb55>]
Nov 18 13:12:45 n-files kernel:    [<c01652e6>] [<c016af44>] [<c016b03f>] [<c0162ce8>] [<c0162ea6>] [<c01508c4>]
Nov 18 13:12:45 n-files kernel:    [<c014e488>] [<c0146633>] [<c0144e5a>] [<c0146709>] [<c010723b>]
Nov 18 13:12:45 n-files kernel: Code: 39 73 04 75 f5 0f b7 43 08 3b 44 24 20 75 eb 66 39 6b 0c 75

>>EIP; c013a8eb <get_hash_table+6b/d0>   <=====
Trace; c0164ddb <ext3_clear_blocks+fb/130>
Trace; c0163b39 <ext3_getblk+c9/300>
Trace; c016bb55 <do_get_write_access+625/650>
Trace; c0164f03 <ext3_free_data+f3/160>
Trace; c016bb55 <do_get_write_access+625/650>
Trace; c01652e6 <ext3_truncate+136/3a0>
Trace; c016af44 <start_this_handle+124/160>
Trace; c016b03f <journal_start+bf/f0>
Trace; c0162ce8 <start_transaction+38/70>
Trace; c0162ea6 <ext3_delete_inode+106/1d0>
Trace; c01508c4 <iput+184/2b0>
Trace; c014e488 <d_delete+88/140>
Trace; c0146633 <vfs_unlink+233/270>
Trace; c0144e5a <lookup_hash+4a/100>
Trace; c0146709 <sys_unlink+99/100>
Trace; c010723b <system_call+33/38>
Code;  c013a8eb <get_hash_table+6b/d0>
00000000 <_EIP>:
Code;  c013a8eb <get_hash_table+6b/d0>   <=====
   0:   39 73 04                  cmp    %esi,0x4(%ebx)   <=====
Code;  c013a8ee <get_hash_table+6e/d0>
   3:   75 f5                     jne    fffffffa <_EIP+0xfffffffa> c013a8e5 <get_hash_table+65/d0>
Code;  c013a8f0 <get_hash_table+70/d0>
   5:   0f b7 43 08               movzwl 0x8(%ebx),%eax
Code;  c013a8f4 <get_hash_table+74/d0>
   9:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  c013a8f8 <get_hash_table+78/d0>
   d:   75 eb                     jne    fffffffa <_EIP+0xfffffffa> c013a8e5 <get_hash_table+65/d0>
Code;  c013a8fa <get_hash_table+7a/d0>
   f:   66 39 6b 0c               cmp    %bp,0xc(%ebx)
Code;  c013a8fe <get_hash_table+7e/d0>
  13:   75 00                     jne    15 <_EIP+0x15> c013a900 <get_hash_table+80/d0>


00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Flags: bus master, fast devsel, latency 16
        I/O ports at ff00 [size=16]
						

Gavin Baker
