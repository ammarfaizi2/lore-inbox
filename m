Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVDFTNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVDFTNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVDFTNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:13:30 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:42382 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262291AbVDFTMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:12:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=L3U9euxFR1VQvFiONnyxgeEF4EwHLETYNvi7qApYnoQhtv6vHK/LZOackKNbkR170Bb2xgU+mO085WNiEPKcSKatHsYoUEZnb0pUM3svprxbriRc2xpbYYVw6TOWn2rygwfbCHeICvwliNtTqZHT7BC0t3jmRW4RNhq20BUANiQ=
Message-ID: <e2a995c3050406121218090467@mail.gmail.com>
Date: Wed, 6 Apr 2005 15:12:05 -0400
From: Mailing List <mailinglist.chris@gmail.com>
Reply-To: Mailing List <mailinglist.chris@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6 libipq kernel hang
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
     I am having a kernel hang with all the latest versions of the 2.6
kernel (2.6.8.1, 2.6.9, 2.6.10, and 2.6.12-rc2).  Basically, my test
is this:  I have a simple ipq program that just takes packets in,
makes a copy of them (using memcpy), then accepts the packets with the
new buffer (which happens to be a copy of the old buffer).  I run this
program on two machines, with the following iptables rules:

/sbin/iptables -t mangle -A POSTROUTING -d 192.168.3.0/24 -j QUEUE
/sbin/iptables -t mangle -A PREROUTING -s 192.168.3.0/24 -j QUEUE

I then have a simple server and client program; the server just
accepts a connection, recv's some data, and then closes the connection
(in a while(1) loop).  The client connects to the server, send's some
data, then closes the connection (in a while(1) loop).  With this test
running, on all of the kernels mentioned above, the kernel will always
hang after some length of time (it seems to be more or less random). 
No oops, no stack trace, just a hard kernel lock.  I saw in the
ChangeLog for 2.6.12-rc2 that they may have fixed a race condition in
netlink; however, 2.6.12-rc2 still did not work for me.  I have also
tried running a server program that just accepts a connection, and
recv's data forever, with a client that connects once, and send's data
forever.  This also locked up the machine, although with slightly
different behavior (basically the queue program sucked up 100% of the
processor for a while, then the whole kernel hung).

All of the code I am using, along with the scripts can be found at

http://www.ontologistics.net/OpenSource/libipq

If anyone has any suggestions about what I am doing wrong in either
the libipq program or the client or server programs, or any ideas
about what is going on with netlink, please let me know.

Thank you,
Chris Lalancette
