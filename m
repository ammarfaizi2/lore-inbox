Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSJ1KRs>; Mon, 28 Oct 2002 05:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJ1KRs>; Mon, 28 Oct 2002 05:17:48 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:45835 "EHLO vlad")
	by vger.kernel.org with ESMTP id <S262908AbSJ1KRg>;
	Mon, 28 Oct 2002 05:17:36 -0500
Date: Mon, 28 Oct 2002 10:24:39 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Oops in kswapd, 2.4.19 kernel and before
Message-ID: <20021028102439.GB13490@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrea Arcangeli <andrea@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
User-Agent: Mutt/1.4i
x-gpg-fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
x-gpg-key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Hi,

   This is the third time I've tried to report this problem, with no
response so far. One last try. If you're not interested, please tell
me and I won't bother you any more...

   I'm getting regular oopsen in kswapd on my 2.4.19 kernel. They
generally appear to happen while running Amanda (a tape backup
utility) -- although I've not identified exactly which component of
Amanda triggers it. The machine is lightly stressed with regard to
memory usage, although I suspect much of it is (currently) swapped out
(I'm running postgres and apache, but they don't get much use at the
moment):

hrm@vlad:hrm $ free
             total       used       free     shared    buffers     cached
Mem:        127240     125264       1976          0       2576      35020
-/+ buffers/cache:      87668      39572
Swap:       262132      53240     208892

   After the oops, my kswapd is zombied:

hrm@vlad:hrm $ ps ax | grep kswapd
    5 ?        Z      0:11 [kswapd <defunct>]

