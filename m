Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131795AbRAQR34>; Wed, 17 Jan 2001 12:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbRAQR3r>; Wed, 17 Jan 2001 12:29:47 -0500
Received: from ktk.bidmc.harvard.edu ([134.174.237.112]:26895 "EHLO
	ktk.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S131795AbRAQR3b>; Wed, 17 Jan 2001 12:29:31 -0500
Message-ID: <3A65D668.F746F2EE@bigfoot.com>
Date: Wed, 17 Jan 2001 12:29:12 -0500
From: "Kristofer T. Karas" <ktk@bigfoot.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en, en-GB
MIME-Version: 1.0
To: Svein Erik Brostigen <svein.brostigen@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8, webbrowsers and proxies...
In-Reply-To: <3A6553F1.C1A87632@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Svein Erik Brostigen wrote:

> After compiling and booting into 2.4.1-pre8, I found some strange
> behaviour. I was not able to connect to any website using a http proxy.

The problem is not with your web client, it's with your connection to the
proxy.  Your proxy doesn't want to talk to your machine.  I am assuming that
the proxy does accept a connection when you are running kernel 2.2.x, but
rejects it under 2.4.x, correct?  If this is not so (the proxy refuses you
regardless of kernel version) then you need to ask the proxy administrator;
it's their problem, not linux's.

But assuming the refused connections occur with 2.4.x, then what is most
likely happening is that you have compiled CONFIG_INET_ECN into your kernel.
As the documentation says, many firewalls (at notable sites) refuse
connections from machines with ECN enabled.

See if the file /proc/sys/net/ipv4/tcp_ecn exists when you are running 2.4.x.

If so, do  'echo 0 > /proc/sys/net/ipv4/tcp_ecn' and try your proxy again.

Kris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
