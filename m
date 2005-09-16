Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVIPVQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVIPVQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVIPVQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:16:12 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18063 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751292AbVIPVQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:16:12 -0400
Subject: Re: printk timings stay weird, also waaay after 5 seconds
From: Steven Rostedt <rostedt@goodmis.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: tim@physik3.uni-rostock.de, "Randy.Dunlap" <rdunlap@xenotime.net>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050916205541.GL17290@vanheusden.com>
References: <20050916204759.GK17290@vanheusden.com>
	 <20050916205541.GL17290@vanheusden.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 16 Sep 2005 17:15:56 -0400
Message-Id: <1126905356.6675.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 22:55 +0200, Folkert van Heusden wrote:
> by the way: ALSO after a COLD boot these values are high:
> [42949372.960000] Linux version 2.6.13.1 (root@thegate) (gcc version 4.0.1 (Debian 4.0.1-2)) #1 Wed Sep 14 11:56:45 CEST 2005
> [42949372.960000] BIOS-provided physical RAM map:
> [42949372.960000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> ...
> [42949376.200000] Freeing unused kernel memory: 140k freed
> [42949377.170000] NET: Registered protocol family 1
> [42949379.080000] Adding 497972k swap on /dev/hda1.  Priority:-1 extents:1
> [42949379.180000] EXT3 FS on hda2, internal journal
> ...
> [42949421.150000] pwc Dumping frame 39 (last message).
> [42949421.220000] pwc Dumping frame 38 (last message).
> [42949425.770000] eth1: no IPv6 routers present

[Added CC from a similar thread "early printk timings way off"]

It's using the jiffies counter, and converting that into seconds.
Jiffies are always set to roll over soon, so the times will be high at
start up.  If you switch to use the tsc as your timer (instead of HPET
or PM), you will get the time from tsc instead, and not only will they
be much smaller, but they will be much more precise (not the ms
resolution you have here, or is that 4ms resolution?).

Also, am I the only one that would prefer to always use the tsc (on x86)
for sched_clock when possible, no matter which timer I choose?  I
usually put in hacks to make sched_clock always return the tsc, since it
is much better to see how long something takes, instead of seeing five
printks with the same time.

-- Steve


