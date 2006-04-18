Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWDRKLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWDRKLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWDRKLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:11:39 -0400
Received: from lan-202-144-44-94.maa.sify.net ([202.144.44.94]:46005 "EHLO
	s7solutions.com") by vger.kernel.org with ESMTP id S1750728AbWDRKLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:11:39 -0400
X-MSReally-From: sachin.s@s7solutions.com
Date: Tue, 18 Apr 2006 15:44:58 +0530
To: linux-kernel@vger.kernel.org
Subject: kernel module acquiring virtual ip's
From: "Sachin Shelar" <sachin.s@s7solutions.com>
Organization: S7 SS
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <ops76728o1ibd9oo@sachin>
User-Agent: Opera M2/7.51 (Win32, build 3798)
X-SA-Exim-Connect-IP: 202.144.44.90
X-SA-Exim-Mail-From: sachin.s@s7solutions.com
X-SA-Exim-Scanned: No (on s7solutions.com); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I have a kernel module which "acquires" virtual ips ( not assigned to  
anyone in n/w )
and then respond to any future packets coming to this virtual ip.
    I am handling ARP, TCP, UDP protocols in my module.
To get the arp stuff working I handle all the ARP requests for virtual IP  
and reply to
them with my local hardware address. I can now receive all the packets  
destined to virtual IP.
    E.g Local IP is 192.168.1.2
        Virtual ip is 192.168.1.244 ( Not existing in network )

        I catch every arp request for .244 and reply with my mac. I can now
recive all IP packets ( handled in my netfilter hooks ) destined for .244.
According to the natting rules in my module I nat the packets for .244 and  
redirect them to
some listening port on 192.168.1.2
Also I handle all the outgoing packet from 192.168.1.2 and replace the  
source to 192.168.1.244
So that the client machine recives reply from virual IP, as expected.

         192.168.1.21[32774] -> 192.168.1.244[123]

                          Nat Destination   192.168.1.21[32774] ->  
192.168.1.2[23]

(Reply) 192.168.1.2[23] -> 192.168.1.21[32774]
                          Nat Source        192.168.1.244[123] ->  
192.168.1.21[32774].



    Module works perfectly and I can establish any tcp connection ( E.g  
telnet ) with a non exitsing
IP ( 192.168.1.244) from any machine in the network.

    Problem is :-
    I want the same behaviour from the module if I try to connect from the  
same machine (local machine )
to the virtual IP.

     E.g 192.168.1.2[32772] -> 192.168.1.244[123]

                         Nat Destination   192.168.1.2[32772] ->  
192.168.1.2[23]

***** But somehow this packet after natting is dropped be the kernel and  
never reaches 192.168.1.2[23]
       Is this because the source and destination ip of this packet is same  
?????

     Hoping to get good reponse for this loooong mail :)

Thanks,
Sachin

