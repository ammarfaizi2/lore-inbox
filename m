Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287332AbSATAzZ>; Sat, 19 Jan 2002 19:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287417AbSATAzP>; Sat, 19 Jan 2002 19:55:15 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:17576 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S287332AbSATAy7>;
	Sat, 19 Jan 2002 19:54:59 -0500
Message-ID: <3C4A1492.DC48A17F@isg.de>
Date: Sun, 20 Jan 2002 01:51:30 +0100
From: Stefan Rompf <srompf@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de.suse.lists.linux.kernel> <p73g0525je4.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> It's only when you assume that the link beat is a "serious" sign for
> link healthiness. Unfortunately there are many error cases where a link
> can fail, but the link beat is still there - for example the software
> on the other machine crashing but the NIC still working fine. These
> seem to be the majority of the cases in fact except for demo situations
> where people pull cables on purpose.

I disagree. There are two very real situations that come to my mind
spontaneously:

-Many telecom providers loop back a synchronous serial line whenever the
connection fails somewhere on the WAN. While this actually isn't a link
beat, it can be detected as an interface failure instantly
(!IFF_RUNNING) and is therefore much faster than any (even highly tuned)
routing protocol.

-You have two redundant routers pointing into an ethernet segment, and
if the NIC of one router starts failing, the switch might decide to turn
off the port in question because of excessive errors (many switches do).
Or the switch may simply lose power. Without link beat detection, the
router in question cannot see these situations and will happily continue
advertising the connected network, making the automated backup
mechanism fail. ARP probing is no solution as it can only detect a host
on the network going down, not the interface.


Of course, link beat detection is not the magic lantern making all
networking problems vanish, but from my networking experience it is
important enough to support it.

Stefan

