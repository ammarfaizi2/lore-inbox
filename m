Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319223AbSIFQpL>; Fri, 6 Sep 2002 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319229AbSIFQpL>; Fri, 6 Sep 2002 12:45:11 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:48907 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319223AbSIFQpK>; Fri, 6 Sep 2002 12:45:10 -0400
Message-ID: <3D78DFC9.26BF8CC5@zip.com.au>
Date: Fri, 06 Sep 2002 10:03:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] iowait stats for 2.5.33
References: <Pine.LNX.4.44L.0209061332190.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> Hi,
> 
> the following patch, against 2.5.33-mm4, implements iowait
> statistics in /proc/stat.

trivial:  I'd be inclined to use:

void iowait_schedule()
{
	atomic_inc(...);
	schedule();
	atomic_dec(...);
}

less trivial: there are times when an io wait is deliberate:
in the context of balance_dirty_pages(), and (newly) in the
context of page reclaim when current->backing_dev_info is
non-zero.

Given that this is a deliberate throttling sleep, perhaps it
should not be included in the accounting?   That way we only
account for the accidental, undesirable sleeps, and reads
and such.
