Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKOVQa>; Wed, 15 Nov 2000 16:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQKOVQV>; Wed, 15 Nov 2000 16:16:21 -0500
Received: from mail11.voicenet.com ([207.103.0.37]:44474 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129152AbQKOVQJ>;
	Wed, 15 Nov 2000 16:16:09 -0500
Date: Wed, 15 Nov 2000 15:46:03 -0500
From: safemode <safemode@voicenet.com>
To: linux-kernel@vger.kernel.org
Subject: (iptables) ip_conntrack bug?
Message-ID: <20001115154603.D4089@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was DDoS'd today while away and came home to find the firewall unable to
do anything network related (although my connection to irc was still
working oddly).  a quick dmesg showed the problem.
ip_conntrack: maximum limit of 2048 entries exceeded
NET: 1 messages suppressed.
ip_conntrack: maximum limit of 2048 entries exceeded
NET: 3 messages suppressed.
ip_conntrack: maximum limit of 2048 entries exceeded
NAT: 0 dropping untracked packet c1e69980 6 192.168.1.2 -> 206.251.7.30
ip_conntrack: maximum limit of 2048 entries exceeded
NAT: 0 dropping untracked packet c1e69b60 6 192.168.1.2 -> 206.251.7.30
ip_conntrack: maximum limit of 2048 entries exceeded


That is a very small snippet of dmesg.  It seems that ip_conntrack did not
flush or reset after the attack, even though everything was fine when i got
home.  Keep in mind, this was a somewhat massive attack on my network here
but is only connected via a DSL line, it seems the attackers sent hundreds
or thousands of very small packets resulting in 21000 connection attempts
in a short amount of time.  Is this a bug with ip_conntrack?  this is
kernel version 2.4.0-test5, it's been up for 74 days.  I had to reload
ip_conntrack to flush it and everything worked fine after that.    Thanks
for any info.  

ps.  If this is a previously discovered bug, is it fixed in the latest
kernels?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
