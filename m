Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267723AbTACXte>; Fri, 3 Jan 2003 18:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267724AbTACXte>; Fri, 3 Jan 2003 18:49:34 -0500
Received: from CPE-203-51-219-193.qld.bigpond.net.au ([203.51.219.193]:26605
	"EHLO nova.hn.org") by vger.kernel.org with ESMTP
	id <S267723AbTACXt3>; Fri, 3 Jan 2003 18:49:29 -0500
Date: Sat, 4 Jan 2003 09:56:35 +1000
From: Alexandra Walford <chroma@delusion.de>
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org, mostrows@styx.uwaterloo.ca
Subject: [OOPS] 2.4.20 PPPoE
Message-Id: <20030104095635.0397fe62.chroma@delusion.de>
X-Mailer: Sylpheed version 0.8.8claws42 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Request-PGP: http://nova.hn.org/files/key.asc
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Hzm._TH1PCx/m6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Hzm._TH1PCx/m6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I've had the following oops, using a monolithic 2.4.20 kernel (no
modules loaded) and pppd-2.4.1.pppoe.  At the time, pppd was
exiting with "sendto returned: Network is down"; please see the
bottom of this mail for the syslog messages immediately preceding
the oops.

Would you please CC me on any discussion, as I'm not subscribed
to the list.

---------------------------------------------------------------------------------

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 000000f0
c01d32db
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01d32db>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c03429c8   ebx: cf1b3cc0   ecx: 00000000   edx: 00000000
esi: c50c3f14   edi: 0000001e   ebp: c5acc420   esp: c50c3ed8
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 18012, stackpage=c50c3000)
Stack: c34dbea0 c50c3f14 0000001e bffffd9c 00000000 0807e638 c0229ef7 c34dbea0 
       c50c3f14 0000001e 00000002 00000002 00000001 bffffe48 00000000 00000018 
       00000000 ac4b0300 74650e90 00003068 00000000 00000000 00000000 c0127429 
Call Trace:    [<c0229ef7>] [<c0127429>] [<c0151997>] [<c022a834>] [<c0106bc7>]
Code: ff 8a f0 00 00 00 0f 94 c0 84 c0 74 09 52 e8 d6 db 05 00 83


>>EIP; c01d32db <pppoe_connect+eb/278>   <=====

>>eax; c03429c8 <irq_stat+8/20>
>>ebx; cf1b3cc0 <END_OF_CODE+ee49d28/????>
>>esi; c50c3f14 <END_OF_CODE+4d59f7c/????>
>>ebp; c5acc420 <END_OF_CODE+5762488/????>
>>esp; c50c3ed8 <END_OF_CODE+4d59f40/????>

Trace; c0229ef7 <sys_connect+5b/78>
Trace; c0127429 <generic_file_write+541/708>
Trace; c0151997 <ext3_file_write+23/bc>
Trace; c022a834 <sys_socketcall+8c/200>
Trace; c0106bc7 <system_call+33/38>

Code;  c01d32db <pppoe_connect+eb/278>
00000000 <_EIP>:
Code;  c01d32db <pppoe_connect+eb/278>   <=====
   0:   ff 8a f0 00 00 00         decl   0xf0(%edx)   <=====
Code;  c01d32e1 <pppoe_connect+f1/278>
   6:   0f 94 c0                  sete   %al
Code;  c01d32e4 <pppoe_connect+f4/278>
   9:   84 c0                     test   %al,%al
Code;  c01d32e6 <pppoe_connect+f6/278>
   b:   74 09                     je     16 <_EIP+0x16> c01d32f1 <pppoe_connect+101/278>
Code;  c01d32e8 <pppoe_connect+f8/278>
   d:   52                        push   %edx
Code;  c01d32e9 <pppoe_connect+f9/278>
   e:   e8 d6 db 05 00            call   5dbe9 <_EIP+0x5dbe9> c0230ec4 <netdev_finish_unregister+0/98>
Code;  c01d32ee <pppoe_connect+fe/278>
  13:   83 00 00                  addl   $0x0,(%eax)

---------------------------------------------------------------------------------
Syslog output just before the oops:

Dec 30 07:36:18 nova pppd[18012]: Terminating on signal 15.
Dec 30 07:36:18 nova pppd[18012]: Couldn't increase MTU to 1500.
Dec 30 07:36:18 nova pppd[18012]: Couldn't increase MRU to 1500
Dec 30 07:36:18 nova pppd[18012]: Modem hangup
Dec 30 07:36:18 nova pppd[18012]: Connection terminated.
Dec 30 07:36:18 nova pppd[18012]: Connect time 11.3 minutes.
Dec 30 07:36:18 nova pppd[18012]: Sent 5602 bytes, received 4273 bytes.
Dec 30 07:36:18 nova pppd[18012]: Doing disconnect
Dec 30 07:36:18 nova pppd[18012]: sendto returned: Network is down

---------------------------------------------------------------------------------

Many thanks,

Alexandra Walford

--=.Hzm._TH1PCx/m6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+FiOAg9yboPlj2JgRAvFvAJ96FfXK1eBH2mfOpKcDiL57rEipxACfU5uv
WTrkSmg1oIHABBfSYzBO+zM=
=1foB
-----END PGP SIGNATURE-----

--=.Hzm._TH1PCx/m6--
