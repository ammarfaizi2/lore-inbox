Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLAKP2>; Fri, 1 Dec 2000 05:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbQLAKPR>; Fri, 1 Dec 2000 05:15:17 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:4870 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S129406AbQLAKPA>;
	Fri, 1 Dec 2000 05:15:00 -0500
Date: Fri, 1 Dec 2000 01:44:31 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: tulip log (additional detail: single-threaded httpd)
Message-ID: <Pine.SUN.3.96.1001201012905.16065A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: if anyone else is wondering what may be deadlocking 2.2.17+
in the context of http connects over ethernet (assuming that it is not the
ethernet driver itself): it is also not the httpd server's use of linux
kernel threads (wn is single threaded). And there isn't much going
on in the background when this is tested. A bunch of daemons are
running, but only the k*d (kupdated, kflushd, kpiod, kswapd, klogd)
and utmpd besides the httpd server itself ever run during the test.

Tests were conducted both with inetd handling the http connect and with
wnsd listening on the http port directly, no difference.

Unless one of those k*d daemons uses kernel threads, kernel threads
exported to user space are not possibly the source of the deadlock.

(Might have looked that way due to the stack corruption in the httpd
parent that strace seems to see a few connects before the kernel
deadlock.)

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
