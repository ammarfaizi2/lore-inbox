Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268708AbUHTUFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268708AbUHTUFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUHTUE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:04:59 -0400
Received: from lakermmtao06.cox.net ([68.230.240.33]:59603 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S268708AbUHTUEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:04:39 -0400
Message-ID: <32995.172.20.32.77.1093032267.squirrel@172.20.32.77>
Date: Fri, 20 Aug 2004 15:04:27 -0500 (CDT)
Subject: Strange NFS client behavior on 2.6.6 and higher {Scanned}
From: "Rett D. Walters" <rettw@rtwnetwork.com>
To: linux-kernel@vger.kernel.org
Reply-To: rettw@rtwnetwork.com
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-rtwnetwork.com-MailScanner-Information: Please contact the ISP for more information
X-rtwnetwork.com-MailScanner: Found to be clean
X-MailScanner-From: rettw@rtwnetwork.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working towards moving my systems to kernel
2.6 and I have noticed that 2.6.6 and higher NFS client
code exhibits some strange behavior when writing files
using cat /dev/video0 > <some file on NFS mount>.

Using a 2.4 client, the file slowly counts up as data is
written when pushing to a 2.4 server.  Using 2.6.6 against
a 2.6 server the file is written in large multi-megabyte
clumps instead.  However using a 2.6.6 client against a
2.4 server acts just like it used to, with a "trickle"
write.  A tcpdump trace of the 2.6.6 client against a 2.6
server show no traffic being transmitted and then suddenly
a burst of 20,000 packets sent then nothing, until the
next burst.

It appears to me that the 2.6.6 client against a 2.6
server scenario that the 2.6.6 client is caching the data
then writing it in these large clumps.  As a data comm
engineer by profession, this seems a little strange. 
Sending 20000 packets in large, very fast bursts will
increase the likelyhood of causing congestion at the
receiver which could lead to packet loss. I am using NFS
v3 over UDP, and have tried using async and sync, and
setting the rsize/wsize to 8k etc to no avail.

The /dev/video0 device is an MPEG encoder card.  Encoding
at  8Mbit/sec.

Another concern I have here is that in kernel versions
higher than 2.6.6 the cat seems to hang and never write
data to the nfs mount after about 70 or so MB, no matter
if its going to a 2.6 server or a 2.4 server.

Can anyone out there in kernel land shed some light on
this behavior?

Thanks in advance

Rett Walters

