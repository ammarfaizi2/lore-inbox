Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbTH1BiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 21:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTH1BiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 21:38:25 -0400
Received: from minuspol.k-net.dtu.dk ([130.225.71.251]:24325 "EHLO
	minuspol.k-net.dk") by vger.kernel.org with ESMTP id S263331AbTH1BiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 21:38:24 -0400
Message-ID: <3F4D5D0E.2030405@q.nospam.kampsax.k-net.dk>
Date: Thu, 28 Aug 2003 03:38:22 +0200
From: =?ISO-8859-1?Q?Dennis_J=F8rgensen?= 
	<postmaster@q.nospam.kampsax.k-net.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Patch] Wrong warning of invalid icmp to broadcast
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 2.6.0-test4 I see this warning in my logs:

192.38.215.157 sent an invalid ICMP type 11, code 0 error to a 
broadcast: 192.38.215.255 on eth0

The ip is wrong, since it's the ip of my own machine. The following 
patch fixes it (so the ip reported is the same as 2.4.20 reports).

If I should send this somewhere else, please tell me.


Regards

  Dennis Jørgensen
  I'm not on the list, please CC: me.


--- linux-2.6.0-test4.org/net/ipv4/icmp.c       2003-08-28 
01:13:59.000000000 +0200
+++ linux-2.6.0-test4/net/ipv4/icmp.c   2003-08-28 02:12:56.000000000 +0200
@@ -661,7 +661,7 @@
                        printk(KERN_WARNING "%u.%u.%u.%u sent an invalid 
ICMP "
                                            "type %u, code %u "
                                            "error to a broadcast: 
%u.%u.%u.%u on %s\n",
-                              NIPQUAD(iph->saddr),
+                              NIPQUAD(skb->nh.iph->saddr),
                               icmph->type, icmph->code,
                               NIPQUAD(iph->daddr),
                               skb->dev->name);

