Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbTH1PUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbTH1PUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:20:13 -0400
Received: from tytan.lm.pl ([212.244.46.40]:11483 "EHLO tytan.lm.pl")
	by vger.kernel.org with ESMTP id S264031AbTH1PUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:20:04 -0400
From: Krzysztof Sierota <krzysiek@mediaone.pl>
Organization: MediaOne sp z o.o.
To: linux-kernel@vger.kernel.org, linux-atm@vger.rutgers.edu
Subject: 2.4.22 oops in ATM 2.4.21 works fine
Date: Thu, 28 Aug 2003 15:59:01 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D27CJVJR7IIKVQ8ZADS1"
Message-Id: <200308281559.01395.krzysiek@mediaone.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_D27CJVJR7IIKVQ8ZADS1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

the 2.4.22 kernel is oopsing at start scripts, machine stays alive, but A=
TM=20
does not work. 2.4.21 works just fine.

oops attached.

Hope that someone can find the reason.
Cheers.


--=20
Krzysztof Sierota
MediaOne sp z o.o.
http://mediaone.pl/

--------------Boundary-00=_D27CJVJR7IIKVQ8ZADS1
Content-Type: text/plain;
  charset="us-ascii";
  name="2422.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2422.txt"

ksymoops 2.4.4 on i686 2.4.21.  Options used
     -v ./vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m ./System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Aug 28 02:04:01 minder kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Aug 28 02:04:01 minder kernel: c023f913
Aug 28 02:04:01 minder kernel: *pde = 00000000
Aug 28 02:04:01 minder kernel: Oops: 0002
Aug 28 02:04:01 minder kernel: CPU:    1
Aug 28 02:04:01 minder kernel: EIP:    0010:[<c023f913>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 28 02:04:01 minder kernel: EFLAGS: 00010246
Aug 28 02:04:01 minder kernel: eax: 00000000   ebx: f7550c00   ecx: c028c4a4   edx: 00000000
Aug 28 02:04:01 minder kernel: esi: f743a1b4   edi: 00000000   ebp: f7550c00   esp: f6f57ef8
Aug 28 02:04:01 minder kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 02:04:01 minder kernel: Process atmarpd (pid: 694, stackpage=f6f57000)
Aug 28 02:04:01 minder kernel: Stack: c281e268 000001f0 090a80c4 ffffffff f6f57f28 c02448b4 c283b280 f7841d00
Aug 28 02:04:01 minder kernel:        f6f3eb80 f6f3eb80 c01cd28f 00000003 f7841d00 f7550cb0 000001f0 f743a1b4
Aug 28 02:04:01 minder kernel:        00000000 3230315b c0005d35 f743a1b4 00000000 00000014 f743a1b4 c01cddb3
Aug 28 02:04:01 minder kernel: Call Trace:    [<c02448b4>] [<c01cd28f>] [<c01cddb3>] [<c023e0e5>] [<c01cd8b9>]
Aug 28 02:04:01 minder kernel:   [<c0143f67>] [<c01070c3>]
Aug 28 02:04:01 minder kernel: Code: f0 ff 48 10 a1 4c ac 35 c0 8b 40 18 83 48 14 08 85 d2 75 06

>>EIP; c023f913 <atm_ioctl+493/cb0>   <=====
Trace; c02448b4 <sprintf+14/20>
Trace; c01cd28f <sock_map_fd+16f/180>
Trace; c01cddb3 <sock_create+c3/f0>
Trace; c023e0e5 <__lock_svc_proto_ioctl+35/60>
Trace; c01cd8b9 <sock_ioctl+49/70>
Trace; c0143f67 <sys_ioctl+257/291>
Trace; c01070c3 <system_call+33/38>
Code;  c023f913 <atm_ioctl+493/cb0>
00000000 <_EIP>:
Code;  c023f913 <atm_ioctl+493/cb0>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c023f917 <atm_ioctl+497/cb0>
   4:   a1 4c ac 35 c0            mov    0xc035ac4c,%eax
Code;  c023f91c <atm_ioctl+49c/cb0>
   9:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c023f91f <atm_ioctl+49f/cb0>
   c:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c023f923 <atm_ioctl+4a3/cb0>
  10:   85 d2                     test   %edx,%edx
Code;  c023f925 <atm_ioctl+4a5/cb0>
  12:   75 06                     jne    1a <_EIP+0x1a> c023f92d <atm_ioctl+4ad/cb0>


1 error issued.  Results may not be reliable.

--------------Boundary-00=_D27CJVJR7IIKVQ8ZADS1--

