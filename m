Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbUK0AF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUK0AF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUK0AF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:05:27 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:12983 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262481AbUKZX5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 18:57:04 -0500
Message-ID: <41A7C2CA.1030008@yahoo.com.au>
Date: Sat, 27 Nov 2004 10:56:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Out of memory, but no OOM Killer? (2.6.9-ac11)
References: <20041126224722.GK30987@charite.de>
In-Reply-To: <20041126224722.GK30987@charite.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt wrote:
> rsync seems to want lots of memory, yet the OOM killer doesn't strike.
> Subsequently, that machine died an ugly death until delivered by a
> power-cycle.
> 
> Why doesn't the OOM killer reap rsync?

This could be the problem where fragmented memory causes atomic higher
order allocations to fail, for which there is a fix in -mm, which should
make its way into 2.6.11.

Also, the increased atomic memory reserves in current 2.6-bk should
alleviate the problem.

As a temporary workaround, you can increase /proc/sys/vm/min_free_kbytes

BTW. what does `free` say when the allocation failures are happening?
