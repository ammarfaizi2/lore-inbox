Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTLQRNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTLQRNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:13:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4109 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264455AbTLQRNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:13:41 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: raid0 slower than devices it is assembled of?
Date: 17 Dec 2003 17:02:09 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brq26h$6ei$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0312161304390.1599@home.osdl.org> <1071657159.2155.76.camel@abyss.local>
X-Trace: gatekeeper.tmr.com 1071680529 6610 192.168.12.62 (17 Dec 2003 17:02:09 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1071657159.2155.76.camel@abyss.local>,
Peter Zaitsev  <peter@mysql.com> wrote:

| One more issue with smaller stripes both for RAID5 and RAID0 (at least
| for DBMS workloads) is - you normally want multi-block IO (ie fetching
| many sequentially located pages) to be close in cost to reading single
| page, which is true for single hard drive. However with small stripe
| size you will hit many of underlying devices  putting excessive not
| necessary load. 

All this depends on what you're trying to optimize and the speed of the
drives. I spent several years running on software raid and got to look
harder than I wanted at the tuning.

If the read size is large enough for transfer time to matter, not hidden
in the latency, adjusting the stripe size so that you use many drives is
a win. You want to avoid having a user i/o generate more than one i/o
per drive if you can, which can lead to large stripe sizes.

Also, the read to write ratio is important. RAID-5 does poorly with
write, since the CRC needs to be recalculated and written each time. On
read, unless you are in fallback mode, you just read the data and the
performance is similar to RAID-0.

If you have (a) a high read to write load, and (b) a very heavy read
load, then RAID-1 works better, possibly with more than two copies of
the data to reduce head motion contention.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
