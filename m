Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSKWSa3>; Sat, 23 Nov 2002 13:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSKWSa3>; Sat, 23 Nov 2002 13:30:29 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:5347 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S267023AbSKWSa2>;
	Sat, 23 Nov 2002 13:30:28 -0500
Message-ID: <3DDFCAEE.7090705@virgilio.it>
Date: Sat, 23 Nov 2002 19:37:34 +0100
From: Lars Knudsen <gandalfit@virgilio.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug with netfilter and NFS server on same machine
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing problems running a nfs server and iptables on 
the same machine.The problem was also reported almost a year ago by Paul 
Raines on the netfilter mailing list 
http://lists.netfilter.org/pipermail/netfilter/2002-January/030002.html 
but it seems no solution has been found yet.

The problem is this: A machine running linux 2.4.18 or 2.4.19 works just 
fine when running just the kernel nfsd. A single client connected to the 
server with 100Mbit ethernet sees throughput of 5-10MByte/sec even after 
an hour or two of continous transfers. If the nfs server is also running 
iptables the throughput is initially the same (5-10MByte/sec) but after 
a while (200MByte-500MByte total transfer) the client starts reporting 
"nfs server not responding" followed after a while by "nfs server OK" 
and of course the transfer rate goes way down (< 1MByte/sec). Using 
tcpdump on the client seems to indicate that some packets have their 
headers garbled - wrong fragment ids being the typical error.

Having iptables compiled as modules and simply loading or unloading the 
ipt_conntrack module is
sufficient for causing/removing the problem. Having iptables support 
compiled into the kernel causes the problem allways.

The problem has been verified on 4 different machines with a variety of 
different ethernet cards. In
all cases the network continues to work without problems for all other 
types of traffic - i.e a telnet connection from client to server works 
with no delay and a ftp transfer goes at >5MByte/sec even when nfs 
throughput is suffering.

\Lars Knudsen

