Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbREOPxc>; Tue, 15 May 2001 11:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbREOPxW>; Tue, 15 May 2001 11:53:22 -0400
Received: from ns.tasking.nl ([195.193.207.2]:12558 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S262804AbREOPxP>;
	Tue, 15 May 2001 11:53:15 -0400
Date: Tue, 15 May 2001 17:52:12 +0200
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-pre1: Bogus ARP packets containing NFS file data?
Message-ID: <20010515175212.A31058@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is a PIII UP 2.4.5-pre1, NFS client, options from /proc/mounts:

	arezzo:/usr/src/dolphin /usr/src/dolphin nfs rw,nodev,v3,rsize=32768,wsize=32768,hard,udp,nolock,addr=arezzo 0 0

Lately my "arpwatch" running on this 2.4.5-pre1 machine started to log

	May 15 15:55:18 espoo arpwatch: 0:60:97:ba:b4:f5 sent bad hardware format 0x4500 

hostname and Ethernet address correspond with the 2.4.5-pre1 machine itself.
To see what's really on the wire I ran "tcpdump -e -s 1500 -p -i eth0 arp"
on a separate machine with 2.4.0 and caught this:

15:55:18.404032 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11892 for proto #1500 (43) hardware #17664 (35)
15:55:18.405288 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#12077 for proto #1500 (43) hardware #17664 (35)
15:55:18.410843 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#8747 for proto #1500 (44) hardware #17664 (35)
15:55:18.412137 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#8932 for proto #1500 (44) hardware #17664 (35)
15:55:18.415833 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9487 for proto #1500 (44) hardware #17664 (35)
15:55:18.419554 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#10042 for proto #1500 (44) hardware #17664 (35)
15:55:18.424481 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#10782 for proto #1500 (44) hardware #17664 (35)
15:55:18.430703 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11707 for proto #1500 (44) hardware #17664 (35)
15:55:19.091599 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11337 for proto #1500 (45) hardware #17664 (35)
15:55:19.095912 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11892 for proto #1500 (45) hardware #17664 (35)
15:55:19.103662 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#8932 for proto #1500 (46) hardware #17664 (35)
15:55:19.104894 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9117 for proto #1500 (46) hardware #17664 (35)
15:55:19.108663 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9672 for proto #1500 (46) hardware #17664 (35)
15:55:19.109921 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9857 for proto #1500 (46) hardware #17664 (35)
15:55:19.111215 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#10042 for proto #1500 (46) hardware #17664 (35)
15:55:19.112471 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#10227 for proto #1500 (46) hardware #17664 (35)
15:55:19.113725 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#10412 for proto #1500 (46) hardware #17664 (35)
15:55:19.125308 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 418: arp-#4070 for proto #404 (46) hardware #17664 (35)
15:55:20.493244 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11337 for proto #1500 (47) hardware #17664 (35)
15:55:20.494538 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11522 for proto #1500 (47) hardware #17664 (35)
15:55:20.495795 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11707 for proto #1500 (47) hardware #17664 (35)
15:55:20.497088 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#11892 for proto #1500 (47) hardware #17664 (35)
15:55:20.498383 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#12077 for proto #1500 (47) hardware #17664 (35)
15:55:20.507651 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9302 for proto #1500 (48) hardware #17664 (35)
15:55:20.508951 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9487 for proto #1500 (48) hardware #17664 (35)
15:55:20.511465 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#9857 for proto #1500 (48) hardware #17664 (35)
15:55:20.513990 P 0:60:97:ba:b4:f5 0:0:0:0:0:1 arp 1514: arp-#10227 for proto #1500 (48) hardware #17664 (35)

A second run with an additional "-w file" option caught another bunch of
these. "strings -a file" showed (both good and bad packets):

...
	!xBk
	LLLLLLLLLLLLLLLLLLL
	s
	CCCCCCCCCCCCCCCCCCC
=>	espoo
=>	b0VIM 5.7
=>	espoo
=>	~fvm/ctri/c_flow.c
=>	3210#"!
=>	espoo
=>	b0VIM 5.7
=>	espoo
=>	~fvm/ctri/c_flow.c
=>	3210#"!
	WWWWWWWWWWWWWWWWWWW
	yyyyyyyyyyyyyyyyyyy
	wwwwwwwwwwwwwwwwwww
	RRRRRRRRRRRRRRRRRRR
	@@@@@@@@@@@@@@@@@@@
	DDDDDDDDDDDDDDDDDDD
	ooooooooooooooooooo
...

Now this is strange. Everything marked with "=>" can be found in a temporary
file made by VIM on NFS on this 2.4.5-pre1 machine. To be more precise, I was
working on a file named "c_flow.c" and noticed a delay of a few seconds while
VIM was writing the ".c_flow.c.swp" file (guess). At the same time "arpwatch"
complained and I terminated the tcpdump to see what has been logged so far.

The ".c_flow.c.swp" file starts with a magic header "b0VIM 5.7".

-- 
Frank
