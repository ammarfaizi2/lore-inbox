Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbUKDE54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUKDE54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUKDE54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:57:56 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:56547 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262070AbUKDE5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:57:41 -0500
Date: Thu, 04 Nov 2004 13:57:21 +0900 (JST)
Message-Id: <20041104.135721.08317994.t-kochi@bq.jp.nec.com>
To: ak@suse.de
Cc: steiner@sgi.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <20041104040713.GC21211@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com>
	<20041104.105908.18574694.t-kochi@bq.jp.nec.com>
	<20041104040713.GC21211@wotan.suse.de>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Andi Kleen <ak@suse.de>
Subject: Re: Externalize SLIT table
Date: Thu, 4 Nov 2004 05:07:13 +0100

> > Why not export node_distance() under sysfs?
> > I like (1).
> > 
> > (1) obey one-value-per-file sysfs principle
> > 
> > % cat /sys/devices/system/node/node0/distance0
> > 10
> 
> Surely distance from 0 to 0 is 0?

According to the ACPI spec, 10 means local and other values
mean ratio to 10.  But what the distance number should mean
mean is ambiguous from the spec (e.g. some veondors interpret as
memory access latency, others interpret as memory throughput
etc.)
However relative distance just works for most of uses, I believe.

Anyway, we should clarify how the numbers should be interpreted
to avoid confusion.

How about this?
"The distance to itself means the base value.  Distance to
other nodes are relative to the base value.
0 means unreachable (hot-removed or disabled) to that node."

(Just FYI, numbers 0-9 are reserved and 255 (unsigned char -1) means
unreachable, according to the ACPI spec.)

> > % cat /sys/devices/system/node/node0/distance1
> > 66
> 
> > 
> > (2) one distance for each line
> > 
> > % cat /sys/devices/system/node/node0/distance
> > 0:10
> > 1:66
> > 2:46
> > 3:66
> > 
> > (3) all distances in one line like /proc/<PID>/stat
> > 
> > % cat /sys/devices/system/node/node0/distance
> > 10 66 46 66
> 
> I would prefer that. 

Ah, I missed the following last sentence in
Documentation/filesystems/sysfs.txt:

|Attributes should be ASCII text files, preferably with only one value
|per file. It is noted that it may not be efficient to contain only
|value per file, so it is socially acceptable to express an array of
|values of the same type. 

If an array is acceptable, I would prefer (3), too.

---
Takayoshi Kochi
