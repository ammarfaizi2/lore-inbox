Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135924AbREGAPn>; Sun, 6 May 2001 20:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135936AbREGAPd>; Sun, 6 May 2001 20:15:33 -0400
Received: from fepF.post.tele.dk ([195.41.46.135]:21146 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S135924AbREGAP3>; Sun, 6 May 2001 20:15:29 -0400
From: "Svenning Soerensen" <svenning@post5.tele.dk>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ipsec@freeswan.org>
Subject: RE: Problem with PMTU discovery on ICMP packets
Date: Mon, 7 May 2001 02:19:02 +0200
Message-ID: <016e01c0d68b$51da19a0$1400a8c0@sss.intermate.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <15092.31381.395563.889405@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David S. Miller [mailto:davem@redhat.com]

> But I first want to know the real story behind this reboot anomaly.
> Then we will fix any new bug we discover, and apply the icmp patch as
> well.

I've done a bit more testing. The behaviour doesn't change across reboots.
Instead, it seems to be the case that:
If the packet fits within the MTU of the outgoing interface, DF is set.
If the packet doesn't fit, and thus gets fragmented, DF is clear on all
fragments.
Does this make sense?

I think the reason it looked like it changed across reboots might be caused
by the fact that it was influenced by a FreeS/WAN tunnel, which, after a
reboot, didn't always get started successfully.
If the tunnel was down, the packets (2 kB pings) would go out eth0 fragmented
and with DF clear.
If the tunnel was up, they would get routed through the ipsec0 interface
(with a MTU of 16kB) unfragmented and with DF set.

In the latter (normal) case, after arrival and decapsulation at the endpoint
of the tunnel, the packet is doomed because it needs fragmentation to travel
further, but DF is set.


Svenning
