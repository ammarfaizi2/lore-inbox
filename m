Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRBTUOl>; Tue, 20 Feb 2001 15:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRBTUOb>; Tue, 20 Feb 2001 15:14:31 -0500
Received: from [216.218.132.86] ([216.218.132.86]:43773 "EHLO
	web1.workspot.net") by vger.kernel.org with ESMTP
	id <S130521AbRBTUOP>; Tue, 20 Feb 2001 15:14:15 -0500
Subject: (BUG) 3c509b and kernel 2.4.x
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Lazarus Long <lazarus@workspot.net>
Cc: lazarus@workspot.net, becker@webserv.gsfc.nasa.gov
Message-Id: <E14VJAd-00007S-00@web1.workspot.net>
Date: Tue, 20 Feb 2001 12:13:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I searched, but I have not seen this posted to the list before.)

Non-modular support for 3Com EtherLinkIII cards, specifically the ISA
3c509b, worked fine in kernel 2.2.18.

CONFIG_EL3=y

What worked in kernel 2.2.18 does not work in kernel 2.4.1 however.

http://groups.google.com (deja's successor) reveals that multiple
systems are having this problem, but there are no solutions listed
there (at least not among the English posts.  I don't speak German,
but apparently many Linux users do.)  I've spent quite a number of hours
attempting to resolve the matter, but with no success either.

Search for "Linux 2.4 3c509" shows the follow excerpts among the responses:

 > [1.] Upon boot, the 2.4.1 kernel misconfigures one of two 3c509b NICs
 > installed in my computer as "BNC" rather than "10baseT".

I get the same here.

 > Boot messages for eth0 in kernel 2.2:
 > eth0: 3c509 at 0x300 tag 1, 10baseT port, address 00 a0 24 e9 8d a1, IRQ 10.
 > and in 2.4:
 > eth0: 3c509 at 0x300, BNC port, address 00 a0 24 e9 8d a1, IRQ 10.
 >
 > i don't know why it says BNC port.. but it isn't right, it should be 10baseT

Again, similar results here.  Incorrect port in 2.4.1 but correct in 2.2.18.

 > I have three 3com cards( 1 3c590 Vortex, 1 3c900 Cyclone, 1 3c509B) which
 > have no trouble with 2.2 kernels. But when I am trying to play with 2.4.0
 > kernel, the 3c509 just can not load.

While my other NICs differ, the end result is that the 3c509 does not
work, yet the other NICs do, which is as I have experienced as well.

At the LILO prompt, I pass parameters as follows:
LILO boot: Linux241 ether=10,0x300,eth0 ether=7,0x320,eth1
and the (NE2000 clone) eth0 card works fine, but the 3c509b eth1 card does not.

LILO boot: Linux241 ether=7,0x320,eth0 ether=10,0x300,eth1
is not a solution, and merely causes the ethX values to flip-flop,
with the same failure.  (Anticipated, but I'm mentioning it in case it
matters to anyone.)

And of course, I should mention that
LILO boot: Linux2218 ether=10,0x300,eth0 ether=7,0x320,eth1
works just fine, with the NE2000 clone on eth0 *and* the 3c509b on eth1.
(LILO boot: Linux2218 ether=7,0x320,eth0 ether=10,0x300,eth1
functions as expected as well, with the flip-flop and both cards working.)

There are features of kernel 2.4.x that I consider necessary (including,
but not limited to, netfilter) so using kernel 2.2.18 is not an adequate
solution here.

I've tried recompiling the kernel stripped down to bare minimums for
testing, but nothing seems to resolve this.  I've also tested the kernel
on both a 486dx33 and a PII400, with the same results.  I've also tried
using this as a single NIC in the ether=, for testing, even though
that is not a satisfactory situation here.  Again, failure.  I've even
physically removed the other NICs from the machine and acheived no success.

I don't see this driver mentioned in MAINTAINERS so I'm filing this
bug report to the list.  (I'm uncertain if this is Donald Becker's
"baby" currently or not.)  I'm omitting dmesg and .config etc. since
it doesn't seem to be necessary; anyone with a 3c509b will probably get
similar results with a 2.4.x kernel.  If needed I can send any specifics
upon request.

Please CC: lazarus@workspot.com in any discussion, as I am not on the list.

--------------------------------------------------------------
Get "Your Linux Desktop on the Net" at http://www.workspot.com
