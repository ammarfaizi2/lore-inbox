Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129732AbQK0KIv>; Mon, 27 Nov 2000 05:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129930AbQK0KIl>; Mon, 27 Nov 2000 05:08:41 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:65294 "EHLO mx1.eskimo.com")
        by vger.kernel.org with ESMTP id <S129732AbQK0KI3>;
        Mon, 27 Nov 2000 05:08:29 -0500
Date: Mon, 27 Nov 2000 01:38:25 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reproducible 2.2.1x nethangs
Message-ID: <Pine.SUN.3.96.1001127012545.5698A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(from layer above device driver, imho)

The fact that the http hang does not happen when connecting to
the httpd server from an http client running on the same host
as the server implicates the ethernet interface, but I would be
shocked to find that the cause is a bug in specifically the tulip driver
driving a real tulip card.

You can hang it with http with a tiny fraction of the packets that
are transferred during an ftp session that doesn't bother it at all, so
the device driver streams packets just fine. The http hang has many
more individual connects and forks and connection shutdowns, however, so I
would guess that somewhere in the interface between tcp/ip stack and
device driver bottom half calls is where the bug hits.

I doubt that it matters at all which ethernet device driver it is
exactly, other than perhaps different latencies affecting the timing on
interrupt races (ie any card with the same average latency as an i21143
tulip card will probably see the same problem in the same kernel
versions).

So, what code is different between a socket connection from a listening
daemon to a pci ethernet device driver and a socket connection from the
same listening daemon to a client connected via localhost? There is
a race or other bug in the first that isn't in the second, and it is
a race/bug that is not in 2.0.38. I can't knock 2.0.38 over at all with
http over the same ethernet lan from the same client (but 2.0.38
doesn't work with ipchains and doesn't have the dentry cache, vm
improvements, etc, so this is worth fixing).

(Note: i486, no SMP)

-- 

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
