Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269546AbRHCSff>; Fri, 3 Aug 2001 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269547AbRHCSf0>; Fri, 3 Aug 2001 14:35:26 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:31754 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269544AbRHCSfU>;
	Fri, 3 Aug 2001 14:35:20 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108031833.WAA26431@ms2.inr.ac.ru>
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
To: alan@bagpuss.swansea.linux.org.uk (Alan Cox)
Date: Fri, 3 Aug 2001 22:33:33 +0400 (MSK DST)
Cc: samudrala@us.ibm.com, hadi@cyberus.ca,
        diffserv-general@lists.sourceforge.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        rusty@rustcorp.com.au, thiemo@sics.se, tewarir@us.ibm.com,
        dmfreim@us.ibm.com
In-Reply-To: <200107292127.f6TLRpC01583@bagpuss.swansea.linux.org.uk> from "Alan Cox" at Jul 29, 1 05:27:50 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Our patch can be used along with SYN policing to prioritize incoming
> > connection requests on a socket. SYN policing can be used to limit 
> > the rate of a particular class, but it cannot be used to prioritize a 
> 
> No. Because you cant prove the packets are not spoofed. An attacker 
> becomes able to block classes

Their idea is feedback from prioritized accept queue to syn-table.
SYN floods just have no effect on this algoruthm.

They do really clever thing. Look at the case with single queue:
when apache is overloaded, accept queue grows. After some point
it becomes meaningless to queue new SYNs, they will only clog
syn-table, but we will not able to accept them in time.
>From the other hand, we cannot just drop SYNs after accept queue overflows,
because we will not have any connection ready, when apache overcomes
its troubles. I have thought on this, but without big success.
Typical accept latency is local and low, and typical syn-table latency
is rtt. The processes of establishing and accepting work at different
time scales and it is not quite trivial to get some useful smooth feedback
from high frequency accept queue to low frequency syn-table.
It is exactly the place where RED-like schemes should work well, by the way,
but I did not try this unfortunately. Trying instead to get feedback from
rate of SYNs, which was deemed to fail.

Actually, 2.4 does some trick of this kind in the most primitive form.

If their approach is really working, it can be extremally useful.

Alexey
