Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTIIJBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 05:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTIIJBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 05:01:18 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:30349 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263493AbTIIJBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 05:01:14 -0400
X-Sender-Authentication: net64
Date: Tue, 9 Sep 2003 11:01:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrea Arcangeli <andrea@suse.de>
Subject: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030909110112.4d634896.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

lately I upgraded my testbox from 2 to 6 GB ram and found out some oddities I
would like to hear your opinions.
The box ran flawlessly and performant with 2 GB - was in fact a real joy.
After upgrading the ram and recompiling kernel 2.4.22 with support for 64 GB I
noticed:

1) nfs clients see timeouts again, like

Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 OK
Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 OK
Sep  9 03:41:13 clienta kernel: nfs: server 192.168.1.1 not responding, still
trying
Sep  9 03:41:13 clienta kernel: nfs: server 192.168.1.1 OK

Both are 2.4.22. 192.168.1.1 is the testbox. I saw those with 2GB, but could
fix it through more nfs-daemons and

        echo 2097152 >/proc/sys/net/core/rmem_max
        echo 2097152 >/proc/sys/net/core/wmem_max

Are these values too small for 6 GB?

2) Box is very slow, kswapd looks very active during tar of a local harddisk.
Interactivity is really bad. Seems vm has a high time looking for free or
usable pages. Compared to 2 GB the behaviour is unbelievably bad.

3) Network performance has a remarkable dropdown during above tar. In fact
doing simple pings every few minutes shows that quite a lot of them are simply
dropped, never make it over the ethernet.

I am really astonished about this. Can some kind soul give me hints or maybe
patches to try?

Regards,
Stephan
