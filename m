Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131490AbQLVFhF>; Fri, 22 Dec 2000 00:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131707AbQLVFgq>; Fri, 22 Dec 2000 00:36:46 -0500
Received: from fe2.rdc-kc.rr.com ([24.94.163.49]:63754 "EHLO
	mail2.cinci.rr.com") by vger.kernel.org with ESMTP
	id <S131490AbQLVFgm>; Fri, 22 Dec 2000 00:36:42 -0500
Date: Fri, 22 Dec 2000 01:05:59 -0500 (EST)
From: John Buswell <johnb@linuxcast.org>
To: linux-kernel@vger.kernel.org
cc: netfilter@us5.samba.org
Subject: 2.4.0-test(4 - 11), iptables 1.1.2 and connect: invalid bug(?)
Message-ID: <Pine.LNX.4.21.0012220045440.11130-100000@bloatfish.opaquenetworks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a problem with two machines (one running 2.4.0-t4, and the other
2.4.0-t11). The hardware in both machines is completely different (one is
a 486dx4 and the other is a 533MHz celeron). i am starting to think that
it is possibly a bug.

The 2.4.0-t4 machine is running iptables v1.1.1 and the other is running
1.1.2. The first box is doing masq, port fowarding and normal firewalling
stuff. The 2.4.0-t11 box is just doing standard port allow/deny type
stuff.

The test11 box has been working fine for a few weeks, today I installed
openssl, ntop and mrtg. I then went to add some new dns records, and when
I restarted bind 9.0.1, I noticed this error:

Dec 22 03:00:44 avatar named[8079]: socket.c:921: unexpected error:
Dec 22 03:00:44 avatar named[8079]: internal_send: Invalid argument
Dec 22 03:00:44 avatar named[8079]: socket.c:921: unexpected error:
Dec 22 03:00:44 avatar named[8079]: internal_send: Invalid argument
Dec 22 03:00:44 avatar named[8079]: socket.c:921: unexpected error:
Dec 22 03:00:44 avatar named[8079]: internal_send: Invalid argument

repeated.. named stays as an active process but doesn't do anything.

it appears that any kind of tcp/udp connection to any local interface on
the server causes this problem. however, if you connect to the interface
from a remote machine to the same service, it works fine..

local> telnet 65.27.144.37 80
Trying 65.27.144.37...
telnet: Unable to connect to remote host: Invalid argument

but if i try telnetting to the same ip on the same port from a remote
machine, it works fine. 

ping also yields the same error:

local> ping 65.27.144.37
connect: Invalid argument
 
both machines behave exactly the same. both machines are using kernels
without the use of modules (the 486dx4 with 64MB), one even boots from
floppy. 

occasionally (usually during compiles) both the test11 and test4 machines
will hardware lock. i have another machine that will do something similar
and its running test10 but i don't run iptables on it. the test10 machine
is an AMD-k6 III 400MHz with a VIA chipset. The test11 is the 533Mhz with
an ALI chipset.

i was wondering if anyone else had seen this connect: Invalid argument
problem??

thanks

-- 
John Buswell 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
