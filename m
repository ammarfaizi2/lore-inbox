Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVKOSVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVKOSVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVKOSVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:21:04 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:65248 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S964987AbVKOSVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:21:03 -0500
Date: Wed, 16 Nov 2005 03:20:45 +0900 (JST)
Message-Id: <20051116.032045.98162396.okuyamak@dd.iij4u.or.jp>
To: evan@coolrunningconcepts.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Timer idea
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Evan,

>>>>> "Evan" == evan  <evan@coolrunningconcepts.com> writes:
Evan> I was thinking about benchmarking, profiling, and various other applications
Evan> that might need frequent access to the current time.  Polling timers or
Evan> frequent timer signal delivery both seem like there would be a lot of overhead.
Evan>  I was thinking it would be nice if you could just read the time information
Evan> without making an OS call.

This will only work on IA32...but..

I usually use "Time Slice Counter" which is 64bit register counting
up the CPU Freq for this purpose. Since it's built into CPU, no OS
call overhead happens. Also, because now-a-day CPU runs in very high
speed, each count will give you upto 0.3nsec accuracy.

Speed step technology might slow the CPU Freq, so it's true that
things aren't as accurate as it used to be. But this is the best I
can find.

I though similar counter is available for PowerPC too.
# At least, PPC601 had something similar.


Evan> I figure the kernel keeps accurate records of current time information and the
Evan> values of various timers.  I then had the idea that one could have a /dev or
Evan> maybe a /proc entry that would allow you to mmap() the kernel records (read
Evan> only) and then you could read this information right from the kernel without
Evan> any overhead.

There is overhead.

If you mmap(), address is reserved, but shall not have memory
assigned yet. When you read the address, exception will occur, and
then memory will be attached. THIS action is overhead.

Also, once it's attached, there's no way for OS to know when that
mapped page can be freed, to fill in newer value.

I don't think mmap() idea will work as good as it seems.
I might be making mistake, though.

best regards,
---- 
Kenichi Okuyama
