Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbTCRAI2>; Mon, 17 Mar 2003 19:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCRAI2>; Mon, 17 Mar 2003 19:08:28 -0500
Received: from dsl-213-023-019-032.arcor-ip.net ([213.23.19.32]:45184 "EHLO
	spot.lan") by vger.kernel.org with ESMTP id <S262048AbTCRAIZ> convert rfc822-to-8bit;
	Mon, 17 Mar 2003 19:08:25 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: oops 2.4.20 pppoe
Date: Tue, 18 Mar 2003 01:17:56 +0100
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303180118.03966.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Using pppoe from kernel, interface connections eth0 <-> ppp0.
I can reproduce this by changing mtu of eth0 and doing 'skill -1 pppd'. I 
recovered this only by accident while fiddling with the mtu. It's normally 
not what you should do I think, but it should not oops I guess. :)

The kernel is running with freeswan 1.99. The oops was decoded on the very 
same kernel. I don't know why it complains about "mismatch on symbol zeroes" 
in ipsec.o.


ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol zeroes  , ipsec says d08c9dc0, 
/lib/modules/2.4.20/kernel/net/ipsec/ipsec.o says d08c9cc0.  Ignoring 
/lib/modules/2.4.20/kernel/net/ipsec/ipsec.o entry
Unable to handle kernel NULL pointer dereference at virtual address 000000f0
c01b6fab
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01b6fab>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c0354bc8   ebx: cb777140   ecx: 00000000   edx: 00000000
esi: cb355f14   edi: 0000001e   ebp: cf6f1740   esp: cb355ed8
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 443, stackpage=cb355000)
Stack: cb336a20 cb355f14 0000001e bffffd7c 00000000 0807f2e0 c0225ceb cb336a20 
       cb355f14 0000001e 00000002 00000002 00000001 bffffe28 00000000 00000018 
       00000000 71399000 74650600 00003068 00000000 00000000 cb430000 00000246 
Call Trace:    [<c0225ceb>] [<c011e314>] [<c011f36c>] [<c011f7c8>] 
[<c0226670>]
  [<c0106d33>]
Code: ff 8a f0 00 00 00 0f 94 c0 84 c0 74 09 52 e8 72 5a 07 00 83 


>>EIP; c01b6fab <pppoe_connect+eb/280>   <=====

>>eax; c0354bc8 <irq_stat+8/40>
>>ebx; cb777140 <_end+b3f5840/104ff700>
>>esi; cb355f14 <_end+afd4614/104ff700>
>>ebp; cf6f1740 <_end+f36fe40/104ff700>
>>esp; cb355ed8 <_end+afd45d8/104ff700>

Trace; c0225ceb <sys_connect+5b/80>
Trace; c011e314 <rm_sig_from_queue+14/20>
Trace; c011f36c <do_sigaction+9c/e0>
Trace; c011f7c8 <sys_rt_sigaction+98/140>
Trace; c0226670 <sys_socketcall+90/200>
Trace; c0106d33 <system_call+33/38>

Code;  c01b6fab <pppoe_connect+eb/280>
00000000 <_EIP>:
Code;  c01b6fab <pppoe_connect+eb/280>   <=====
   0:   ff 8a f0 00 00 00         decl   0xf0(%edx)   <=====
Code;  c01b6fb1 <pppoe_connect+f1/280>
   6:   0f 94 c0                  sete   %al
Code;  c01b6fb4 <pppoe_connect+f4/280>
   9:   84 c0                     test   %al,%al
Code;  c01b6fb6 <pppoe_connect+f6/280>
   b:   74 09                     je     16 <_EIP+0x16> c01b6fc1 
<pppoe_connect+101/280>
Code;  c01b6fb8 <pppoe_connect+f8/280>
   d:   52                        push   %edx
Code;  c01b6fb9 <pppoe_connect+f9/280>
   e:   e8 72 5a 07 00            call   75a85 <_EIP+0x75a85> c022ca30 
<netdev_finish_unregister+0/a0>
Code;  c01b6fbe <pppoe_connect+fe/280>
  13:   83 00 00                  addl   $0x0,(%eax)


2 warnings issued.  Results may not be reliable.



- -- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx(pro).net)>
http://kiza.kcore.de/    <--    homepage
PGP-key      -->    /pgpkey.shtml
http://kiza.kcore.de/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+dmW7OpifZVYdT9IRArecAJwOwP61zwCk0x+dbomlHard0o0cnACg/cM2
b+pu0ubXFFDJh92tySTD42s=
=dFEi
-----END PGP SIGNATURE-----

