Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263255AbSJCL2f>; Thu, 3 Oct 2002 07:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSJCL2f>; Thu, 3 Oct 2002 07:28:35 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:57349 "EHLO vlad")
	by vger.kernel.org with ESMTP id <S263255AbSJCL2d>;
	Thu, 3 Oct 2002 07:28:33 -0400
Date: Thu, 3 Oct 2002 12:35:27 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Oops in kswapd, kernel 2.4.18
Message-ID: <20021003113526.GA8877@carfax.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.4i
x-gpg-fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
x-gpg-key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Hi,

   I'm getting an oops in kswapd. It seems generally to happen in the
first few days after a reboot -- sometimes almost immediately (in the
case of the one reported below, only a few minutes), sometimes it
takes a while. I can't be certain without more investigation, but I
think it happens when there's a lot of disk activity.

   After the oops, kswapd becomes a zombie process, but appears still
to be functional -- I don't notice any loss of function or performance
on the machine (K6/2-500, 128Mb RAM).

   I attach a ksymoops'd chunk of log file. Is there any other
information I need to supply to help track this problem down?

   Hugo.


vlad:/var/log# grep 19:52:34 messages | ksymoops
ksymoops 2.4.6 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct  2 19:52:34 vlad kernel: c013ebf6
Oct  2 19:52:34 vlad kernel: Oops: 0000
Oct  2 19:52:34 vlad kernel: CPU:    0
Oct  2 19:52:34 vlad kernel: EIP:    0010:[iput+38/408]    Not tainted
Oct  2 19:52:34 vlad kernel: EFLAGS: 00010206
Oct  2 19:52:34 vlad kernel: eax: 00000000   ebx: c67c8800   ecx: c67c8810   edx: c67c8810
Oct  2 19:52:34 vlad kernel: esi: 47b68600   edi: 00000000   ebp: 00000543   esp: c7fbff4c
Oct  2 19:52:34 vlad kernel: ds: 0018   es: 0018   ss: 0018
Oct  2 19:52:34 vlad kernel: Process kswapd (pid: 5, stackpage=c7fbf000)
Oct  2 19:52:34 vlad kernel: Stack: c482bd38 c482bd20 c67c8800 c013ce3d c67c8800 0000001c 000001d0 00000020 
Oct  2 19:52:34 vlad kernel:        00000006 c013d0fb 00000e27 c0128651 00000006 000001d0 00000006 000001d0 
Oct  2 19:52:34 vlad kernel:        c0238888 00000000 c0238888 c012869c 00000020 c0238888 00000001 c7fbe000 
Oct  2 19:52:34 vlad kernel: Call Trace: [prune_dcache+189/296] [shrink_dcache_memory+27/52] [shrink_caches+109/132] [try_to_free_pages+52/84] [kswapd_balance_pgdat+67/140] 
Oct  2 19:52:34 vlad kernel: Code: 8b 46 20 85 c0 74 02 89 c7 85 ff 74 0d 8b 47 10 85 c0 74 06 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c67c8800 <_end+6519528/859cd88>
>>ecx; c67c8810 <_end+6519538/859cd88>
>>edx; c67c8810 <_end+6519538/859cd88>
>>esp; c7fbff4c <_end+7d10c74/859cd88>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 20                  mov    0x20(%esi),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 02                     je     9 <_EIP+0x9> 00000009 Before first symbol
Code;  00000007 Before first symbol
   7:   89 c7                     mov    %eax,%edi
Code;  00000009 Before first symbol
   9:   85 ff                     test   %edi,%edi
Code;  0000000b Before first symbol
   b:   74 0d                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  0000000d Before first symbol
   d:   8b 47 10                  mov    0x10(%edi),%eax
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   74 06                     je     1a <_EIP+0x1a> 0000001a Before first symbol


1 warning issued.  Results may not be reliable.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
 PGP: 1024D/1C335860 from wwwkeys.eu.pgp.net or www.carfax.nildram.co.uk
     --- For months now, we have been making triumphant retreats ---     
               before a demoralised enemy who is advancing               
                           in utter disorder.                            

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9nCt+ssJ7whwzWGARAkM0AJ9MpkXphYJofZIPC8okVKOCHhAHBACgnpet
R81mD6ITH1hq7n4Y0UQK3mg=
=d6kH
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
