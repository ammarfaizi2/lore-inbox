Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSASRlG>; Sat, 19 Jan 2002 12:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSASRk4>; Sat, 19 Jan 2002 12:40:56 -0500
Received: from ns.suse.de ([213.95.15.193]:28679 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286336AbSASRkj>;
	Sat, 19 Jan 2002 12:40:39 -0500
To: Stefan Rompf <srompf@isg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jan 2002 18:40:35 +0100
In-Reply-To: Stefan Rompf's message of "19 Jan 2002 16:27:54 +0100"
Message-ID: <p73g0525je4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf <srompf@isg.de> writes:

> while playing with the Zebra routing daemon, I realized that neither
> Linux nor Zebra are capable of detecting the operative state of an
> interface, f.e. the ethernet link beat. This is a major show stopper
> against using Linux for "serious" IP routing.

It's only when you assume that the link beat is a "serious" sign for
link healthiness. Unfortunately there are many error cases where a link
can fail, but the link beat is still there - for example the software
on the other machine crashing but the NIC still working fine. These
seem to be the majority of the cases in fact except for demo situations
where people pull cables on purpose. To handle all the other cases you
need a separate heartbeat protocol that actually checks if the higher
layers above the networking card are alive on the peer too. Most routing
protocols do this already in fact, e.g. OSPF or RIP with their 'hello' 
packets. The Linux IP stack does it also using ARP probes.  When a probe
is not answered the routing daemon eventually notices and takes action.
While waiting for probes is a bit slower (30-60s usually), checking
the link beat only handles such a small subset of cases that it is not
worth it to optimize these rare ones. 

Commercial vendors seem to like it because it looks good in demos ;),
but linux fortunately doesn't have to be concerned with such marketing
reasoning. 

In short - Linux doesn't have this feature because it's not needed.
If your routing protocol relies on link state checking without other
probing it's broken. Zebra isn't. 

-Andi
