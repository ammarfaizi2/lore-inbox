Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbSJSJ0S>; Sat, 19 Oct 2002 05:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbSJSJ0S>; Sat, 19 Oct 2002 05:26:18 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:30730 "EHLO vlad")
	by vger.kernel.org with ESMTP id <S265571AbSJSJ0P>;
	Sat, 19 Oct 2002 05:26:15 -0400
Date: Sat, 19 Oct 2002 10:33:18 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: andrea@suse.de, riel@connectiva.com.br
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: kswapd oops in 2.4.19
Message-ID: <20021019093318.GA28599@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>, andrea@suse.de,
	riel@connectiva.com.br, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.4i
x-gpg-fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
x-gpg-key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I hope I've sent this to the right people. Apologies if I haven't.

   I'm getting oopsen in kswapd:

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

c014248a
Oops: 0000
CPU:    0
EIP:    0010:[iput+46/432]    Not tainted
EFLAGS: 00010206
eax: 00000000   ebx: c67d8800   ecx: c67d8810   edx: c67d8810
esi: 411a5200   edi: 00000000   ebp: c7f9ff3c   esp: c7f9ff30
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c7f9f000)
Stack: c5773c78 c5773c60 c67d8800 c7f9ff54 c01405e6 c67d8800 00000019 000001d0 
       00000019 c7f9ff60 c01408bc 0000069f c7f9ff84 c012b0b1 00000003 000001d0 
       00000003 000001d0 c0287d74 00000003 c0287d74 c7f9ff9c c012b101 00000019 
Call Trace:    [prune_dcache+198/316] [shrink_dcache_memory+28/52] [shrink_caches+105/132] [try_to_free_pages+53/88] [kswapd_balance_pgdat+76/160]
Code: 8b 46 20 85 c0 74 02 89 c7 85 ff 74 0d 8b 47 10 85 c0 74 06 
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


   The symbol information ksymoops uses for default _is_ the correct
info. I'm running a 2.4.19 kernel with the EVMS 1.2.0 patch, although
I have observed this same behaviour on 2.4.19 without the EVMS patch,
and on earlier 2.4.x kernels.

   After the oops, kswapd shows up in 'ps ax' as a zombie process,
although the operation of the machine doesn't appear to be affected.

   The problem seems to happen most often during periods of high disk
activity (creating CD images or dong network backups with amanda);
this most recent event however was doing neither. It usually takes a
couple of days of uptime to trigger the oops (although I've seen it
happen in as little as 10 minutes after a reboot, or as much as a
couple of weeks).

   If there is anything more I can do to help fix this problem, please
let me know.

   Thanks,
   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
 PGP: 1024D/1C335860 from wwwkeys.eu.pgp.net or www.carfax.nildram.co.uk
         --- Nothing right in my left brain. Nothing left in ---         
                             my right brain.                             

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9sSbessJ7whwzWGARAm2dAJ4m/Ex0foTBmMESTVZ0txTN6Cg7IACgkSmz
txpXlAlqYPn5+imsrIJ5NO8=
=D8w3
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
