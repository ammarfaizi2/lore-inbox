Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTHXOQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 10:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTHXOQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 10:16:03 -0400
Received: from web40508.mail.yahoo.com ([66.218.78.125]:7428 "HELO
	web40508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263546AbTHXOQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 10:16:01 -0400
Message-ID: <20030824141600.93849.qmail@web40508.mail.yahoo.com>
Date: Sun, 24 Aug 2003 07:16:00 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: [RFC] patch for invalid packet time from ULOG target of iptables
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just started playing with the ULOG target in
iptables, and I've noticed that the 'timestamp_sec'
member of the ulog_packet_msg_t struct paseed to
the user is always 0 for locally generated packets.
I was thinking of patching the ipt_ulog_target
function in net/ipv4/netfilter/ipt_ULOG.c to
check if timestamp_sec is 0 and if so, set it
to the current time by adding code to test
'timestamp_sec' after it's been set. E.g;

    pm->timestamp_sec = (*pskb)->stamp.tv_sec;
    pm->timestamp_usec = (*pskb)->stamp.tv_usec;
+   if ( pm->timestamp_sec == 0 ) {
+      pm->timestamp_sec = currrent time;
+   }

Any comments?


=====
I code, therefore I am

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
