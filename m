Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUFHFh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUFHFh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 01:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbUFHFh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 01:37:28 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56080 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264229AbUFHFhZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 01:37:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tim Connors <tconnors+linuxkernel1086656992@astro.swin.edu.au>,
       John Bradford <john@grabjohn.com>
Subject: Re:  why swap at all?
Date: Tue, 8 Jun 2004 08:29:35 +0300
X-Mailer: KMail [version 1.4]
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
References: <40BB88B5.8080300@ezrs.com> <200406010910.i519AWsm000213@81-2-122-30.bradfords.org.uk> <slrn-0.9.7.4-20652-23232-200406081109-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-20652-23232-200406081109-tc@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406080829.35948.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 June 2004 04:18, Tim Connors wrote:
> I just got an interesting problem - possibly (or not?) related to
> this:
>
> I have my laptop with 256MB of RAM, running 2.4.25-pre7, uptime 48
> days. Every morning, I come in and have to wait 2 minutes while
> everything comes back into RAM, after the daily slocate. So I did a
> swapoff -a, and it failed despite all the applications and cache and
> tmpfs adding up to far less than 256MB (more like 128).
>
> I closed mozilla, which let me do a swapoff -a.
>
> All was well for a few days, but then thismorning, my partitions were
> mounted ro, and an oops was in syslog at the same time as all the
> slocate work:
[alloc failures + oops snipped]

prolonged oom condition triggers lots of rarely user error paths
in kernel (and applications). Most probably slocate hit one of bugs
still living in one of them.

> So OOM - but why? The cache was registering 65MB used.
> 24353,23> cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  262647808 256618496  6029312        0  4820992 67239936
> Swap:        0        0        0
> MemTotal:       256492 kB
> MemFree:          5888 kB
> MemShared:           0 kB
> Buffers:          4708 kB
> Cached:          65664 kB
> SwapCached:          0 kB
> Active:          77944 kB
> Inactive:       142308 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       256492 kB
> LowFree:          5888 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB

Maybe this is not the state of the meminfo at the time of oom
condition. oops killed the task and had freed its memory,
which is now used by cache.

> Why was it so eager to kill applications, and not reclaim some of that
> swap space? Is this a problem that is known on 2.4, and can't be fixed
> (I can't use 2.6 on my laptop yet, far too many problems to even
> start - eg the suspend to ram on APM thread).
>
> Is there another output of a /proc file you want? I'll try not to get
> the urge to use/reboot the box in the meantime.

vmstat log of this event may be useful.
-- 
vda
