Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUAXWIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUAXWIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:08:53 -0500
Received: from mail-nb00s0.nbnet.nb.ca ([198.164.200.23]:18143 "EHLO
	ursa-nb00s0.nbnet.nb.ca") by vger.kernel.org with ESMTP
	id S261193AbUAXWIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:08:50 -0500
Message-ID: <DC23FC33129BF1459F3105CC68E8581C5C6C9B@nbexmb01.aliant.icn>
From: "Shaw, Marco" <Marco.Shaw@aliant.ca>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: NTP problems
Date: Sat, 24 Jan 2004 18:08:47 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've not been able to get NTP working on some of my RH7.2 and RHAS2.1 systems.

Absolutely no TCP or UDP traffic shows in a tcpdump.  The command ntpdate gives me this
and nothing more:

15 Jan 10:06:59 ntpdate[22868]: poll(): nfound = 0, error: Success

I was intially thinking that this was a glibc-i386 vs glibc-i686 problem, but
it does not appears so after more research.

I decided to run lsof, and get the following whenver ntpdate fails (doesn't
send out any traffic at all when looking via tcpdump).  Note
the last line where I get "can't indentify protocol".

[root@server]# lsof|grep ntpdate
ntpdate     461     root  cwd    DIR        8,7     4096    144002 /root
ntpdate     461     root  rtd    DIR        8,7     4096         2 /
ntpdate     461     root  txt    REG        8,5    40460    128472 /usr/sbin/ntp
date
ntpdate     461     root  mem    REG        8,7   464409     65742 /lib/ld-2.2.4
.so
ntpdate     461     root  mem    REG        8,5    44851     64355 /usr/lib/libc
ap.so.1.10
ntpdate     461     root  mem    REG        8,7  5737154     64013 /lib/libc-2.2
.4.so
ntpdate     461     root    0u   CHR      136,3                  5 /dev/pts/3
ntpdate     461     root    1u   CHR      136,3                  5 /dev/pts/3
ntpdate     461     root    2u   CHR      136,3                  5 /dev/pts/3
ntpdate     461     root    3u  sock        0,0          175748304 can't identif
y protocol

I've checked the LSOF FAQ regarding this "can't indentify protocol", and I'm not
any further ahead.

I've not been able to reproduce this consistently, but when I shut down xinetd, ipchains,
and enter "ALL:ALL" in hosts.allow, *eventually* (but not consistently especially as 
far as a timeframe), eventually ntpdate works as expected.

Any ideas?

Marco
