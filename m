Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTITBcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 21:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTITBcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 21:32:09 -0400
Received: from dyn-ctb-210-9-246-80.webone.com.au ([210.9.246.80]:6405 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261368AbTITBcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 21:32:06 -0400
Message-ID: <3F6BAE10.4010802@cyberone.com.au>
Date: Sat, 20 Sep 2003 11:32:00 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ludovico Gardenghi <dunadan@libero.it>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Badness in as_completed_request in 2.6.0-test5-bk3
References: <20030916081917.GA2960@ripieno.somiere.org>
In-Reply-To: <20030916081917.GA2960@ripieno.somiere.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ludovico Gardenghi wrote:

>[I'm very sorry if this message appears 2 or 3 times, but I sent it once
>with a @despammed.com address; their DNS appears to be down in this
>period so vger.kernel.org didn't accept my mail.]
>
>Hello.
>
>I've read about this error and that it should have been patched in
>2.6.0-test5-bk3.
>
>I tried it because I got a lot of them with 2.6.0-test5 while removing
>lots of files (i.e. while starting sn at boot time), but I got the same error
>messages with 2.6.0-test5-bk3; moreover, i had also some "attempt to
>access beyond end of device" errors while trying to read a file from the
>same partition. Here are the messages:
>

Hi Ludovico,

Thanks for the report. The AS messages should be harmless. The warn
statement is an incorrect assertion (I'm actually surprised the only
reports of it are IDE TCQ). It should not be the cause of the attempt
to access beyond the end of device messages.

I think IDE TCQ is not 100% stable at the moment (Jens?) and you have
to do things like ensure only one drive on the cable (not a master and
slave). Your best option is to turn TCQ off. You could try booting with
the argument elevator=deadline, however. That would fix it if it were
an AS problem.

