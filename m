Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbTDHXMJ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTDHXMJ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:12:09 -0400
Received: from [12.47.58.221] ([12.47.58.221]:31211 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262561AbTDHXMI (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:12:08 -0400
Date: Tue, 8 Apr 2003 15:22:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.5 io statistics?
Message-Id: <20030408152215.00b7beca.akpm@digeo.com>
In-Reply-To: <20030408155858.GB27912@work.bitmover.com>
References: <20030408155858.GB27912@work.bitmover.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 23:23:38.0707 (UTC) FILETIME=[E27FDA30:01C2FE25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> wrote:
>
> Is there a writeup of the changes anywhere?  I'd like to port cstat to 2.5.
> Cstat is sort of a netstat/vmstat combo:
> 
> load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
> 0.00  19M 562M  48M 4.0K   12K   0   0   0   0  137   25  267   83    0   0 100
> 0.00  18M 563M  48M   0    12K   0   0   0   0  133   22  258   77    0   1  99

It's currently undergoing a bit of change.

In 2.5.67 all IO activity is monitored by opening and reading
/sys/block/hda/stat.  This certainly doesn't scale when you have thousands of
disks, so there's a patch in -mm which performs runtime aggregation of global
stats and exposes that via /proc/diskstats.

So if you want to monitor the "global" IO activity, you don't need to open all
those sysfs files.

I don't know if the aggregate disk stats patch is ready to go yet.  I'm
awaiting testing results, conversion of userspace tools, etc.  I just plonked
it in there and haven't heard anything since.

As far as I know, neither the format of the sysfs file nor the format of
/proc/diskstats is documented anywhere.

Perhaps Rick can prepare a description for inclusion under Dcumentation/
somewhere?

