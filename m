Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311483AbSCaDf5>; Sat, 30 Mar 2002 22:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSCaDfr>; Sat, 30 Mar 2002 22:35:47 -0500
Received: from mail.cyberus.ca ([216.191.240.111]:1786 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S311483AbSCaDfp>;
	Sat, 30 Mar 2002 22:35:45 -0500
Date: Sat, 30 Mar 2002 22:30:37 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Stefan Rompf <srompf@isg.de>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Patch: Device operative state notification against 2.5.7
Message-ID: <Pine.GSO.4.30.0203302133110.7012-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
in the future can you please just post to netdev on networking
related issues? I responded to lk, but feel free to remove it
from the list.

-I am not sure the idea of using a kernel thread is the best. Maybe
move the checks to both the tx or rx softirqs instead of its own scheduling.
-In particular, it would be a better idea not to just go walking all the
devices; only walk devices that have raised an netif_carrier_.
-A shared devices bitmask across SMP should be enough (i.e no need for
per-CPU state)
-Another thing might be to double check that the condition that raised
the state change is still valid example -
in between the moment you say a link is down due to some bad hardware
fault to the moment some device timer recovers it;
-Also IFF_RUNNING seems to have inconsistent semantics in a lot of
drivers. It should really stand for "operational status" whereas
IFF_UP should stand for "admin status" -- anyone wanna shed historical
wisdom here?

cheers,
jamal