although the machine does appear to continue to function without
problems. I have seen precisely similar effects on most of the
previous 2.4.x kernels.

   Decoded oopsen are below (they _are_ decoded with the right system
maps, despite ksymoops's concerns). If there's anything else that's
needed in order to track this down, please let me know.

   Thanks,
   Hugo.

-----

ksymoops 2.4.6 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 24 06:31:14 vlad kernel: c014248a
Oct 24 06:31:14 vlad kernel: Oops: 0000
Oct 24 06:31:14 vlad kernel: CPU:    0
Oct 24 06:31:14 vlad kernel: EIP:    0010:[iput+46/432]    Not tainted
Oct 24 06:31:14 vlad kernel: EFLAGS: 00010206
Oct 24 06:31:14 vlad kernel: eax: 00000000   ebx: c67d8800   ecx: c67d8810   edx: c67d8810
Oct 24 06:31:14 vlad kernel: esi: 476f7200   edi: 00000000   ebp: c7f9ff3c   esp: c7f9ff30
Oct 24 06:31:14 vlad kernel: ds: 0018   es: 0018   ss: 0018
Oct 24 06:31:14 vlad kernel: Process kswapd (pid: 5, stackpage=c7f9f000)
Oct 24 06:31:14 vlad kernel: Stack: c088ef78 c088ef60 c67d8800 c7f9ff54 c01405e6 c67d8800 00000011 000001d0 
Oct 24 06:31:14 vlad kernel:        00000011 c7f9ff60 c01408bc 0000172d c7f9ff84 c012b0b1 00000002 000001d0 
Oct 24 06:31:14 vlad kernel:        00000002 000001d0 c0287d74 00000002 c0287d74 c7f9ff9c c012b101 00000011 
Oct 24 06:31:14 vlad kernel: Call Trace:    [prune_dcache+198/316] [shrink_dcache_memory+28/52] [shrink_caches+105/132] [try_to_free_pages+53/88] [kswapd_balance_pgdat+76/160]
Oct 24 06:31:14 vlad kernel: Code: 8b 46 20 85 c0 74 02 89 c7 85 ff 74 0d 8b 47 10 85 c0 74 06 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c67d8800 <_end+64d5fc8/852f828>
>>ecx; c67d8810 <_end+64d5fd8/852f828>
>>edx; c67d8810 <_end+64d5fd8/852f828>
>>ebp; c7f9ff3c <_end+7c9d704/852f828>
>>esp; c7f9ff30 <_end+7c9d6f8/852f828>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 20                  mov    0x20(%esi),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 02                     je     9 <_EIP+0x9>
Code;  00000007 Before first symbol
   7:   89 c7                     mov    %eax,%edi
Code;  00000009 Before first symbol
   9:   85 ff                     test   %edi,%edi
Code;  0000000b Before first symbol
   b:   74 0d                     je     1a <_EIP+0x1a>
Code;  0000000d Before first symbol
   d:   8b 47 10                  mov    0x10(%edi),%eax
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   74 06                     je     1a <_EIP+0x1a>


1 warning issued.  Results may not be reliable.

-----

ksymoops 2.4.6 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 27 01:46:00 vlad kernel: Unable to handle kernel paging request at virtual  address 47804220
Oct 27 01:46:00 vlad kernel: c014248a
Oct 27 01:46:00 vlad kernel: *pde = 00000000
Oct 27 01:46:00 vlad kernel: Oops: 0000
Oct 27 01:46:00 vlad kernel: CPU:    0
Oct 27 01:46:00 vlad kernel: EIP:    0010:[iput+46/432]    Not tainted
Oct 27 01:46:00 vlad kernel: EFLAGS: 00010206
Oct 27 01:46:00 vlad kernel: eax: 00000000   ebx: c67c8800   ecx: c67c8810   edx: c67c8810
Oct 27 01:46:00 vlad kernel: esi: 47804200   edi: 00000000   ebp: c7f9ff3c   esp: c7f9ff30
Oct 27 01:46:00 vlad kernel: ds: 0018   es: 0018   ss: 0018
Oct 27 01:46:00 vlad kernel: Process kswapd (pid: 5, stackpage=c7f9f000)
Oct 27 01:46:00 vlad kernel: Stack: c6a93d38 c6a93d20 c67c8800 c7f9ff54 c01405e6c67c8800 00000005 000001d0
Oct 27 01:46:00 vlad kernel:        00000020 c7f9ff60 c01408bc 000009e1 c7f9ff84c012b0b1 00000006 000001d0
Oct 27 01:46:00 vlad kernel:        00000006 000001d0 c0287d74 00000006 c0287d74c7f9ff9c c012b101 00000020
Oct 27 01:46:00 vlad kernel: Call Trace:    [prune_dcache+198/316] [shrink_dcache_memory+28/52] [shrink_caches+105/132] [try_to_free_pages+53/88] [kswapd_balance_pgdat+76/160]
Oct 27 01:46:00 vlad kernel: Code: 8b 46 20 85 c0 74 02 89 c7 85 ff 74 0d 8b 47 10 85 c0 74 06
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c67c8800 <_end+64c5fc8/852f828>
>>ecx; c67c8810 <_end+64c5fd8/852f828>
>>edx; c67c8810 <_end+64c5fd8/852f828>
>>ebp; c7f9ff3c <_end+7c9d704/852f828>
>>esp; c7f9ff30 <_end+7c9d6f8/852f828>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 20                  mov    0x20(%esi),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 02                     je     9 <_EIP+0x9>
Code;  00000007 Before first symbol
   7:   89 c7                     mov    %eax,%edi
Code;  00000009 Before first symbol
   9:   85 ff                     test   %edi,%edi
Code;  0000000b Before first symbol
   b:   74 0d                     je     1a <_EIP+0x1a>
Code;  0000000d Before first symbol
   d:   8b 47 10                  mov    0x10(%edi),%eax
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   74 06                     je     1a <_EIP+0x1a>


1 warning issued.  Results may not be reliable.

-----

ksymoops 2.4.6 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 28 08:04:49 vlad kernel: Unable to handle kernel paging request at virtual address 47880220
Oct 28 08:04:49 vlad kernel: c0141c6a
Oct 28 08:04:49 vlad kernel: *pde = 00000000
Oct 28 08:04:49 vlad kernel: Oops: 0000
Oct 28 08:04:49 vlad kernel: CPU:    0
Oct 28 08:04:49 vlad kernel: EIP:    0010:[clear_inode+86/168]    Not tainted
Oct 28 08:04:49 vlad kernel: EFLAGS: 00010206
Oct 28 08:04:49 vlad kernel: eax: 47880200   ebx: c67c8800   ecx: c67c8808   edx: c67c8818
Oct 28 08:04:49 vlad kernel: esi: c7f9ff44   edi: c73e8a28   ebp: c7f9ff14   esp: c7f9ff10
Oct 28 08:04:49 vlad kernel: ds: 0018   es: 0018   ss: 0018
Oct 28 08:04:49 vlad kernel: Process kswapd (pid: 5, stackpage=c7f9f000)
Oct 28 08:04:49 vlad kernel: Stack: c67c8800 c7f9ff28 c0141cff c67c8800 c5829648 c5829640 c7f9ff4c c0141f24 
Oct 28 08:04:49 vlad kernel:        c7f9ff44 0000000c 000001d0 00000020 000005df c02d3428 c36d5de8 c7f9ff58 
Oct 28 08:04:49 vlad kernel:        c0141f5c 00000000 c7f9ff84 c012b0bb 00000006 000001d0 00000006 000001d0 
Oct 28 08:04:49 vlad kernel: Call Trace:    [dispose_list+67/96] [prune_icache+164/192] [shrink_icache_memory+28/52] [shrink_caches+115/132] [try_to_free_pages+53/88]
Oct 28 08:04:49 vlad kernel: Code: 8b 40 20 85 c0 74 0f 8b 40 30 85 c0 74 08 53 ff d0 83 c4 04 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c67c8800 <_end+64c5fc8/852f828>
>>ecx; c67c8808 <_end+64c5fd0/852f828>
>>edx; c67c8818 <_end+64c5fe0/852f828>
>>esi; c7f9ff44 <_end+7c9d70c/852f828>
>>edi; c73e8a28 <_end+70e61f0/852f828>
>>ebp; c7f9ff14 <_end+7c9d6dc/852f828>
>>esp; c7f9ff10 <_end+7c9d6d8/852f828>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 0f                     je     16 <_EIP+0x16>
Code;  00000007 Before first symbol
   7:   8b 40 30                  mov    0x30(%eax),%eax
Code;  0000000a Before first symbol
   a:   85 c0                     test   %eax,%eax
Code;  0000000c Before first symbol
   c:   74 08                     je     16 <_EIP+0x16>
Code;  0000000e Before first symbol
   e:   53                        push   %ebx
Code;  0000000f Before first symbol
   f:   ff d0                     call   *%eax
Code;  00000011 Before first symbol
  11:   83 c4 04                  add    $0x4,%esp


1 warning issued.  Results may not be reliable.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
 PGP: 1024D/1C335860 from wwwkeys.eu.pgp.net or www.carfax.nildram.co.uk
   --- Anyone who claims their cryptographic protocol is secure is ---   
         either a genius or a fool.  Given the genius/fool ratio         
                 for our species,  the odds aren't good.                 

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9vRBnssJ7whwzWGARAgyfAJ49IvBWsvGZUYVKGpxF2CdAtK3PnACbBugl
+jGRCfY6AZ9dsw3B2cXBVmI=
=gZEK
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
