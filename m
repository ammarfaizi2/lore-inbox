Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRKXMYO>; Sat, 24 Nov 2001 07:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRKXMYE>; Sat, 24 Nov 2001 07:24:04 -0500
Received: from [194.6.179.14] ([194.6.179.14]:24396 "EHLO mailhost.cubic.ch")
	by vger.kernel.org with ESMTP id <S277382AbRKXMXv>;
	Sat, 24 Nov 2001 07:23:51 -0500
Message-ID: <1167.213.3.86.198.1006604706.squirrel@cubic.ch>
Date: Sat, 24 Nov 2001 13:25:06 +0100 (CET)
Subject: Oops in ksoftirqd
From: "Martin Petruzzi" <santino@cubic.ch>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.1.2)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Community

I think I detected an Oops. I may do any mistakes, but I can reproduce the Oops exactly. 
I'm running a server with kernel 2.4.14, patched with br2684-against2.4.2.diff and ext3-2.4-0.9.15-2414.gz.
I'm using an Alcatel Speedtouch USB ADSL-modem.
The clients in the network are all Win98 communicating with Putty (SSH).

The problem is about the following script:
***********************************************************
#!/bin/sh

/usr/bin/clear

/usr/bin/killall pppd
/sbin/ifconfig nas0 down
/usr/bin/killall br2684ctl

sleep 1

/usr/sbin/br2684ctl -b -c 0 -a 8.35
/sbin/iconfig nas0 up
/usr/sbin/pppd

/usr/bin/tail -2 /var/log/messages
echo -n "Press ENTER to quit. "
read x

exit 0
***********************************************************

When I execute this script over sudo, as any user logged in with Putty, it works perfect.
Then I've defined a ssh-user just giving his privatkey-file instead of prompting the passwd. In Putty I set /usr/bin/sudo inet_up to 
execute when logged in.

The target was to simply doubleclick the Putty-Icon from any Win-client to set up the connection.

When I do so, it still works fine, it ends with a connection (which is available to all clients) and log out is done as well.
After that, the first keystroke in any console on the server (through ssh or local) causes immediatly the following screen on the server: 

***********************************************************
Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c01fbbac>] Not tainted
EEFLAGS: 00010012
eax: c13c5080	ebx: 00000080	ecx: 00000002	edx: 00000000
esi: 00000020	edi: 00000019	ebp: 0000004a	esp: c13e7e8c
ds: 0018	es: 0018	ss: 0018
Process ksoftirqd_CPU0 (pid: 4, stackpage=c13e7000)
Stack:	0000a020 c13dc944 c01a0f37 0000005c 00000020 00000064 00000001 0000001f
		c13dc940 c031d000 c031d07c c02a8340 00000000 00004000 c13dc940 c13dc800
		cc880000 c01a099a c13dc800 00004050 00000014 cbfdd740 24000001 0000000b
Call Trace:	[<c01a0f37>] [<c01a099a>] [<c0107ffa>] [<c0108178>] [<c010a178>] 
			[<c01f0018>] [<c01fbef5>] [<c02441da>] [<c01081ac>] [<c020527a>] [<c01192d4>]

			[<c01ff8be>] [<c0115fab>] [<c0105000>] [<c01163d5>] [<c0105516>] [<c0166240>]  


Code: c7 42 04 a0 95 31 c0 89 15 a0 95 31 c0 c7 00 00 00 00 00 c7
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
************************************************************

I did that several times to exclude all other related actions. It only happens with the sequence
described above, but everytime.

Now I actually don't need any help since I worked around it by setting up DialOnDemand, so I don't use that thing anymore (any other 
scripts I have do work the same way), but I still find it could be interesting for the developers.

If there is an obvious mistake in what I did, I would certainly also be interested to know.

Thank you 

Martin

