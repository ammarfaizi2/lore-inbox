Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWGCTvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWGCTvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGCTvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:51:41 -0400
Received: from md2.t-2.net ([84.255.209.71]:32346 "EHLO md2.t-2.net")
	by vger.kernel.org with ESMTP id S1751268AbWGCTvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:51:41 -0400
Subject: LTT patch for 2.6.16
From: Samo Pogacnik <samo_pogacnik@t-2.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 03 Jul 2006 21:59:59 +0200
Message-Id: <1151956800.3466.22.camel@racek>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Junkmail-Status: score=10/50, host=md2.t-2.net
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090204.44A9733D.002B,ss=1,fgs=0,
	ip=84.255.254.67,
	so=2006-03-30 10:46:40,
	dmn=5.2.4/2006-05-04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If someone is interested, here is modified version of the 2.6.9/10 ltt
patch for the newer 2.6.16 kernel. This kernel now supports (simplified)
relayfs implementation, which has been used by this patch. Patch is
still far from being complete and bug free, but looks usable to me on my
i386 Nehemiah target, together with a slightly modified ltt-0.9.6-pre5
userspace tracing tools. 

Patch URL: http://84.255.254.67/ltt-linux-2.6.16.patch
Tools URL: http://84.255.254.67/ltt-0.9.6-pre5.tar.gz

Current status of functionality:

0. Current patch only supports i386 architecture specifics, since I
wanted to limit the area of needed modifications and I would like to
explore if it is sensible to remove all those spreaded trace points
around the kernel by using different mechanism. Anyway, at current state
other architectures should not be to difficult to add, by adjusting
arcitecture specifics of the 2.6.9 ltt kernel patch, for example.

1. Locking and lockless options of the tracedaemon tool result in the
same operation within the kernel, except for the different startup
requirements mostly enforced by original tracedaemon. Basicaly subbuffer
switches (together with writing start buffer and end buffer events) and
subbuffer space reservation for each event are being hopefully protected
with a spinlock.

2. Multiple starting and stopping of collecting events has been
protected and synchronised via an extra semaphore.

3. Timestamping works via gettimaofday (defined as generic) and via TSC
counter on i386 (defined as arch specific). This functionality was
collected in separate files, that can be patched and used separately
from ltt.

4. Works in either tracer (tracedaemon running for the time duration
specified - no subbuffer overwrite) or flight recorder (tracedaemon run
just to collect current buffer content of circular subbuffers -
overwrite relayfs operation) tracing mode.

5. Only one tracer started at once.

6. SMP - per cpu files need to be checked and cleaned.

7. Both tracer and flight recorder modes collect all events by default.

8. Custom events can be seen in both tracing modes.


If something has not been done correctly, please let me know.

Finally, many thanks to original authors of LTT as well as to all Linux
community for the oportunity to use, modify and learn from your source
code.

regards, Samo

