Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272877AbTHERF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272553AbTHERDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:03:19 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:5517 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S272949AbTHERAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:00:14 -0400
Subject: Re: [PATCH] O11int for interactivity
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, piggin@cyberone.com.au, wli@holomorphy.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030804225532.494bfd31.akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org>
	 <20030802225513.GE32488@holomorphy.com>
	 <200308030119.47474.m.c.p@wolk-project.de>
	 <200308042106.51676.m.c.p@wolk-project.de>
	 <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au>
	 <20030805024103.GM32488@holomorphy.com> <3F2F1F80.7060207@cyberone.com.au>
	 <20030805031341.GN32488@holomorphy.com> <3F2F231C.3030901@cyberone.com.au>
	 <20030805033119.GO32488@holomorphy.com> <3F2F26BA.3060904@cyberone.com.au>
	 <200308050454.h754sBqM004950@turing-police.cc.vt.edu>
	 <20030804225532.494bfd31.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060102809.3174.15.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 05 Aug 2003 19:00:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 07:55, Andrew Morton wrote:

> Another possibility is that xmms is getting stuck in a read.  The
> anticipatory scheduler is currently rather tuned for throughput.  Judging
> by the vmstat trace which was posted, we have a classic
> read-stream-vs-write-stream going on.  We trade off latency versus
> throughput; perhaps wrongly.  You can decrease latency (at the expense of
> throughput) by decreasing the settings in /sys/block/hda/queue/iosched.
> 
> To a point, it is a nice linear tradeoff, and someone should put the time
> in to tweak and characterise it.

I believe it was my trace wli posted.
No swapping was going on, swappiness set to 30

X was quite jerky and uninteractive during this and sometimes it froze
for up to 5 seconds (the sound usually stopped during the freezing).

Since there wasn't any swapping going on and quite a lot of cpu left we
either have quite some latency when reading back parts of X that
previously got discarded or massive stalls in kernelspace somewhere.

One thing I noticed was that when evolution started checking for new
mail in a lot of folders I get a lot of seeks and the throughput
naturally decreased but X got really responsive again. This points away
from X beeing discarded and read back in from disk since that would take
some time with all those seeks as well.

The machine this was tested on is a pIII 700 with 704MB ram and IDE
disks (everything was against the same disk)
 
-- 
/Martin
