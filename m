Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUBOEWM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 23:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUBOEWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 23:22:11 -0500
Received: from [193.226.51.42] ([193.226.51.42]:15119 "HELO al.math.unibuc.ro")
	by vger.kernel.org with SMTP id S264095AbUBOEWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 23:22:09 -0500
Message-ID: <402EF3E9.4090502@al.math.unibuc.ro>
Date: Sun, 15 Feb 2004 06:22:01 +0200
From: Mihai Tanasescu <mihai@al.math.unibuc.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.24 bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've recently discovered a bug in the conntrack system I think of the 
linux 2.4.24 kernel:

I have the following setup:

eth0      Link encap:Ethernet  HWaddr 00:40:F4:79:11:A3
           inet addr:213.154.157.242  Bcast:213.154.157.243  \

eth0:0    Link encap:Ethernet  HWaddr 00:40:F4:79:11:A3
           inet addr:213.154.157.42  Bcast:213.154.157.47  \
eth0:1    Link encap:Ethernet  HWaddr 00:40:F4:79:11:A3
           inet addr:213.154.157.43  Bcast:213.154.157.47  \

eth0:2    Link encap:Ethernet  HWaddr 00:40:F4:79:11:A3
           inet addr:213.154.157.44  Bcast:213.154.157.47  \
eth0:3    Link encap:Ethernet  HWaddr 00:40:F4:79:11:A3
           inet addr:213.154.157.45  Bcast:213.154.157.47  \

and I have something like
SNAT 192.168.40.10,192.168.40.11 to 213.154.157.242
SNAT 192.168.40.12,192.168.40.13 to 213.154.157.42
and so on for every alias IP on my external interface eth0

with the 2.4.24 kernel NAT was only working for the first ip of the 
network interface=213.154.157.242 in my case (for the other ones=the 
aliases it reacted in the following way ....
for example an icmp ping from 192.168.40.13 to some site would get seen 
with tcpdump exiting the server with the correct nated IP ...I would see 
it come back on the external interface..but no packet would come out the 
internal interface  in order to reach the private ip that originally 
sent the ping ..)
like: tcpdump -n -i eth1
icmp echo request 192.168.40.13 > 194.102.255.2
tcpdump -n -i eth0
icmp echo request 213.154.157.42 > 194.102.255.2
icmp echo reply 194.102.255.2 > 213.154.157.42
but I get NO reply like this going to the private/lan station
tcpdump -n -i eth1
icmp echo reply 194.102.255.2 > 192.168.40.13
(it seems the packet gets stuck in the router and doesn't reach the 
local station that send the initial packet)

		

