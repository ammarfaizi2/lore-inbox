Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264793AbSJORW6>; Tue, 15 Oct 2002 13:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbSJORW6>; Tue, 15 Oct 2002 13:22:58 -0400
Received: from ios.uri1.com ([216.161.22.188]:9112 "EHLO x")
	by vger.kernel.org with ESMTP id <S264793AbSJORW5>;
	Tue, 15 Oct 2002 13:22:57 -0400
Date: Tue, 15 Oct 2002 17:01:01 +0000 (GMT)
From: Brak <brak@x.interzone.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 TCP-RST ignored by kernel, keeps sending SYN-ACK (no ECN in
 kernel config)
Message-ID: <Pine.LNX.4.44.0210151646050.15109-100000@x.interzone.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I really hope someone else has seen this before.

Summary:
2.4.19 Kernel doesn't close out connection from SYN_RECV state when
properly sequenced TCP-RST is received.  2.4.12-ac3 behaves properly.

Full Description:
I have a load balancer that is doing simple health checks by poking at a
port, lets say 80.  The load balancers sends a SYN to the port.  This puts
the port in the SYN_RECV state.  The Linux server responds with a SYN-ACK.
Next, the load balancer responds with a RST.  When I was running the
2.4.12-ac3 kernel, the socket sitting in SYN_RECV went away, as it should.

With 2.4.19, the socket stays in SYN_RECV, and the kernel keeps sending
SYN-ACK's to the load balancer.  Each time the load balancer receives a
SYN-ACK it send another TCP-RST, which again, causes nothing to happen to
the socket.

10:14:51.089620 < 192.168.50.46.1097 > 192.168.50.254.80: S
779425095:779425095(0) win 16384 <mss 1460>
10:14:51.089656 > 192.168.50.254.80 > 192.168.50.46.1097: S
144111045:144111045(0) ack 779425096 win 5840 <mss 1460> (DF)
10:14:51.093041 < 192.168.50.46.1097 > 192.168.50.254.80: R
779425096:779425096(0) win 1 (DF)
10:14:54.330613 > 192.168.50.254.80 > 192.168.50.46.1097: S
144111045:144111045(0) ack 779425096 win 5840 <mss 1460> (DF)
10:14:54.330796 < 192.168.50.46.1097 > 192.168.50.254.80: R
779425096:779425096(0) win 0 (DF)
10:15:00.330614 > 192.168.50.254.80 > 192.168.50.46.1097: S
144111045:144111045(0) ack 779425096 win 5840 <mss 1460> (DF)
10:15:00.330797 < 192.168.50.46.1097 > 192.168.50.254.80: R
779425096:779425096(0) win 0 (DF)


/proc/versions
Linux version 2.4.19 (root) (gcc version 2.96 20000731
(Red Hat Linux 7.1 2.96-98)) #1 Fri Sep 13 19:08:36 PDT 2002

