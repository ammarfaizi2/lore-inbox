Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbUK0AiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUK0AiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUK0Aeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:34:37 -0500
Received: from mail.charite.de ([160.45.207.131]:10641 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S263076AbUK0Ad6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:33:58 -0500
Date: Sat, 27 Nov 2004 01:33:53 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Out of memory, but no OOM Killer? (2.6.9-ac11)
Message-ID: <20041127003353.GQ30987@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041126224722.GK30987@charite.de> <41A7C2CA.1030008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41A7C2CA.1030008@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin <nickpiggin@yahoo.com.au>:

> This could be the problem where fragmented memory causes atomic higher
> order allocations to fail, for which there is a fix in -mm, which should
> make its way into 2.6.11.

I see. rsync requested a big chunk of memory, but failed due to the
fragmentation of free memory? my "sar" output shows lots of free memory and
lots of unused swap:

03:55:01    kbmemfree kbmemused  %memused kbbuffers  kbcached kbswpfree kbswpused  %swpused  kbswpcad
04:55:01         2852    512048     99.45      2340    466792   2008084 0    0.00         0
05:05:02         2328    512572     99.55       500    467884   2008084 0    0.00         0
05:15:02         2008    512892     99.61       536    468664   2008084 0    0.00         0
05:25:01        31152    483748     93.95      1804    436728   2008084 0    0.00         0
05:35:01         4056    510844     99.21      5668    452856   2008084 0    0.00         0
05:45:01       129908    384992     74.77       836    305232   2008084 0    0.00         0
05:55:02         2376    512524     99.54       444    464200   2008084 0    0.00         0
06:05:02         1952    512948     99.62       608    465736   2008084 0    0.00         0
06:15:02         1576    513324     99.69       424    465580   2008084 0    0.00         0

for reference:
Nov 26 05:58:19 backup-in -- MARK --
Nov 26 06:02:04 backup-in kernel: rsync: page allocation failure. order:3, mode:0x20

> Also, the increased atomic memory reserves in current 2.6-bk should
> alleviate the problem.

2.4.27 doesn't seem to expose the problem either
 
> As a temporary workaround, you can increase /proc/sys/vm/min_free_kbytes

# cat /proc/sys/vm/min_free_kbytes
724

I increased that to 7240 now.

> BTW. what does `free` say when the allocation failures are happening?

see sar output above.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
