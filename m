Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUIBVBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUIBVBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUIBVAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:00:47 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:61329 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269109AbUIBU7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:59:25 -0400
Date: Thu, 2 Sep 2004 21:59:17 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: lkml@einar-lueck.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
In-Reply-To: <200409021858.38338.elueck@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org>
References: <200409011441.10154.elueck@de.ibm.com>
 <Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org> <200409021858.38338.elueck@de.ibm.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Einar Lueck wrote:

> Please apologize: I fear I have not specified the setups we address
> precisely enough: I think it helps to imagine the following scenario:
> 1. SERVER1 mounts some NFS stuff exported by SERVER2.
> 2. SERVER1 has two NICs.
> 3. The souce IP address of the related packets is the IP address
> of the NIC the kernel identifies for the outbound route, or the IP
> address specified via a static route (ip route .... src SVIPA)
> 4. In case no static routes are allowed and iptables NAT is no
> option, the relevant packets thus have the IP of a NIC.
> 5. In case the corresponding NIC dies, we have a serious problem.

> This is works of course, too. But it does not solve the problem 
> described above. But, maybe I misunderstood you. Please correct me, 
> if I am wrong.

I dont see why it wouldnt work, it almost undoubtedly will work for 
NFS over TCP. And any problems to cause it to not work would be best 
taking up on the linux-nfs list in order to have a "bind to address" 
option added to knfsd.

Why would it not work?

>> hey presto, "virtual IP" which you can redistribute connected in
>> ospfd/ripd whatever and publish in DNS.
>
> I think this is the same as the first point.

But you must describe why it would not work. *Why*?

> NFS works in kernel. Therefore we could not intercept the 
> corresponding "connect" calls. As a result, the problem scenario 
> described above could not be solved.

Why could it not be solved? And why is the answer not "ask the knfsd 
people to provide bind-to-ip option"?

> You are right, but the packets do not come in, they go out, as I 
> tried to illustrate above. Anyway, in the other case you are 
> completely right.

But on a server, the packets that go out tend to be replies to 
requests. Or at least, the only packets of interest are replies. It's 
a rare server that just off its own bat goes and talks to clients 
which have not communicated first with the server before.

Anyway, even if the server for some reason initiated traffic, the 
correct answer surely is "modify the server to bind to a specific 
address", no?

> Bonding offers a failover facility. For more details, please refer to:
> Documentation/networking/bonding.txt in the kernel tree.

Right, but what does bonding (layer 2) have to do with virtual IPs 
and IP source address?

> Regards
> Einar

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
People say I live in my own little fantasy world... well, at least they
*know* me there!
 		-- D.L. Roth
