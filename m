Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUBNPAf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUBNPAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:00:35 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:32470 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S261784AbUBNPAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:00:34 -0500
Message-ID: <402E380B.8070806@jburgess.uklinux.net>
Date: Sat, 14 Feb 2004 15:00:27 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jon Burgess <lkml@jburgess.uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <402A7CA0.9040409@jburgess.uklinux.net> <20040212015626.48631555.akpm@osdl.org>
In-Reply-To: <20040212015626.48631555.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>So you'll see that instead of a single full-bandwidth
>write, we do two half-bandwidth writes.  If it weren't for disk writeback
>caching, it would be as much as 4x slower.
>
Write caching does indeed make a big difference. Here is a test run on a 
drive with and without write caching (hdparm -W 0/1). The test was done 
on 2.6.2 with ext3 and shows the write speed in MB/s:

Write Cache   1 Stream   2 Streams
Enabled       21.54      3.66
Disabled      18.11      0.46  

The two stream case is almost 10x slower without write caching.
I don't think this explains the difference between 2.4 and 2.6 unless 
one of them changes the write cache mode of the drive.

    Jon

