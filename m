Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUHVJsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUHVJsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUHVJsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:48:33 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:5110 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266616AbUHVJsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:48:30 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 12:48:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <41286915.9090209@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIK2fRyUjvimvKT/+v9WkSY+b3kQACHpaw
Message-Id: <S266616AbUHVJsa/20040822094830Z+232@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am still persistent on the fact that NAT should work with this sense.

I just enable NAT with the following command

iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to 192.168.1.5

This IP 192.168.1.5 is our patched linux server which is allowed to acccess
192.168.1.77

Now all protocols in the linux system is working fine as ever, and even ping
sent to 192.168.77.1 returns from 192.168.77.1 that is visible in the
presumably lowest layer of network stack (as tcpdump also sees it that way).

However; the client on the interface eth0 which has the IP address of
192.168.0.30 gets its IP address translated to 192.168.1.5, the ping is sent
and a response is received (tcpdump shows it)

But the patched linux system does not translate it back to the client that
requested that ping. That means, only our patched linux system can access to
the node, but nothing else.

I tested NAT for another interface (not eth1 whose connection is now somehow
patched) to send a request to google.com, the NAT ensuredly works for any
other IP but 192.168.77.1.  

I am suspiciuous about the fact that IPTables might still see the wrong IP
address of the device before it is changed by the patch (192.168.1.1), thus
it drops the packet there. However; this event is rather odd...

BTW, the problem is at the edge of being resolved, since the hardest part is
now gone. But I could not believe all this would be gone by two lines of
code... The solution must be there;

*You could test the NAT to see whether it works for your configuration, this
time I am totally out of ideas...





-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 11:36 AM
To: Josan Kadett
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

You have 192.168.0.x NAT to 192.168.1.1?
I thought you wanted to NAT to 192.168.77.1?

My understanding was you sent a packet to 192.168.77.1 and the device sent
it back from 192.168.1.1

Can you send me your iptables configuration?



