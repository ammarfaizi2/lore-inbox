Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145277AbRA2F4o>; Mon, 29 Jan 2001 00:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145292AbRA2F4e>; Mon, 29 Jan 2001 00:56:34 -0500
Received: from grunt.okdirect.com ([209.54.94.12]:47626 "HELO mail.pyxos.com")
	by vger.kernel.org with SMTP id <S145277AbRA2F41>;
	Mon, 29 Jan 2001 00:56:27 -0500
Message-Id: <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 28 Jan 2001 23:57:06 -0600
To: linux-kernel@vger.kernel.org
From: Daniel Walton <zwwe@opti.cgi.net>
Subject: 2.4.0 Networking oddity
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running a web server under the new 2.4.0 kernel and am experiencing 
some intermittent odd behavior from the kernel.  The machine will sometimes 
go through cycles where network response becomes slow even though top 
reports over 60% idle CPU time.   When this is happening ping goes from 
reasonable response times to response times of several seconds in cycles of 
about 15 to 20 seconds.

As a test I pinged another machine on the same network segment and received 
the same results listed above.  On the other hand, I pinged from the other 
machine on the LAN to the problem machine and the ping times were a 
consistent 0.1ms.  This tells me two things.  One, that the network switch 
was not causing the problem, and two, that the problem is very likely 
somewhere in the handoff of packets from kernel-land to user-land on the 
problem server.

Here is the ping results from the problem server to another machine on the 
same segment:

77 packets transmitted, 77 packets received, 0% packet loss
round-trip min/avg/max = 0.2/4368.1/15126.6 ms


Here are the ping results from the other machine to the problem server 
taken at exactly the same time:

116 packets transmitted, 115 packets received, 0% packet loss
round-trip min/avg/max = 0.1/0.1/0.3 ms


A little information about what I'm running.  The server is running about 
700Kbps continuous network output from nearly a thousand concurrent 
connections.  The web server is a single process which utilizes the 
select/poll method of multiplexing.  The machine is an 1gig Athlon 
processor with 512megs with RedHat 6.2 installed.

I have the following tweaks setup in my rc.local file:

echo "7168 32767 65535" > /proc/sys/net/ipv4/tcp_mem
echo 32768 > /proc/sys/net/ipv4/tcp_max_orphans
echo 4096 > /proc/sys/net/ipv4/tcp_max_syn_backlog
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
echo 4 > /proc/sys/net/ipv4/tcp_syn_retries
echo 7 > /proc/sys/net/ipv4/tcp_retries2
echo 300 > /proc/sys/net/ipv4/tcp_keepalive_time
echo 30 > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo 16384 > /proc/sys/fs/file-max
echo 16384 > /proc/sys/kernel/rtsig-max


Am I simply missing something in my tweaks or is this a bug?  I would be 
happy to supply more information if it would help anyone in the know on a 
problem like this.

I appreciate any light anyone can shed on this subject.  I've been trying 
to find the source of this problem for some time now.

Daniel Walton



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
